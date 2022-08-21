import 'package:corporatetransportapp/model/bill_model.dart';

class BillingResponse {
  bool? success;
  String? message;
  List<BillModel>? data;

  BillingResponse({
    this.success,
    this.message,
    this.data,
  });

  factory BillingResponse.fromJson(Map<String, dynamic>? json) {
    return BillingResponse(
      success: json?['success'],
      message: json?['message'],
      data:
          json?['data']?.map<BillModel>((e) => BillModel.fromJson(e)).toList(),
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
