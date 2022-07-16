import 'dart:convert';
import 'dart:typed_data';

class EmployeeModel {
  String? employeeid;
  String? username;
  String? email;
  String? password;
  String? role;
  String? mobile;
  String? gender;
  String? age;
  String? empid;
  String? address;
  String? pincode;
  Uint8List? image;
  String? vehicleid;
  String? name;
  EmployeeModel({
    this.name,
    this.mobile,
    this.email,
    this.address,
    this.image,
    this.pincode,
    this.role,
    this.age,
    this.gender,
    this.password,
    this.username,
    this.vehicleid,
    this.empid,
    this.employeeid,
  });

  factory EmployeeModel.fromJson(Map<String, dynamic>? json) {
    return EmployeeModel(
        role: json?['role'],
        address: json?['address'],
        email: json?['email'],
        mobile: json?['mobile'],
        name: json?['name'],
        pincode: json?['pincode'],
        empid: json?['empid'],
        age: json?['age'],
        employeeid: json?['employeeid'],
        password: json?['password'],
        username: json?['username'],
        vehicleid: json?['vehicleid'],
        gender: json?['gender'],
        image: (json?['image'] != null && json!['image'].toString().isNotEmpty)
            ? base64Decode(json['image'])
            : null);
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> temp = {
      'role': role,
      'address': address,
      'email': email,
      'mobile': mobile,
      'name': name,
      'pincode': pincode,
      'empid': empid,
      'age': age,
      'employeeid': employeeid,
      'password': password,
      'username': username,
      'vehicleid': vehicleid,
      'gender': gender,
      'image': image != null ? base64Encode(image!) : null,
    };
    temp.removeWhere((key, value) => value == null);

    return temp;
  }
}
