import 'package:shartflix/domain/entities/auth/user.dart';
import 'package:shartflix/domain/entities/profile/user_entity_profile.dart';

class UserModel {
  final String id;
  final String name;
  final String email;
  final String token;
  final String photoUrl;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.token,
    required this.photoUrl,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      token: json['token'] ?? '',
      photoUrl: json['photoUrl'] ?? '',
    );
  }

  User toEntity() {
    return User(
      id: id,
      name: name,
      email: email,
      token: token,
      photoUrl: photoUrl,
    );
  }

  UserEntity toUserEntity() {
    return UserEntity(
      id: id,
      name: name,
      email: email,
      token: token,
      photoUrl: photoUrl,
    );
  }
}
