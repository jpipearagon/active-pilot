

import 'package:aircraft/src/models/Locations.dart';
import 'package:aircraft/src/models/ProfileCountry.dart';

import 'rest_api.dart';

class LocationsApi {

  final RestApi _restApi = RestApi();

  Future<List<LocationUser>?> getLocations() async {
    try {
      List<dynamic> response = await _restApi.get(endPoint: "/api/locations");
      final list = response.map((data) {
        return LocationUser.fromJson(data);
      });
      return list.toList();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<List<ProfileCountry>?> getCountries() async {
    try {
      List<dynamic> response = await _restApi.get(endPoint: "/api/countries");
      final list = response.map((data) {
        return ProfileCountry.fromJson(data);
      });
      return list.toList();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}