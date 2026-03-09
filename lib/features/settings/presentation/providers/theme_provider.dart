import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

const _kBoxName = 'settings';
const _kThemeModeKey = 'theme_mode';

final themeModeProvider =
    NotifierProvider<ThemeModeNotifier, ThemeMode>(ThemeModeNotifier.new);

class ThemeModeNotifier extends Notifier<ThemeMode> {
  @override
  ThemeMode build() {
    final index = Hive.box<int>(_kBoxName).get(_kThemeModeKey) ?? 0;
    return ThemeMode.values[index.clamp(0, ThemeMode.values.length - 1)];
  }

  void setMode(ThemeMode mode) {
    state = mode;
    Hive.box<int>(_kBoxName).put(_kThemeModeKey, mode.index);
  }
}
