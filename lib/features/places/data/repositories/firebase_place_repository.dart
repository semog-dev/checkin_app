import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:domain/domain.dart';

class FirebasePlaceRepository implements PlaceRepository {
  FirebasePlaceRepository(this._firestore);

  final FirebaseFirestore _firestore;

  CollectionReference<Map<String, dynamic>> get _col =>
      _firestore.collection('places');

  Map<String, dynamic> _toFirestore(Place place) {
    final json = place.toJson()..remove('id');
    json['createdAt'] = Timestamp.fromDate(place.createdAt);
    return json;
  }

  Place _fromFirestore(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data()!;
    final createdAt = data['createdAt'];
    if (createdAt is Timestamp) {
      data['createdAt'] = createdAt.toDate().toIso8601String();
    }
    return Place.fromJson({...data, 'id': doc.id});
  }

  @override
  Stream<List<Place>> watchPlaces(String userId) => _col
      .where('ownerId', isEqualTo: userId)
      .orderBy('createdAt', descending: true)
      .snapshots()
      .map((snap) => snap.docs.map(_fromFirestore).toList());

  @override
  Future<Place?> getPlaceById(String id) async {
    final doc = await _col.doc(id).get();
    if (!doc.exists) return null;
    return _fromFirestore(doc);
  }

  @override
  Future<void> createPlace(Place place) =>
      _col.doc(place.id).set(_toFirestore(place));

  @override
  Future<void> updatePlace(Place place) =>
      _col.doc(place.id).update(_toFirestore(place));

  @override
  Future<void> deletePlace(String id) => _col.doc(id).delete();
}
