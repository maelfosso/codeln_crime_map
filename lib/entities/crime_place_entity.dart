import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class CrimePlaceEntity extends Equatable {
  final String id;
  final double latitude;
  final double longitude;

  const CrimePlaceEntity(this.id, this.latitude, this.longitude);

  Map<String, Object> toJson() {
    return {
      "latitude": latitude,
      "longitude": longitude,
      "id": id,
    };
  }

  @override
  List<Object> get props => [id, latitude, longitude];

  @override
  String toString() {
    return 'CrimePlaceEntity { longitude: $longitude, latitude: $latitude, id: $id }';
  }

  static CrimePlaceEntity fromJson(Map<String, Object> json) {
    return CrimePlaceEntity(
      json["id"] as String,
      json["latitude"] as double,
      json["longitude"] as double,
    );
  }

  static CrimePlaceEntity fromSnapshot(DocumentSnapshot snap) {
    print('\n[CRIME PLACE ENTITY] fromSnapshot - ${snap.documentID} - ${snap.data.values}');
    
    return CrimePlaceEntity(
      snap.documentID,
      snap.data['latitude'],
      snap.data['longitude']
    );
  }

  Map<String, Object> toDocument() {
    return {
      "id": id,
      "longitude": longitude,
      "latitude": latitude,
    };
  }
}
