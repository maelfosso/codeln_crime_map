import 'package:meta/meta.dart';
import '../entities/entities.dart';

@immutable
class CrimePlace {
  final String id;
  final String name;
  final double latitude;
  final double longitude;
  final int reportNumber;

  CrimePlace(this.latitude, this.longitude, {String name, int reportNumber = 0, String id})
      : this.name = name,
        this.reportNumber = reportNumber ?? 0,
        this.id = id;

  CrimePlace copyWith({double latitude, double longitude, String name, int reportNumber, String id}) {
    return CrimePlace(
      latitude ?? this.latitude,
      longitude ?? this.longitude,
      name: name ?? this.name,
      reportNumber: reportNumber ?? this.reportNumber,
      id: id ?? this.id
    );
  }

  @override
  int get hashCode =>
      latitude.hashCode ^ longitude.hashCode ^ reportNumber.hashCode ^ id.hashCode ^ name.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CrimePlace &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          longitude == other.longitude &&
          latitude == other.latitude &&
          reportNumber == other.reportNumber &&
          name == other.name;

  @override
  String toString() {
    return 'CrimePlace{id: $id, name: $name, latitude: $latitude, longitude: $longitude, reportNumber: $reportNumber}';
  }

  // CrimePlaceEntity toEntity() {
  //   return CrimePlaceEntity(task, id, note, complete);
  // }

  // static CrimePlace fromEntity(CrimePlaceEntity entity) {
  //   return CrimePlace(
  //     entity.task,
  //     complete: entity.complete ?? false,
  //     note: entity.note,
  //     id: entity.id,
  //   );
  // }
}
