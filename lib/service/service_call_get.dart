import 'package:corporatetransportapp/utils/global_variable.dart';
import 'package:http/http.dart' as http;

Future<http.Response> serviceCallGet({
  required String path,
}) async {
  var response = await http.get(
    Uri.https(
      GlobalVariable.baseAddress,
      path,
    ),
    headers: {
      "Content-Type": "application/json",
    },
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
