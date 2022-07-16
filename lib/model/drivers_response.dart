import 'package:corporatetransportapp/model/driver_model.dart';

class DriversResponse {
  bool? success;
  String? message;
  List<DriverModel>? data;

  DriversResponse({
    this.success,
    this.message,
    this.data,
  });

  factory DriversResponse.fromJson(Map<String, dynamic>? json) {
    return DriversResponse(
      success: json?['success'],
      message: json?['message'],
      data: json?['data']
          ?.map<DriverModel>((e) => DriverModel.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> temp = {
      'success': success,
      'message': message,
      'data': data?.map((e) => e.toJson()).toList(),
    };
    temp.removeWhere((key, value) => value == null);

    return temp;
  }
}
