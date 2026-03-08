import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:domain/domain.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreUserRepository implements UserRepository {
  FirestoreUserRepository(this._firestore, this._auth);

  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;

  CollectionReference<Map<String, dynamic>> get _col =>
      _firestore.collection('users');

  Map<String, dynamic> _toFirestore(UserProfile profile) {
    final json = profile.toJson();
    final lastSeenAt = profile.lastSeenAt;
    if (lastSeenAt != null) {
      json['lastSeenAt'] = Timestamp.fromDate(lastSeenAt);
    }
    return json;
  }

  UserProfile _fromFirestore(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data()!;
    final lastSeenAt = data['lastSeenAt'];
    if (lastSeenAt is Timestamp) {
      data['lastSeenAt'] = lastSeenAt.toDate().toIso8601String();
    }
    return UserProfile.fromJson(data);
  }

  @override
  Stream<UserProfile?> watchCurrentUser() {
    final uid = _auth.currentUser?.uid;
    if (uid == null) return Stream.value(null);
    return _col.doc(uid).snapshots().map(
          (doc) => doc.exists ? _fromFirestore(doc) : null,
        );
  }

  @override
  Stream<UserProfile?> watchUserById(String uid) =>
      _col.doc(uid).snapshots().map(
            (doc) => doc.exists ? _fromFirestore(doc) : null,
          );

  @override
  Future<UserProfile?> getUserById(String uid) async {
    final doc = await _col.doc(uid).get();
    if (!doc.exists) return null;
    return _fromFirestore(doc);
  }

  @override
  Future<void> updateProfile(UserProfile profile) =>
      _col.doc(profile.uid).set(_toFirestore(profile), SetOptions(merge: true));

  @override
  Future<void> updateStatus(String uid, UserStatus status) =>
      _col.doc(uid).update({'status': status.name});
}
