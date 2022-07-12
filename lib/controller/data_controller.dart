import 'dart:convert';
import 'package:corporatetransportapp/service/service_call_get.dart';
import 'package:corporatetransportapp/service/services.dart' as services;
import 'package:corporatetransportapp/enum/roles.dart';
import 'package:corporatetransportapp/model/response_model.dart';
import 'package:corporatetransportapp/model/user_model.dart';
import 'package:corporatetransportapp/service/service_call_post.dart';
import 'package:corporatetransportapp/utils/global_variable.dart';
import 'package:corporatetransportapp/utils/session_manager.dart';
import 'package:corporatetransportapp/utils/snackbar.dart';
import 'package:corporatetransportapp/view/admin/admin_main_screen.dart';
import 'package:corporatetransportapp/view/driver/driver_main_screen.dart';
import 'package:corporatetransportapp/view/employee/employee_main_screen.dart';
import 'package:flutter/material.dart';

class DataController with ChangeNotifier {
  User _user = User();

  set user(User value) {
    _user = value;
    notifyListeners();
  }

  User get user => _user;

  getUser() async {
    user = User.fromJson(jsonDecode(await SessionManager.getUser()));
  }

  void login({required String username, required String password}) async {
    Map<String, dynamic> body = {
      "username": username,
      'password': password,
    };
    print("object");
    var res = await serviceCallPost(body: body, path: services.login);

    print(res.body);
    print(res.statusCode);
    print(body);
    if (res.statusCode == 200) {
      Response response = Response.fromJson(jsonDecode(res.body));
      if (response.success == true) {
        var role = jsonDecode(res.body)['role'];
        SessionManager.saveRole(role);
        fetchProfile(userid: role, role: jsonDecode(res.body)['role']);
        if (role == Role.admin.name) {
          Navigator.of(GlobalVariable.navState.currentContext!)
              .pushReplacementNamed(AdminMainScreen.routeName);
        } else if (role == Role.driver.name) {
          Navigator.of(GlobalVariable.navState.currentContext!)
              .pushReplacementNamed(DriverMainScreen.routeName);
        } else if (role == Role.rider.name) {
          Navigator.of(GlobalVariable.navState.currentContext!)
              .pushReplacementNamed(EmployeeMainScreen.routeName);
        }
        snackBar(
            response.message ?? '', GlobalVariable.navState.currentContext!);
      }
    }
  }

  void fetchProfile({required String userid, required String role}) async {
    String role = await SessionManager.getRole();
    String endPoint = '';
    if (role == Role.admin.name) {
      endPoint = services.getAdmin;
    } else if (role == Role.driver.name) {
      endPoint = services.getDriver;
    } else if (role == Role.rider.name) {
      endPoint = services.getRider;
    }
    if (endPoint.isEmpty) {
      return;
    }

    Map<String, dynamic> body = {
      "userid": userid,
    };

    var res = await serviceCallPost(body: body, path: endPoint);
    print(res.body);
    print(res.statusCode);
    if (res.statusCode == 200) {
      print(res.body);
      SessionManager.saveUser(jsonEncode(jsonDecode(res.body)['data']));
      getUser();
    }
  }

  void addFeedback(
      {required String comment,
      required int rate,
      required String email}) async {
    Map<String, dynamic> body = {
      "comment": comment,
      "author": "Test",
      "date": DateTime.now().toIso8601String().substring(0, 16),
      "rate": rate.toString(),
      "email": email,
    };
    var res = await serviceCallPost(
      body: body,
      path: services.addFeedbackService,
    );
    print(res.body);
    print(res.statusCode);
  }

  getFeedbacks() async {
    var res = await serviceCallGet(path: services.getFeedbacks);
    print(res.statusCode);
    print(res.body);
  }
}
