import 'package:corporatetransportapp/widgets/custom_number_selection.dart';
import 'package:flutter/material.dart';

class AddVehicle extends StatefulWidget {
  const AddVehicle({Key? key}) : super(key: key);
  static const routeName = "/addVehicle";

  @override
  State<AddVehicle> createState() => _AddVehicleState();
}

class _AddVehicleState extends State<AddVehicle> {
  int seatCapacity = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      appBar: AppBar(
        title: const Text("Add Vehicle"),
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
                "Vehicle Name",
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
                "Vehicle Model",
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
                "Vehicle Color",
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
                "Vehicle No.",
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
                "Seat capacity",
                style: TextStyle(
                  fontSize: 14.0,
                ),
              ),
            ),
            CustomNumberSelection(
                minValue: 0,
                maxValue: 100,
                currentValue: seatCapacity,
                onChanged: (n) {
                  setState(() {
                    seatCapacity = n;
                  });
                }),
          ],
        ),
      ),
    );
  }
}
