import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:domain/domain.dart';

class FirestoreGroupRepository implements GroupRepository {
  FirestoreGroupRepository(this._firestore);

  final FirebaseFirestore _firestore;

  CollectionReference<Map<String, dynamic>> get _col =>
      _firestore.collection('groups');

  Map<String, dynamic> _toFirestore(Group group) {
    final json = group.toJson()..remove('id');
    json['createdAt'] = Timestamp.fromDate(group.createdAt);
    return json;
  }

  Group _fromFirestore(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data()!;
    final createdAt = data['createdAt'];
    if (createdAt is Timestamp) {
      data['createdAt'] = createdAt.toDate().toIso8601String();
    }
    return Group.fromJson({...data, 'id': doc.id});
  }

  @override
  Stream<List<Group>> watchGroupsForUser(String userId) => _col
      .where('memberIds', arrayContains: userId)
      .snapshots()
      .map((snap) => snap.docs.map(_fromFirestore).toList());

  @override
  Future<Group?> getGroupById(String id) async {
    final doc = await _col.doc(id).get();
    if (!doc.exists) return null;
    return _fromFirestore(doc);
  }

  @override
  Future<void> createGroup(Group group) =>
      _col.doc(group.id).set(_toFirestore(group));

  @override
  Future<void> addMember(String groupId, String userId) =>
      _col.doc(groupId).update({
        'memberIds': FieldValue.arrayUnion([userId]),
      });

  @override
  Future<void> removeMember(String groupId, String userId) =>
      _col.doc(groupId).update({
        'memberIds': FieldValue.arrayRemove([userId]),
      });

  @override
  Future<Group?> findByInviteCode(String inviteCode) async {
    final snap = await _col
        .where('inviteCode', isEqualTo: inviteCode)
        .limit(1)
        .get();
    if (snap.docs.isEmpty) return null;
    return _fromFirestore(snap.docs.first);
  }
}
