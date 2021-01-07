import "dart:io";

import "package:flutter/foundation.dart";

class InstallationLocation {
  final double latitude;
  final double longitude;

  const InstallationLocation({
    @required this.latitude,
    @required this.longitude,
  });
}

class Installation {
  final int id;
  final String title;
  final String address;
  final String city;
  final String dp;
  final String state;
  final String powerinstalled;
  final String comsumption;
  final String facadeavailabiity;
  final String orientation;
  final InstallationLocation location;
  final File image;
  final int projectId;

  Installation({
    @required this.id,
    @required this.title,
    @required this.address,
    @required this.city,
    @required this.dp,
    @required this.state,
    @required this.powerinstalled,
    @required this.comsumption,
    @required this.facadeavailabiity,
    @required this.orientation,
    @required this.location,
    @required this.image,
    @required this.projectId,
  });
}
