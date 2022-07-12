import 'package:corporatetransportapp/utils/global_variable.dart';
import 'package:http/http.dart' as http;

Future<http.Response> serviceCallPost({
  required Map<String, dynamic> body,
  required String path,
}) async {
  var parts = [];
  body.forEach((key, value) {
    parts.add('${Uri.encodeQueryComponent(key)}='
        '${Uri.encodeQueryComponent(value)}');
  });
  var formData = parts.join('&');
  var response = await http.post(
    Uri.https(
      GlobalVariable.baseAddress,
      path,
    ),
    headers: {
      "Content-Type": "application/x-www-form-urlencoded",
    },
    body: formData,
  );

  switch (response.statusCode) {
    case 404:
      throw Exception("Page Not Found");
    case 401:
      throw Exception("Session expired");
    case 500:
      throw Exception("Server error");
  }
  return response;
}
