import 'package:corporatetransportapp/controller/data_controller.dart';
import 'package:corporatetransportapp/model/employee_model.dart';
import 'package:corporatetransportapp/widgets/custom_number_selection.dart';
import 'package:corporatetransportapp/widgets/gender_radio.dart';
import 'package:flutter/material.dart';
import 'package:corporatetransportapp/assets/constants.dart' as constants;
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class AddEmployee extends StatefulWidget {
  const AddEmployee({Key? key}) : super(key: key);

  static const routeName = "/addemployee";
  @override
  State<AddEmployee> createState() => _AddEmployeeState();
}

class _AddEmployeeState extends State<AddEmployee> {
  int currentAge = 25;

  String selectedGender = "";
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController empIdController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController pincodeController = TextEditingController();

  EmployeeModel? _employeeModel;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        _employeeModel =
            ModalRoute.of(context)?.settings.arguments as EmployeeModel?;

        if (_employeeModel != null) {
          nameController.text = _employeeModel?.name ?? '';
          emailController.text = _employeeModel?.email ?? '';
          currentAge = int.parse(_employeeModel?.age ?? '0');
          selectedGender = _employeeModel?.gender ?? '';
          mobileController.text = _employeeModel?.mobile ?? '';
          empIdController.text = _employeeModel?.empid ?? '';
          addressController.text = _employeeModel?.address ?? '';
          pincodeController.text = _employeeModel?.pincode ?? '';
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final dataController = Provider.of<DataController>(context);
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        extendBody: true,
        appBar: AppBar(
          title: const Text("Add Employee"),
        ),
        bottomNavigationBar: Container(
          margin: const EdgeInsets.symmetric(
            horizontal: 15.0,
            vertical: 15.0,
          ),
          child: ElevatedButton(
            onPressed: () {
              var name = nameController.text.trim();
              var email = emailController.text.trim();
              var mobile = mobileController.text.trim();
              var employeeId = empIdController.text.trim();
              var address = addressController.text.trim();
              var pincode = pincodeController.text.trim();

              if (_employeeModel != null) {
                dataController.updateEmployee(
                  id: _employeeModel?.employeeid ?? '',
                  empid: employeeId,
                  address: address,
                  age: '$currentAge',
                  email: email,
                  gender: selectedGender,
                  mobile: mobile,
                  name: name,
                  pincode: pincode,
                );
              } else {
                dataController.addEmployee(
                  empid: employeeId,
                  address: address,
                  age: '$currentAge',
                  email: email,
                  gender: selectedGender,
                  mobile: mobile,
                  name: name,
                  pincode: pincode,
                );
              }
            },
            style: ButtonStyle(
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(7),
                ),
              ),
            ),
            child: const Text("Submit"),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 30,
              ),
              Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 15.0,
                  vertical: 10.0,
                ),
                child: const Text(
                  "Full Name",
                  style: TextStyle(
                    fontSize: 14.0,
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 15.0,
                  vertical: 10.0,
                ),
                child: TextField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    filled: true,
                  ),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(
                      RegExp("[a-zA-Z. ]"),
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 15.0,
                  vertical: 10.0,
                ),
                child: const Text(
                  "Email",
                  style: TextStyle(
                    fontSize: 14.0,
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 15.0,
                  vertical: 10.0,
                ),
                child: TextField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    filled: true,
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 15.0,
                  vertical: 10.0,
                ),
                child: const Text(
                  "Select Age",
                  style: TextStyle(
                    fontSize: 14.0,
                  ),
                ),
              ),
              CustomNumberSelection(
                  minValue: 0,
                  maxValue: 100,
                  currentValue: currentAge,
                  onChanged: (n) {
                    setState(() {
                      currentAge = n;
                    });
                  }),
              Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 15.0,
                  vertical: 10.0,
                ),
                child: const Text(
                  "Select Gender",
                  style: TextStyle(
                    fontSize: 14.0,
                  ),
                ),
              ),
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      setSelectedGender(constants.male);
                    },
                    child: GenderRadio(
                      key: UniqueKey(),
                      value: constants.male,
                      groupValue: selectedGender,
                      setSeletedGender: setSelectedGender,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setSelectedGender(constants.female);
                    },
                    child: GenderRadio(
                      key: UniqueKey(),
                      value: constants.female,
                      groupValue: selectedGender,
                      setSeletedGender: setSelectedGender,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setSelectedGender(constants.other);
                    },
                    child: GenderRadio(
                      key: UniqueKey(),
                      value: constants.other,
                      groupValue: selectedGender,
                      setSeletedGender: setSelectedGender,
                    ),
                  ),
                ],
              ),
              Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 15.0,
                  vertical: 8.0,
                ),
                child: const Text(
                  "Mobile no.",
                  style: TextStyle(
                    fontSize: 14.0,
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 15.0,
                  vertical: 8.0,
                ),
                child: TextField(
                  controller: mobileController,
                  keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(
                    filled: true,
                    counterText: '',
                  ),
                  maxLength: 10,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 15.0,
                  vertical: 8.0,
                ),
                child: const Text(
                  "Employee Id",
                  style: TextStyle(
                    fontSize: 14.0,
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 15.0,
                  vertical: 8.0,
                ),
                child: TextField(
                  controller: empIdController,
                  decoration: const InputDecoration(
                    filled: true,
                  ),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(
                      RegExp("[a-zA-Z0-9. ]"),
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 15.0,
                  vertical: 8.0,
                ),
                child: const Text(
                  "Address",
                  style: TextStyle(
                    fontSize: 14.0,
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 15.0,
                  vertical: 8.0,
                ),
                child: TextField(
                  controller: addressController,
                  decoration: const InputDecoration(
                    filled: true,
                  ),
                  maxLines: null,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(
                      RegExp("[a-zA-Z0-9. ]"),
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 15.0,
                  vertical: 8.0,
                ),
                child: const Text(
                  "Pincode",
                  style: TextStyle(
                    fontSize: 14.0,
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 15.0,
                  vertical: 8.0,
                ),
                child: TextField(
                  controller: pincodeController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    filled: true,
                    counterText: '',
                  ),
                  maxLength: 6,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                ),
              ),
              const SizedBox(
                height: 50,
              )
            ],
          ),
        ),
      ),
    );
  }

  void setSelectedGender(String value) {
    setState(() {
      selectedGender = value;
    });
  }
}
