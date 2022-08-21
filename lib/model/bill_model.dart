class BillModel {
  String? billId;
  String? employeeId;
  String? bus;
  String? billingMonthYear;
  String? paymentStatus;
  String? amount;
  BillModel({
    this.billId,
    this.billingMonthYear,
    this.employeeId,
    this.bus,
    this.paymentStatus,
    this.amount,
  });

  factory BillModel.fromJson(Map<String, dynamic>? json) {
    return BillModel(
      billId: json?['billId'],
      billingMonthYear: json?['billingMonthYear'],
      bus: json?['bus'],
      employeeId: json?['employeeId'],
      paymentStatus: json?['paymentStatus'],
      amount: json?['amount'],
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> temp = {
      'billId': billId,
      'billingMonthYear': billingMonthYear,
      'bus': bus,
      'employeeId': employeeId,
      'paymentStatus': paymentStatus,
      'amount': amount,
    };
    temp.removeWhere((key, value) => value == null);

    return temp;
  }
}
