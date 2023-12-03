import 'package:equatable/equatable.dart';

class AyoKeBaliModel extends Equatable {
  final int id;
  final String name;
  final int price;
  final String category;
  final String location;
  final double latitude;
  final double longitude;

  const AyoKeBaliModel({
    required this.id,
    required this.name,
    required this.price,
    required this.category,
    required this.location,
    required this.latitude,
    required this.longitude,
  });

  factory AyoKeBaliModel.fromJson(Map<String, dynamic> json) {
    return AyoKeBaliModel(
      id: json['destination_id'] ?? 0,
      name: json['name'] ?? "",
      price: json['perkiraan_biaya'] ?? 0,
      category: json['category'] ?? "",
      location: json['location'] ?? "",
      latitude: json['latitude'] ?? 0.0,
      longitude: json['longitude'] ?? 0.0,
    );
  }

  @override
  List<Object?> get props =>
      [id, name, price, category, location, latitude, longitude];
}
