import 'dart:convert';
import 'package:corporatetransportapp/model/driver_model.dart';
import 'package:corporatetransportapp/model/drivers_response.dart';
import 'package:corporatetransportapp/model/employee_model.dart';
import 'package:corporatetransportapp/model/employees_response.dart';
import 'package:corporatetransportapp/model/feedback_model.dart';
import 'package:corporatetransportapp/model/feedback_response.dart';
import 'package:corporatetransportapp/model/vehicle_model.dart';
import 'package:corporatetransportapp/model/vehicle_response.dart';
import 'package:corporatetransportapp/model/vehicles_response.dart';
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
    var res = await serviceCallPost(body: body, path: services.login);
    print(res.body);
    print(res.statusCode);
    if (res.statusCode == 200) {
      Response response = Response.fromJson(jsonDecode(res.body));
      if (response.success == true) {
        var role = jsonDecode(res.body)['role'];
        var userId = jsonDecode(res.body)['userid'];
        SessionManager.saveRole(role);
        fetchProfile(userid: userId, role: role);
        if (role == Role.admin.name) {
          Navigator.of(GlobalVariable.navState.currentContext!)
              .pushReplacementNamed(AdminMainScreen.routeName);
        } else if (role == Role.driver.name) {
          Navigator.of(GlobalVariable.navState.currentContext!)
              .pushReplacementNamed(DriverMainScreen.routeName);
        } else if (role == Role.employee.name) {
          Navigator.of(GlobalVariable.navState.currentContext!)
              .pushReplacementNamed(EmployeeMainScreen.routeName);
        }
        snackBar(
            response.message ?? '', GlobalVariable.navState.currentContext!);
      } else {
        snackBar(
            response.message ?? '', GlobalVariable.navState.currentContext!);
      }
    }
  }

  void fetchProfile({String? userid, required String role}) async {
    String endPoint = '';

    if (role == Role.admin.name) {
      endPoint = services.getAdmin;
    } else if (role == Role.driver.name) {
      endPoint = services.getDriver;
    } else if (role == Role.employee.name) {
      endPoint = services.getRider;
    }
    if (endPoint.isEmpty) {
      return;
    }

    String id = userid ?? user.userid ?? '';

    Map<String, dynamic> body = {
      "userid": id,
    };

    var res = await serviceCallPost(body: body, path: endPoint);

    if (res.statusCode == 200) {
      SessionManager.saveUser(jsonEncode(jsonDecode(res.body)['data']));
      getUser();
    }
  }

  void addFeedback({
    required String comment,
    required int rate,
  }) async {
    Map<String, dynamic> body = {
      "comment": comment,
      "author": user.name,
      "date": DateTime.now().toIso8601String().substring(0, 16),
      "rate": rate.toString(),
      "email": user.email,
    };
    var res = await serviceCallPost(
      body: body,
      path: services.addFeedbackService,
    );
    print(res.body);
    print(res.statusCode);
    if (res.statusCode == 200) {
      Response response = Response.fromJson(jsonDecode(res.body));
      snackBar(response.message ?? '', GlobalVariable.navState.currentContext!);
    }
  }

  List<FeedbackModel> _feedBacks = [];

  List<FeedbackModel> get feedBacks => _feedBacks;

  set feedBacks(List<FeedbackModel> value) {
    _feedBacks = value;
    notifyListeners();
  }

  getFeedbacks() async {
    var res = await serviceCallGet(path: services.getFeedbacks);

    if (res.statusCode == 200) {
      FeedbackResponse feedbackResponse =
          FeedbackResponse.fromJson(jsonDecode(res.body));
      if (feedbackResponse.success == true) {
        if (feedbackResponse.data != null) {
          feedBacks = feedbackResponse.data ?? [];
        } else {
          feedBacks = [];
        }
      } else {
        feedBacks = [];
      }
    } else {
      feedBacks = [];
    }
  }

  addDriver({
    String? name,
    String? email,
    String? age,
    String? gender,
    String? mobile,
    String? aadharno,
    String? experience,
    String? address,
    String? pincode,
  }) async {
    Map<String, dynamic> body = {
      "name": name,
      "email": email,
      "age": age,
      "gender": gender,
      "mobile": mobile,
      "aadharno": aadharno,
      "experience": experience,
      "address": address,
      "pincode": pincode,
    };
    var res = await serviceCallPost(
      body: body,
      path: services.addDriverService,
    );

    if (res.statusCode == 200) {
      Response response = Response.fromJson(jsonDecode(res.body));
      snackBar(response.message ?? '', GlobalVariable.navState.currentContext!);
      getDrivers();
      Navigator.of(GlobalVariable.navState.currentContext!).pop();
    }
  }

  List<DriverModel> _drivers = [];

  List<DriverModel> get drivers => _drivers;

  set drivers(List<DriverModel> value) {
    _drivers = value;
    notifyListeners();
  }

  getDrivers() async {
    var res = await serviceCallGet(path: services.getDrivers);

    if (res.statusCode == 200) {
      DriversResponse driverResponse =
          DriversResponse.fromJson(jsonDecode(res.body));
      if (driverResponse.success == true) {
        if (driverResponse.data != null) {
          drivers = driverResponse.data ?? [];
        } else {
          drivers = [];
        }
      } else {
        drivers = [];
      }
    } else {
      drivers = [];
    }
  }

  addEmployee({
    String? name,
    String? email,
    String? age,
    String? gender,
    String? mobile,
    String? empid,
    String? address,
    String? pincode,
  }) async {
    Map<String, dynamic> body = {
      "name": name,
      "email": email,
      "age": age,
      "gender": gender,
      "mobile": mobile,
      "empid": empid,
      "address": address,
      "pincode": pincode,
    };
    var res = await serviceCallPost(
      body: body,
      path: services.addEmployeeService,
    );

    if (res.statusCode == 200) {
      Response response = Response.fromJson(jsonDecode(res.body));
      snackBar(response.message ?? '', GlobalVariable.navState.currentContext!);
      Navigator.of(GlobalVariable.navState.currentContext!).pop();
      getEmployees();
    }
  }

  List<EmployeeModel> _employees = [];

  List<EmployeeModel> get employees => _employees;

  set employees(List<EmployeeModel> value) {
    _employees = value;
    notifyListeners();
  }

  getEmployees() async {
    var res = await serviceCallGet(path: services.getEmployees);

    if (res.statusCode == 200) {
      EmployeesResponse employeesResponse =
          EmployeesResponse.fromJson(jsonDecode(res.body));
      if (employeesResponse.success == true) {
        if (employeesResponse.data != null) {
          employees = employeesResponse.data ?? [];
        } else {
          employees = [];
        }
      } else {
        employees = [];
      }
    } else {
      employees = [];
    }
  }

  addVehicle({
    String? name,
    String? model,
    String? type,
    String? color,
    String? no,
    String? capacity,
  }) async {
    Map<String, dynamic> body = {
      "name": name,
      "model": model,
      "type": type,
      "color": color,
      "no": no,
      "capacity": capacity,
    };
    var res = await serviceCallPost(
      body: body,
      path: services.addVehicleService,
    );

    if (res.statusCode == 200) {
      Response response = Response.fromJson(jsonDecode(res.body));
      snackBar(response.message ?? '', GlobalVariable.navState.currentContext!);
      Navigator.of(GlobalVariable.navState.currentContext!).pop();
      getVehicles();
    }
  }

  List<VehicleModel> _vehicles = [];

  List<VehicleModel> get vehicles => _vehicles;

  set vehicles(List<VehicleModel> value) {
    _vehicles = value;
    notifyListeners();
  }

  getVehicles() async {
    var res = await serviceCallGet(path: services.getVehicles);

    if (res.statusCode == 200) {
      VehiclesResponse vehiclesResponse =
          VehiclesResponse.fromJson(jsonDecode(res.body));
      if (vehiclesResponse.success == true) {
        if (vehiclesResponse.data != null) {
          vehicles = vehiclesResponse.data ?? [];
        } else {
          vehicles = [];
        }
      } else {
        vehicles = [];
      }
    } else {
      vehicles = [];
    }
  }

