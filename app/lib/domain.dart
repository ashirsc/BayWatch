import 'dart:convert';

class SpotStatus {
  String status;
  Map<String, int> ts;
  String happened;

  SpotStatus(String jsonSpotStatus) {
    dynamic obj = jsonDecode(jsonSpotStatus);
    status = obj['status'];
    happened = obj['happened'];
  }
}
