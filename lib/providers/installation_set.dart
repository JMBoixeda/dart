import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

import 'package:emc2/models/installation.dart';
import 'package:emc2/helpers/db_helper.dart';
import 'package:emc2/helpers/location_helper.dart';

class InstallationSet with ChangeNotifier {
  List<Installation> _items = [];

  List<Installation> get items {
    return [..._items];
  }

  Installation findById(int id) {
    return _items.firstWhere((place) => place.id == id);
  }

  Future<List<int>> addInstallation(
    String title,
    String addres1,
    String city,
    String dp,
    String state,
    String powerinstalled,
    String comsumption,
    String facadeavailabiity,
    String orientation,
    InstallationLocation pickedLocation,
    File pickedImage,
  ) async {
    final address = await LocationHelper.getInstallationAddress(
        pickedLocation.latitude, pickedLocation.longitude);
    final updatedLocation = InstallationLocation(
      latitude: pickedLocation.latitude,
      longitude: pickedLocation.longitude,
    );
    final projectId = Random.secure().nextInt(1000000);
    final newInstallation = Installation(
      id: Random.secure().nextInt(1000000),
      title: title,
      address: address,
      city: city,
      dp: dp,
      state: state,
      powerinstalled: powerinstalled,
      comsumption: comsumption,
      facadeavailabiity: facadeavailabiity,
      orientation: orientation,
      location: updatedLocation,
      image: pickedImage,
      projectId: projectId,
    );

    _items.add(newInstallation);
    notifyListeners();
    DBHelper.insert('user_installations', {
      'id': newInstallation.id,
      'title': newInstallation.title,
      'address': newInstallation.address,
      'city': newInstallation.city,
      'dp': newInstallation.dp,
      'state': newInstallation.state,
      'powerinstalled': newInstallation.powerinstalled,
      'comsumption': newInstallation.comsumption,
      'facadeavailabiity': newInstallation.facadeavailabiity,
      'orientation': newInstallation.orientation,
      'image': newInstallation.image.path,
      'loc_lat': newInstallation.location.latitude,
      'loc_lng': newInstallation.location.longitude,
      'project_id': newInstallation.projectId,
    });
    return [projectId, newInstallation.id];
  }

  Future<void> fetchAndSetInstallations() async {
    final dataList = await DBHelper.getData('user_installations');
    _items = dataList
        .map((item) => Installation(
              id: item['id'],
              title: item['title'],
              address: item['address'],
              city: item['city'],
              dp: item['dp'],
              state: item['state'],
              powerinstalled: item['powerinstalled'],
              comsumption: item['comsumption'],
              facadeavailabiity: item['facadeavailabiity'],
              orientation: item['orientation'],
              image: File(item['image']),
              location: InstallationLocation(
                latitude: item['loc_lat'],
                longitude: item['loc_lng'],
              ),
              projectId: item['project_id'],
            ))
        .toList();
    notifyListeners();
  }
}