//  profile

  uploadPhoto({String? image, required String role}) async {
    Map<String, dynamic> body = {
      "role": role,
      "image": image ?? '',
      "userid": user.userid,
    };

    var res = await serviceCallPost(
      body: body,
      path: services.uploadProfilePhoto,
    );

    if (res.statusCode == 200) {
      fetchProfile(role: role);
      Response response = Response.fromJson(jsonDecode(res.body));
      snackBar(response.message ?? '', GlobalVariable.navState.currentContext!);
    }
  }

//  change password
  changePassword({
    required String role,
    required String oldPassword,
    required String newPassword,
  }) async {
    Map<String, dynamic> body = {
      "role": role,
      "userid": user.userid,
      "oldpassword": oldPassword,
      "newpassword": newPassword,
    };

    var res = await serviceCallPost(
      body: body,
      path: services.changePasswordService,
    );

    print(res.statusCode);
    print(res.body);

    if (res.statusCode == 200) {
      fetchProfile(role: role);
      Response response = Response.fromJson(jsonDecode(res.body));
      snackBar(response.message ?? '', GlobalVariable.navState.currentContext!);
    }
  }

  void updateBus({String? bus, required String userId, String? role}) async {
    Map<String, dynamic> body = {
      "user": role,
      "userid": userId,
      "bus": bus,
    };

    var res = await serviceCallPost(
      body: body,
      path: services.updateBusService,
    );

    print(res.statusCode);
    print(res.body);

    if (res.statusCode == 200) {
      getDrivers();
      getEmployees();
      getVehicles();
      Response response = Response.fromJson(jsonDecode(res.body));
      snackBar(response.message ?? '', GlobalVariable.navState.currentContext!);
    }
  }

  void updateLocation({required String latitude, String? longitude}) async {
    Map<String, dynamic> body = {
      "vehicleId": user.vehicleid,
      "longitude": longitude,
      "latitude": latitude,
    };

    var res = await serviceCallPost(
      body: body,
      path: services.updateLocationService,
    );

    print(res.statusCode);
    print(res.body);

    if (res.statusCode == 200) {
      // getVehicle();
    }
  }

  VehicleModel? _vehicle;

  VehicleModel? get vehicle => _vehicle;

  set vehicle(VehicleModel? value) {
    _vehicle = value;
    notifyListeners();
  }

  void getVehicle() async {
    Map<String, dynamic> body = {
      "vehicleid": user.vehicleid,
    };

    var res = await serviceCallPost(
      body: body,
      path: services.getVehicle,
    );

    print(res.statusCode);
    print(res.body);

    if (res.statusCode == 200) {
      VehicleResponse response = VehicleResponse.fromJson(jsonDecode(res.body));
      vehicle = response.data;
    }
  }

