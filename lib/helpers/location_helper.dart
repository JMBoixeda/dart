import 'dart:convert';

import 'package:http/http.dart' as http;

const GOOGLE_API_KEY = 'AIzaSyBFzlSdxA71rFb4fTRWbM9TuBr1SlLw6jw';
const GOOGLE_API_KEY2 = 'AIzaSyAva_RCQx14A22mmc0-Dji4VaZ2Go0L6pQ';
const GOOGLE_API_KEY3 = 'AIzaSyCNzjvgW35iPCZHfBN1OoWSxTZRu8AMyeo';

class LocationHelper {
  static String generateLocationPreviewImage(
      {double latitude, double longitude}) {
    return 'https://maps.googleapis.com/maps/api/staticmap?center=$latitude,$longitude&zoom=13&size=600x300&maptype=roadmap&markers=color:red%7Clabel:C%7C$latitude,$longitude&key=$GOOGLE_API_KEY3';
    // return 'https://maps.googleapis.com/maps/api/staticmap?center=40.714%2c%20-73.998&zoom=12&size=400x400&key=$GOOGLE_API_KEY3';
  }

  static Future<String> getInstallationAddress(double lat, double lng) async {
    final url =
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$lng&key=$GOOGLE_API_KEY3';
    final response = await http.get(url);
    return json.decode(response.body)['results'][0]['formatted_address'];
  }

  static Future<http.Response> getGeoCodeAddress(String address) async {
    final url =
        'https://maps.googleapis.com/maps/api/geocode/json?address=$address&key=$GOOGLE_API_KEY3';
    final response = await http.get(url);
    return response;
  }

  static Future<http.Response> getGeoAddress(
      double latitude, double longitude) async {
    final url =
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=$latitude,$longitude&key=$GOOGLE_API_KEY3';
    final response = await http.get(url);
    return response;
  }

  static Future<http.Response> getGeoLocation() async {
    final url =
        'https://www.googleapis.com/geolocation/v1/geolocate?key=$GOOGLE_API_KEY3';

    Map data = {
      "homeMobileCountryCode": 310,
      "homeMobileNetworkCode": 410,
      "radioType": "gsm",
      "carrier": "Vodafone",
      "considerIp": "true",
      "cellTowers": [
        // See the Cell Tower Objects section below.
      ],
      "wifiAccessPoints": [
        // See the WiFi Access Point Objects section below.
      ]
    };
    //encode Map to JSON
    final body = json.encode(data);

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: body,
    );
    return response;
  }
}
