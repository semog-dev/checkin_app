import 'package:domain/domain.dart';
import 'package:flutter/material.dart';

class MemberStatusTile extends StatelessWidget {
  const MemberStatusTile({
    super.key,
    required this.profile,
    this.placeName,
  });

  final UserProfile profile;
  final String? placeName;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: profile.photoUrl != null
            ? NetworkImage(profile.photoUrl!)
            : null,
        child: profile.photoUrl == null
            ? Text(
                profile.displayName.isNotEmpty
                    ? profile.displayName[0].toUpperCase()
                    : '?',
              )
            : null,
      ),
      title: Text(profile.displayName),
      subtitle: Text(_subtitle),
      trailing: _StatusDot(status: profile.status),
    );
  }

  String get _subtitle {
    if (profile.currentPlaceId != null && placeName != null) {
      return 'Em: $placeName';
    }
    final lastSeen = profile.lastSeenAt;
    if (lastSeen != null) {
      return 'Visto ${_timeAgo(lastSeen)}';
    }
    return 'Offline';
  }

  String _timeAgo(DateTime dt) {
    final diff = DateTime.now().difference(dt);
    if (diff.inMinutes < 1) return 'agora';
    if (diff.inHours < 1) return 'há ${diff.inMinutes}min';
    if (diff.inDays < 1) return 'há ${diff.inHours}h';
    return 'há ${diff.inDays}d';
  }
}

class _StatusDot extends StatelessWidget {
  const _StatusDot({required this.status});
  final UserStatus status;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 12,
      height: 12,
      decoration: BoxDecoration(
        color: _color,
        shape: BoxShape.circle,
      ),
    );
  }

  Color get _color => switch (status) {
        UserStatus.online => Colors.green,
        UserStatus.busy => Colors.orange,
        UserStatus.away => Colors.yellow,
        UserStatus.offline => Colors.grey,
      };
}
