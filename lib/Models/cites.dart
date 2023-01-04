import 'dart:convert';


class Cites {
  final String name;
    final double latitude;
    final double longitude;
    final String country;
    final String state;

    Cites({
        required this.name,
        required this.latitude,
        required this.longitude,
        required this.country,
        required this.state,
    });

    factory Cites.fromJson(Map<String, dynamic> json) => Cites(
        name: json["name"],
        latitude: json["latitude"].toDouble(),
        longitude: json["longitude"].toDouble(),
        country: json["country"],
        state: json["state"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "latitude": latitude,
        "longitude": longitude,
        "country": country,
        "state": state,
    };
}
List<Cites> citesFromJson(String str) => List<Cites>.from(json.decode(str).map((x) => Cites.fromJson(x)));

String citesToJson(List<Cites> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));