import 'package:equatable/equatable.dart';

class RoomModel extends Equatable {
  final int id;
  final String name;
  final int price;
  final String linkVideo;
  final String desc;
  final int user;

  const RoomModel({
    required this.id,
    required this.name,
    required this.price,
    required this.linkVideo,
    required this.desc,
    required this.user,
  });

  factory RoomModel.fromJson(Map<String, dynamic> json) {
    return RoomModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? "",
      price: json['price'] ?? 0,
      linkVideo: json['url_video'] ?? "",
      desc: json['description'] ?? "",
      user: json['user'] ?? 0,
    );
  }

  @override
  List<Object?> get props => [id, name, price, linkVideo, desc, user];
}
