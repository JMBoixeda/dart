import 'dart:convert';

import 'package:emc2/screens/installation_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../helpers/location_helper.dart';
import '../screens/map_screen.dart';
import '../models/installation.dart';

class LocationInput extends StatefulWidget {
  final Function onSelectInstallation;

  LocationInput(this.onSelectInstallation,
      {Key key})
      : super(key: key);

  @override
  _LocationInputState createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  String _previewImageUrl;

  void _showPreview(double lat, double lng) async {
    final staticMapImageUrl = LocationHelper.generateLocationPreviewImage(
      latitude: lat,
      longitude: lng,
    );
    setState(() {
      _previewImageUrl = staticMapImageUrl;
    });
  }

  Future<void> _getCurrentUserLocation() async {
    try {
      final locData = await Location().getLocation();
      var latitude = locData.latitude;
      var longitude = locData.longitude;

      final response = await LocationHelper.getGeoLocation();
      if (response.statusCode == 200) {
        final Map<String, dynamic> locDataMap = jsonDecode(response.body);
        latitude = locDataMap['location']['lat'];
        longitude = locDataMap['location']['lng'];
      }
      final installation = await _addressGeoCoding(latitude, longitude);

      _showPreview(latitude, longitude);
      widget.onSelectInstallation(installation, latitude, longitude);
    } catch (error) {
      return;
    }
  }

  Future<InstallationLocation> _startLocation() async {
    var initLocation = InstallationLocation(
      latitude: 37.422,
      longitude: -122.084,
    );
    final response = await LocationHelper.getGeoLocation();
    if (response.statusCode == 200) {
      final Map<String, dynamic> locDataMap = jsonDecode(response.body);
      initLocation = InstallationLocation(
        latitude: locDataMap['location']['lat'],
        longitude: locDataMap['location']['lng'],
      );
    }
    return initLocation;
  }

  Future<Installation> _addressGeoCoding(
      double latitude, double longitude) async {
    var initAddress;
    final response = await LocationHelper.getGeoAddress(latitude, longitude);
    if (response.statusCode == 200) {
      final Map<String, dynamic> addressData = jsonDecode(response.body);
      final addressComponents = addressData['results'][0]['address_components'];
      initAddress = Installation(
        id: null,
        title: null,
        address:
            "${addressComponents[1]['long_name']}, ${addressComponents[0]['long_name']}",
        city: addressComponents[2]['long_name'],
        dp: addressComponents[6]['long_name'],
        state: addressComponents[3]['long_name'],
        location: InstallationLocation(
          latitude: latitude,
          longitude: longitude,
        ),
        image: null,
      );
    }
    return initAddress;
  }

  Future<void> _selectOnMap() async {
    final initLocation = await _startLocation();
    final selectedLocation = await Navigator.of(context).push<LatLng>(
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (ctx) => MapScreen(
          isSelecting: true,
          initialLocation: initLocation,
        ),
      ),
    );
    if (selectedLocation == null) {
      return;
    }
    final installation = await _addressGeoCoding(
      selectedLocation.latitude,
      selectedLocation.longitude,
    );

    _showPreview(selectedLocation.latitude, selectedLocation.longitude);
    widget.onSelectInstallation(
        installation, selectedLocation.latitude, selectedLocation.longitude);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          height: 200,
          width: double.infinity,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: Colors.grey,
            ),
          ),
          child: _previewImageUrl == null
              ? Text(
                  'No se ha elegido ninguna ubicación',
                  textAlign: TextAlign.center,
                )
              : Image.network(
                  _previewImageUrl,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FlatButton.icon(
              onPressed: _getCurrentUserLocation,
              icon: Icon(Icons.location_on),
              label: Text(
                'Ubicación Actual',
              ),
              textColor: Theme.of(context).primaryColor,
            ),
            FlatButton.icon(
              onPressed: _selectOnMap,
              icon: Icon(Icons.map),
              label: Text(
                'Seleccionar sobre Mapa',
              ),
              textColor: Theme.of(context).primaryColor,
            ),
          ],
        )
      ],
    );
  }
}