// my passengers

  List<EmployeeModel> _myPassengers = [];

  List<EmployeeModel> get myPassengers => _myPassengers;

  set myPassengers(List<EmployeeModel> value) {
    _myPassengers = value;
    notifyListeners();
  }

  void getMyPaasengers() async {
    Map<String, dynamic> body = {
      "vehicleid": user.vehicleid,
    };

    var res = await serviceCallPost(
      body: body,
      path: services.myPasssengers,
    );

    print(res.statusCode);
    print(res.body);

    if (res.statusCode == 200) {
      EmployeesResponse employeesResponse =
          EmployeesResponse.fromJson(jsonDecode(res.body));
      if (employeesResponse.success == true) {
        if (employeesResponse.data != null) {
          myPassengers = employeesResponse.data ?? [];
        } else {
          myPassengers = [];
        }
      } else {
        myPassengers = [];
      }
    } else {
      myPassengers = [];
    }
  }

  void updateRidingStatus({required String userid, String? status}) async {
    Map<String, dynamic> body = {
      "userid": userid,
      "status": status,
    };

    var res = await serviceCallPost(
      body: body,
      path: services.updateRidingStatus,
    );

    print(res.statusCode);
    print(res.body);

    if (res.statusCode == 200) {
      getMyPaasengers();
    }
  }

  void resetPassword({required String role, required String email}) async {
    Map<String, dynamic> body = {
      "role": role,
      "email": email,
    };

    var res = await serviceCallPost(
      body: body,
      path: services.resetPassword,
    );

    print(res.statusCode);
    print(res.body);

    if (res.statusCode == 200) {
      Response response = Response.fromJson(jsonDecode(res.body));
      snackBar(response.message ?? '', GlobalVariable.navState.currentContext!);
      if (response.success == true) {
        Navigator.of(GlobalVariable.navState.currentContext!).pop();
      }
    }
  }


  void callSOS({required String lat,required String log}) async {


    Map<String, dynamic> body = {
      "user": user.name ?? '',
      "userid": user.userid ?? '',
      'lat':lat,
      'log':log,
    };

    var res = await serviceCallPost(
      body: body,
      path: services.sosCallService,
    );

    print(res.statusCode);
    print(res.body);

    if (res.statusCode == 200) {
      Response response = Response.fromJson(jsonDecode(res.body));
      snackBar(response.message ?? '', GlobalVariable.navState.currentContext!);
      
    }
  }
}
