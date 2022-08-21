import 'package:corporatetransportapp/controller/data_controller.dart';
import 'package:corporatetransportapp/model/driver_model.dart';
import 'package:corporatetransportapp/widgets/custom_number_selection.dart';
import 'package:corporatetransportapp/widgets/gender_radio.dart';
import 'package:flutter/material.dart';
import 'package:corporatetransportapp/assets/constants.dart' as constants;
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class AddDriver extends StatefulWidget {
  const AddDriver({Key? key}) : super(key: key);
  static const routeName = "/addDriver";
  @override
  State<AddDriver> createState() => _AddDriverState();
}

class _AddDriverState extends State<AddDriver> {
  int currentAge = 25;
  int experienceYears = 4;
  String selectedGender = "";
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController adharController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController pincodeController = TextEditingController();

  DriverModel? _driverModel;
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        _driverModel =
            ModalRoute.of(context)?.settings.arguments as DriverModel?;

        if (_driverModel != null) {
          nameController.text = _driverModel?.name ?? '';
          emailController.text = _driverModel?.email ?? '';
          currentAge = int.parse(_driverModel?.age ?? '0');
          selectedGender = _driverModel?.gender ?? '';
          mobileController.text = _driverModel?.mobile ?? '';
          adharController.text = _driverModel?.aadharno ?? '';
          experienceYears = int.parse(_driverModel?.experience ?? '0');
          addressController.text = _driverModel?.address ?? '';
          pincodeController.text = _driverModel?.pincode ?? '';
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
          title: const Text("Add Driver"),
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
              var adhar = adharController.text.trim();
              var address = addressController.text.trim();
              var pincode = pincodeController.text.trim();

              if (_driverModel != null) {
                dataController.updateDriver(
                  id:_driverModel?.driverid ?? '',
                  aadharno: adhar,
                  address: address,
                  age: '$currentAge',
                  email: email,
                  experience: '$experienceYears',
                  gender: selectedGender,
                  mobile: mobile,
                  name: name,
                  pincode: pincode,
                );
              } else {
                dataController.addDriver(
                  aadharno: adhar,
                  address: address,
                  age: '$currentAge',
                  email: email,
                  experience: '$experienceYears',
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
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  maxLength: 10,
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 15.0,
                  vertical: 8.0,
                ),
                child: const Text(
                  "Aadhar no.",
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
                  controller: adharController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    filled: true,
                    counterText: '',
                  ),
                  maxLength: 12,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 15.0,
                  vertical: 8.0,
                ),
                child: const Text(
                  "Experience(in years)",
                  style: TextStyle(
                    fontSize: 14.0,
                  ),
                ),
              ),
              CustomNumberSelection(
                  minValue: 0,
                  maxValue: 100,
                  currentValue: experienceYears,
                  onChanged: (n) {
                    setState(() {
                      experienceYears = n;
                    });
                  }),
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
