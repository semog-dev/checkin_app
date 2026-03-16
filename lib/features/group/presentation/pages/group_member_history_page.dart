import 'package:checkin_app/features/group/presentation/providers/group_provider.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GroupMemberHistoryPage extends ConsumerStatefulWidget {
  const GroupMemberHistoryPage({
    super.key,
    required this.groupId,
    required this.memberId,
  });

  final String groupId;
  final String memberId;

  @override
  ConsumerState<GroupMemberHistoryPage> createState() =>
      _GroupMemberHistoryPageState();
}

class _GroupMemberHistoryPageState
    extends ConsumerState<GroupMemberHistoryPage> {
  int _daysBack = 30;

  @override
  Widget build(BuildContext context) {
    final profileAsync = ref.watch(memberProfileProvider(widget.memberId));
    final historyAsync = ref.watch(
      memberHistoryProvider((userId: widget.memberId, daysBack: _daysBack)),
    );

    return Scaffold(
      appBar: AppBar(
        title: profileAsync.when(
          loading: () => const Text('Histórico'),
          error: (_, __) => const Text('Histórico'),
          data: (profile) => Text(
            profile != null ? 'Histórico de ${profile.displayName}' : 'Histórico',
          ),
        ),
      ),
      body: Column(
        children: [
          profileAsync.whenOrNull(
                data: (profile) =>
                    profile != null ? _ProfileHeader(profile: profile) : null,
              ) ??
              const SizedBox.shrink(),
          _TimeFilter(
            selected: _daysBack,
            onChanged: (days) => setState(() => _daysBack = days),
          ),
          const Divider(height: 1),
          Expanded(
            child: historyAsync.when(
              loading: () =>
                  const Center(child: CircularProgressIndicator()),
              error: (e, _) => Center(child: Text('Erro: $e')),
              data: (entries) => entries.isEmpty
                  ? const Center(
                      child: Text('Nenhum check-in no período'),
                    )
                  : ListView.builder(
                      itemCount: entries.length,
                      itemBuilder: (context, i) {
                        final (event, placeName) = entries[i];
                        return _HistoryEventTile(
                          event: event,
                          placeName: placeName,
                        );
                      },
                    ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ProfileHeader extends StatelessWidget {
  const _ProfileHeader({required this.profile});

  final UserProfile profile;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      color: colorScheme.surfaceContainerLow,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          CircleAvatar(
            radius: 24,
            backgroundImage: profile.photoUrl != null
                ? NetworkImage(profile.photoUrl!)
                : null,
            child: profile.photoUrl == null
                ? Text(
                    profile.displayName.isNotEmpty
                        ? profile.displayName[0].toUpperCase()
                        : '?',
                    style: const TextStyle(fontSize: 20),
                  )
                : null,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  profile.displayName,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Text(
                  profile.email,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: colorScheme.outline,
                      ),
                ),
              ],
            ),
          ),
          _StatusChip(status: profile.status),
        ],
      ),
    );
  }
}

class _StatusChip extends StatelessWidget {
  const _StatusChip({required this.status});

  final UserStatus status;

  @override
  Widget build(BuildContext context) {
    return Chip(
      avatar: CircleAvatar(
        radius: 5,
        backgroundColor: _color,
      ),
      label: Text(_label),
      padding: EdgeInsets.zero,
      visualDensity: VisualDensity.compact,
    );
  }

  Color get _color => switch (status) {
        UserStatus.online => Colors.green,
        UserStatus.busy => Colors.orange,
        UserStatus.away => Colors.yellow,
        UserStatus.offline => Colors.grey,
      };

  String get _label => switch (status) {
        UserStatus.online => 'Online',
        UserStatus.busy => 'Ocupado',
        UserStatus.away => 'Ausente',
        UserStatus.offline => 'Offline',
      };
}

class _TimeFilter extends StatelessWidget {
  const _TimeFilter({required this.selected, required this.onChanged});

  final int selected;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: SegmentedButton<int>(
        segments: const [
          ButtonSegment(value: 7, label: Text('7 dias')),
          ButtonSegment(value: 30, label: Text('30 dias')),
          ButtonSegment(value: 90, label: Text('90 dias')),
        ],
        selected: {selected},
        onSelectionChanged: (set) => onChanged(set.first),
      ),
    );
  }
}

class _HistoryEventTile extends StatelessWidget {
  const _HistoryEventTile({required this.event, this.placeName});

  final CheckInEvent event;
  final String? placeName;

  @override
  Widget build(BuildContext context) {
    final isEnter = event.type == CheckInEventType.enter;
    final colorScheme = Theme.of(context).colorScheme;
    final dt = event.timestamp.toLocal();
    final dateStr =
        '${dt.day.toString().padLeft(2, '0')}/${dt.month.toString().padLeft(2, '0')}/${dt.year}';
    final timeStr =
        '${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}';

    return ListTile(
      leading: CircleAvatar(
        backgroundColor: isEnter
            ? colorScheme.primaryContainer
            : colorScheme.surfaceContainerHighest,
        child: Icon(
          isEnter ? Icons.login : Icons.logout,
          color: isEnter ? colorScheme.primary : colorScheme.outline,
          size: 20,
        ),
      ),
      title: Text(placeName ?? event.placeId),
      subtitle: Text('$dateStr às $timeStr'),
      trailing: Text(
        isEnter ? 'Entrada' : 'Saída',
        style: TextStyle(
          color: isEnter ? colorScheme.primary : colorScheme.outline,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
