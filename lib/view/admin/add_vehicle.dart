import 'package:corporatetransportapp/controller/data_controller.dart';
import 'package:corporatetransportapp/enum/vehicles.dart';
import 'package:corporatetransportapp/model/vehicle_model.dart';
import 'package:corporatetransportapp/widgets/custom_number_selection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class AddVehicle extends StatefulWidget {
  const AddVehicle({Key? key}) : super(key: key);
  static const routeName = "/addVehicle";

  @override
  State<AddVehicle> createState() => _AddVehicleState();
}

class _AddVehicleState extends State<AddVehicle> {
  int seatCapacity = 0;
  Vehicles? selectedType;
  TextEditingController nameController = TextEditingController();
  TextEditingController modelController = TextEditingController();
  TextEditingController colorController = TextEditingController();
  TextEditingController noController = TextEditingController();

  VehicleModel? _vehicleModel;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        _vehicleModel =
            ModalRoute.of(context)?.settings.arguments as VehicleModel?;
        if (_vehicleModel != null) {
          nameController.text = _vehicleModel?.name ?? '';
          modelController.text = _vehicleModel?.model ?? '';
          selectedType = Vehicles.bus.name == _vehicleModel?.type
              ? Vehicles.bus
              : Vehicles.car;
          colorController.text = _vehicleModel?.color ?? '';
          noController.text = _vehicleModel?.platno ?? '';
          seatCapacity = int.parse(_vehicleModel?.capacity ?? '0');
        }
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final dataController = Provider.of<DataController>(context);
    return Scaffold(
      bottomNavigationBar: Container(
        margin: const EdgeInsets.symmetric(
          horizontal: 15.0,
          vertical: 15.0,
        ),
        child: ElevatedButton(
          onPressed: () {
            var name = nameController.text.trim();
            var model = modelController.text.trim();
            var color = colorController.text.trim();
            var no = noController.text.trim();

            if (_vehicleModel != null) {
              dataController.updateVehicle(
                id: _vehicleModel?.vehicleid ?? '',
                capacity: '$seatCapacity',
                color: color,
                model: model,
                name: name,
                no: no,
                type: selectedType?.name,
              );
            } else {
              dataController.addVehicle(
                capacity: '$seatCapacity',
                color: color,
                model: model,
                name: name,
                no: no,
                type: selectedType?.name,
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
              child: TextField(
                controller: modelController,
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
                vertical: 10.0,
              ),
              child: const Text(
                "Vehicle Type",
                style: TextStyle(
                  fontSize: 14.0,
                ),
              ),
            ),
            Row(
              children: [
                Row(
                  children: [
                    Radio(
                      activeColor: const Color(0xFF107189),
                      value: Vehicles.car,
                      groupValue: selectedType,
                      onChanged: (Vehicles? v) {
                        setState(() {
                          selectedType = v;
                        });
                      },
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    Text(
                      Vehicles.car.name,
                      style: const TextStyle(
                        fontSize: 14.0,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Radio(
                      activeColor: const Color(0xFF107189),
                      value: Vehicles.bus,
                      groupValue: selectedType,
                      onChanged: (Vehicles? v) {
                        setState(() {
                          selectedType = v;
                        });
                      },
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    Text(
                      Vehicles.bus.name,
                      style: const TextStyle(
                        fontSize: 14.0,
                      ),
                    ),
                  ],
                ),
              ],
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
              child: TextField(
                controller: colorController,
                decoration: const InputDecoration(
                  filled: true,
                ),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(
                    RegExp("[a-zA-Z ]"),
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
              child: TextField(
                controller: noController,
                decoration: const InputDecoration(
                  filled: true,
                  counterText: '',
                ),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(
                    RegExp("[a-zA-Z0-9]"),
                  ),
                ],
                maxLength: 10,
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
