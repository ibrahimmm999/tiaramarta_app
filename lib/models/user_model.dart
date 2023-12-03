import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final int id;
  final String fullname;
  final String username;
  final String role;
  final String token;
  final String tokenMonitoringEnergy;

  const UserModel({
    required this.id,
    required this.fullname,
    required this.username,
    required this.role,
    required this.token,
    required this.tokenMonitoringEnergy,
  });

  factory UserModel.fromJson(Map<String, dynamic> json, String token) {
    return UserModel(
      id: json['id'] ?? 0,
      fullname: json['fullname'] ?? '',
      username: json['username'] ?? '',
      role: json['role'] ?? 'user',
      tokenMonitoringEnergy: json['token_monitoring_energy'] ?? '',
      token: token,
    );
  }

  @override
  List<Object?> get props =>
      [id, fullname, username, role, tokenMonitoringEnergy, token];
}
