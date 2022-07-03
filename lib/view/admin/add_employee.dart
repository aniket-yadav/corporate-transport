import 'package:corporatetransportapp/widgets/custom_number_selection.dart';
import 'package:corporatetransportapp/widgets/gender_radio.dart';
import 'package:flutter/material.dart';
import 'package:corporatetransportapp/assets/constants.dart' as constants;

class AddEmployee extends StatefulWidget {
  const AddEmployee({Key? key}) : super(key: key);

  static const routeName = "/addemployee";
  @override
  State<AddEmployee> createState() => _AddEmployeeState();
}

class _AddEmployeeState extends State<AddEmployee> {
  int currentAge = 25;

  String selectedGender = "";
  @override
  Widget build(BuildContext context) {
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
            onPressed: () {},
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
                child: const TextField(
                  decoration: InputDecoration(
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
                child: const TextField(
                  decoration: InputDecoration(
                    filled: true,
                  ),
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
                child: const TextField(
                  decoration: InputDecoration(
                    filled: true,
                  ),
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
                child: const TextField(
                  decoration: InputDecoration(
                    filled: true,
                  ),
                  maxLines: null,
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
