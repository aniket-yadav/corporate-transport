class Response {
  bool? success;
  String? message;

  Response({
    this.success,
    this.message,
  });

  factory Response.fromJson(Map<String, dynamic>? json) {
    return Response(success: json?['success'], message: json?['message']);
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> temp = {
      'success': success,
      'message': message,
    };
    temp.removeWhere((key, value) => value == null);

    return temp;
  }
}
