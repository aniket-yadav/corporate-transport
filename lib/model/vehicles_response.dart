import 'package:corporatetransportapp/model/vehicle_model.dart';

class VehiclesResponse {
  bool? success;
  String? message;
  List<VehicleModel>? data;

  VehiclesResponse({
    this.success,
    this.message,
    this.data,
  });

  factory VehiclesResponse.fromJson(Map<String, dynamic>? json) {
    return VehiclesResponse(
      success: json?['success'],
      message: json?['message'],
      data: json?['data']
          ?.map<VehicleModel>((e) => VehicleModel.fromJson(e))
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
