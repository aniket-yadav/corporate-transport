import 'dart:convert';


class DriverModel {
  String? driverid;
  String? username;
  String? email;
  String? password;
  String? role;
  String? mobile;
  String? gender;
  String? age;
  String? experience;
  String? address;
  String? pincode;
  String? aadharno;
  String? image;
  String? vehicleid;
  String? name;
  DriverModel({
    this.name,
    this.mobile,
    this.email,
    this.address,
    this.image,
    this.pincode,
    this.role,
    this.aadharno,
    this.age,
    this.driverid,
    this.gender,
    this.experience,
    this.password,
    this.username,
    this.vehicleid,
  });

  factory DriverModel.fromJson(Map<String, dynamic>? json) {
    return DriverModel(
        role: json?['role'],
        address: json?['address'],
        email: json?['email'],
        mobile: json?['mobile'],
        name: json?['name'],
        pincode: json?['pincode'],
        aadharno: json?['aadharno'],
        age: json?['age'],
        experience: json?['experience'],
        password: json?['password'],
        username: json?['username'],
        vehicleid: json?['vehicleid'],
        driverid: json?['driverid'],
        gender: json?['gender'],
        image: json?['image'] );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> temp = {
      'role': role,
      'address': address,
      'email': email,
      'mobile': mobile,
      'name': name,
      'pincode': pincode,
      'aadharno': aadharno,
      'age': age,
      'experience': experience,
      'password': password,
      'username': username,
      'vehicleid': vehicleid,
      'driverid': driverid,
      'gender': gender,
      'image': image ,
    };
    temp.removeWhere((key, value) => value == null);

    return temp;
  }
}
