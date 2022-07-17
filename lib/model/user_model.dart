class User {
  String? name;
  String? mobile;
  String? email;
  String? address;
  String? city;
  String? district;
  String? pincode;
  String? image;
  String? role;
  String? userid;
  String? gender;
  String? age;
  String? aadharno;
  String? vehicleid;
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
    this.age,
    this.gender,
    this.userid,
    this.vehicleid,
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
      userid: json?['adminid'] ?? json?['driverid'] ?? json?['driverid'],
      age: json?['age'],
      gender: json?['gender'],
      image: json?['image'],
      vehicleid: json?['vehicleid'],
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> temp = {
      'role': role,
      'address': address,
      'city': city,
      'district': district,
      'pincode': pincode,
      'aadharno': aadharno,
      'adminid': userid,
      'age': age,
      'driverid': userid,
      'employeeid': userid,
      'email': email,
      'gender': gender,
      'mobile': mobile,
      'name': name,
      'image': image,
      'vehicleid': vehicleid,
    };
    temp.removeWhere((key, value) => value == null);

    return temp;
  }
}
