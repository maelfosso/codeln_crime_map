import 'package:meta/meta.dart';
import '../entities/entities.dart';

@immutable
class GooglePlace {
  final String id;
  final String name;
  final double latitude;
  final double longitude;

  GooglePlace(this.id, this.name, this.latitude, this.longitude);

  GooglePlace copyWith({double latitude, double longitude, String name, String id}) {
    return GooglePlace(
      id ?? this.id,
      name ?? this.name,
      latitude ?? this.latitude,
      longitude ?? this.longitude
    );
  }

  @override
  int get hashCode =>
      latitude.hashCode ^ longitude.hashCode ^ id.hashCode ^ name.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GooglePlace &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          longitude == other.longitude &&
          latitude == other.latitude &&
          name == other.name;

  @override
  String toString() {
    return 'GooglePlace{id: $id, name: $name, latitude: $latitude, longitude: $longitude}';
  }

  // GooglePlaceEntity toEntity() {
  //   return GooglePlaceEntity(task, id, note, complete);
  // }

  // static GooglePlace fromEntity(GooglePlaceEntity entity) {
  //   return GooglePlace(
  //     entity.task,
  //     complete: entity.complete ?? false,
  //     note: entity.note,
  //     id: entity.id,
  //   );
  // }
}
