// Copyright 2018 The Flutter Architecture Sample Authors. All rights reserved.
// Use of this source code is governed by the MIT license that can be found
// in the LICENSE file.

import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:codeln_crime_map/models/models.dart';
import '../entities/entities.dart';

class FirebaseCrimePlacesRepository {
  final crimePlaceCollection = Firestore.instance.collection('crime_places');

  
  Future<void> saveCrimePlace(CrimePlace crimePlace) {
    return crimePlaceCollection.add(crimePlace.toEntity().toDocument());
  }

  
  Future<void> deleteCrimePlace(CrimePlace crimePlace) async {
    return crimePlaceCollection.document(crimePlace.id).delete();
  }

  
  Stream<List<CrimePlace>> crimePlaces() {
    return crimePlaceCollection.snapshots().map((snapshot) {
      return snapshot.documents
          .map((doc) => CrimePlace.fromEntity(CrimePlaceEntity.fromSnapshot(doc)))
          .toList();
    });
  }

  
  Future<void> updateCrimePlace(CrimePlace update) {
    return crimePlaceCollection
        .document(update.id)
        .updateData(update.toEntity().toDocument());
  }
}
