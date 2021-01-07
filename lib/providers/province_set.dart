import 'package:flutter/material.dart';

import 'dart:io';

import 'package:flutter/foundation.dart';

import 'package:emc2/models/province.dart';
import 'package:emc2/helpers/db_helper.dart';

List<String> provincesDummy = [
  "Alava",
  "Almeria",
  "Albacete",
  "Badajoz",
  "Barcelona",
  "Madrid",
];

class Provinces with ChangeNotifier {
  List<Province> _provinces = provincesDummy.map((province) => Province(
        createdAt: DateTime.now(),
        id: DateTime.now().toString(),
        name: province,
      )).toList();

  List<Province> get provinces {
    return [..._provinces];
  }

  Province findById(String id) {
    return _provinces.firstWhere((province) => province.id == id);
  }

  Future<void> addProvince(
    String id,
    DateTime createdAt,
    String name,
  ) async {
    final newProvince = Province(
      id: DateTime.now().toString(),
      createdAt: DateTime.now(),
      name: name,
    );

    _provinces.add(newProvince);
    notifyListeners();
    DBHelper.insert('provincias', {
      'id': newProvince.id,
      'created': newProvince.createdAt,
      'name': newProvince.name,
    });
  }
}
