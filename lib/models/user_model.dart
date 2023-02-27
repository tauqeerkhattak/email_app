import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final String uid;
  final String email;
  final String name;

  const UserModel({required this.uid, required this.email, required this.name});

  UserModel copyWith({String? uid, String? email, String? name}) {
    return UserModel(
      uid: uid ?? this.uid,
      email: email ?? this.email,
      name: name ?? this.name,
    );
  }

  Map<String, String> toJson() {
    return <String, String>{
      'uid': uid,
      'name': name,
      'email': email,
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> data) {
    return UserModel(
      uid: data['uid'],
      email: data['email'],
      name: data['name'],
    );
  }

  @override
  List<String> get props => [uid, email, name];
}
