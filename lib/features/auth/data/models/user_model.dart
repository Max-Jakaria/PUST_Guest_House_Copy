import 'package:pust_guest_house/core/common/entities/user.dart';

class MyUserModel extends MyUser {
  MyUserModel({
    super.id,
    super.name,
    super.email,
    super.department,
    super.phone,
    super.title,
    super.password,
    super.profile_picture,
    super.user_type,
  });

  factory MyUserModel.fromJson(Map<String, dynamic> json) {
    // print("parse json is : $json");
    return MyUserModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      department: json['department'],
      phone: json['phone'],
      title: json['title'],
      profile_picture: json['profile_picture'],
      user_type: json['user_type'],
    );
  }

  // Map<String, dynamic> getUser() {
  //   return {
  //     'name' : name,
  //     'email' : email,
  //     'password' : password,
  //     'department' : department,
  //     'phone' : phone,
  //     'title' : title,
  //   };
  // }
}
