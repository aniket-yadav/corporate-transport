import 'package:corporatetransportapp/model/vehicle_model.dart';

class VehicleResponse {
  bool? success;
  String? message;
  VehicleModel? data;

  VehicleResponse({
    this.success,
    this.message,
    this.data,
  });

  factory VehicleResponse.fromJson(Map<String, dynamic>? json) {
    return VehicleResponse(
      success: json?['success'],
      message: json?['message'],
      data: VehicleModel.fromJson(json?['data'])
          ,
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> temp = {
      'success': success,
      'message': message,
      'data': data?.toJson(),
    };
    temp.removeWhere((key, value) => value == null);

    return temp;
  }
}
