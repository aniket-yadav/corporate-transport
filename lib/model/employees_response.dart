import 'package:corporatetransportapp/model/employee_model.dart';

class EmployeesResponse {
  bool? success;
  String? message;
  List<EmployeeModel>? data;

  EmployeesResponse({
    this.success,
    this.message,
    this.data,
  });

  factory EmployeesResponse.fromJson(Map<String, dynamic>? json) {
    return EmployeesResponse(
      success: json?['success'],
      message: json?['message'],
      data: json?['data']
          ?.map<EmployeeModel>((e) => EmployeeModel.fromJson(e))
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
