import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:domain/domain.dart';

class FirebaseCheckInRepository implements CheckInRepository {
  FirebaseCheckInRepository(this._firestore);

  final FirebaseFirestore _firestore;

  CollectionReference<Map<String, dynamic>> get _col =>
      _firestore.collection('check_in_events');

  Map<String, dynamic> _toFirestore(CheckInEvent event) {
    final json = event.toJson()..remove('id');
    json['timestamp'] = Timestamp.fromDate(event.timestamp);
    return json;
  }

  CheckInEvent _fromFirestore(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data()!;
    final ts = data['timestamp'];
    if (ts is Timestamp) {
      data['timestamp'] = ts.toDate().toIso8601String();
    }
    return CheckInEvent.fromJson({...data, 'id': doc.id});
  }

  @override
  Future<void> recordEvent(CheckInEvent event) =>
      _col.doc(event.id).set(_toFirestore(event));

  @override
  Stream<List<CheckInEvent>> watchEventsForPlace(
    String placeId, {
    int limit = 50,
  }) =>
      _col
          .where('placeId', isEqualTo: placeId)
          .orderBy('timestamp', descending: true)
          .limit(limit)
          .snapshots()
          .map((snap) => snap.docs.map(_fromFirestore).toList());

  @override
  Future<List<CheckInEvent>> getEventsForUser(
    String userId, {
    required DateTime since,
  }) async {
    final snap = await _col
        .where('userId', isEqualTo: userId)
        .where('timestamp', isGreaterThan: Timestamp.fromDate(since))
        .orderBy('timestamp', descending: true)
        .get();
    return snap.docs.map(_fromFirestore).toList();
  }
}
