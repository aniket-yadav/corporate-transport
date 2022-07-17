import 'package:corporatetransportapp/controller/data_controller.dart';
import 'package:corporatetransportapp/widgets/data_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Vehicle extends StatefulWidget {
  const Vehicle({Key? key}) : super(key: key);

  @override
  State<Vehicle> createState() => _VehicleState();
}

class _VehicleState extends State<Vehicle> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final dataController =
          Provider.of<DataController>(context, listen: false);
      dataController.getVehicle();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final dataController = Provider.of<DataController>(context);
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              alignment: Alignment.center,
              height: 70,
              decoration: const BoxDecoration(
                color: Color(0xffffffff),
                boxShadow: [
                  BoxShadow(
                    color: Color(0x1100000D),
                    blurRadius: 16,
                    spreadRadius: 0,
                  )
                ],
              ),
              child: const Text(
                "My Vehicle",
                style: TextStyle(
                  fontSize: 18,
                  color: Color(0xFF107189),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            DataTile(
              label: "Name:  ${dataController.vehicle?.name ?? 'N/A'}",
            ),
            DataTile(
              label: "Model:  ${dataController.vehicle?.model ?? 'N/A'}",
            ),
            DataTile(
              label: "Color:  ${dataController.vehicle?.color ?? 'N/A'}",
            ),
            DataTile(
              label: "No.:  ${dataController.vehicle?.platno ?? 'N/A'}",
            ),
            DataTile(
              label: "Capacity:  ${dataController.vehicle?.capacity ?? 'N/A'}",
            ),
          ],
        ),
      ),
    );
  }
}
