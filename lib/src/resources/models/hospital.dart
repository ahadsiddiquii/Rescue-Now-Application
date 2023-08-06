import 'dart:convert';

Hospital hospitalFromJson(String str) =>
    Hospital.fromJson(json.decode(str) as Map<String, dynamic>);

String hospitalToJson(Hospital data) => json.encode(data.toJson());

class Hospital {
  Hospital({
    required this.hospitalId,
    required this.placeName,
    required this.placeLatitude,
    required this.placeLongitude,
  });

  factory Hospital.fromJson(Map<String, dynamic> json) => Hospital(
        hospitalId: json['hospitalId'] as String,
        placeName: json['placeName'] as String,
        placeLatitude: json['placeLatitude'].toDouble() as double,
        placeLongitude: json['placeLongitude'].toDouble() as double,
      );

  String hospitalId;
  String placeName;
  double placeLatitude;
  double placeLongitude;

  Map<String, dynamic> toJson() => {
        'hospitalId': hospitalId,
        'placeName': placeName,
        'placeLatitude': placeLatitude,
        'placeLongitude': placeLongitude,
      };
}
