import 'dart:convert';
import 'dart:typed_data';

class User {
  String? name;
  String? mobile;
  String? email;
  String? address;
  String? city;
  String? district;
  String? pincode;
  Uint8List? image;
  String? role;
  String? adminid;
  String? driverid;
  String? employeeid;
  String? gender;
  String? age;
  String? aadharno;
  User({
    this.name,
    this.mobile,
    this.email,
    this.address,
    this.city,
    this.district,
    this.image,
    this.pincode,
    this.role,
    this.aadharno,
    this.adminid,
    this.age,
    this.driverid,
    this.employeeid,
    this.gender,
  });

  factory User.fromJson(Map<String, dynamic>? json) {
    return User(
        role: json?['role'],
        address: json?['address'],
        city: json?['city'],
        district: json?['district'],
        email: json?['email'],
        mobile: json?['mobile'],
        name: json?['name'],
        pincode: json?['pincode'],
        aadharno: json?['aadharno'],
        adminid: json?['adminid'],
        age: json?['age'],
        driverid: json?['driverid'],
        employeeid: json?['employeeid'],
        gender: json?['gender'],
        image: (json?['image'] != null && json!['image'].toString().isNotEmpty)
            ? base64Decode(json['image'])
            : null);

  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> temp = {
      'role': role,
      'address': address,
      'city': city,
      'district': district,
      'pincode':pincode,
      'aadharno':aadharno,
      'adminid':adminid,
      'age':age,
      'driverid':driverid,
      'employeeid':employeeid,
      'email': email,
      'gender':gender,
      'mobile': mobile,
      'name': name,
      'image': image != null ? base64Encode(image!) : null,
    };
    temp.removeWhere((key, value) => value == null);

    return temp;
  }
}
