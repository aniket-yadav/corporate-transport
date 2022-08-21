import 'package:corporatetransportapp/controller/data_controller.dart';
import 'package:corporatetransportapp/view/admin/add_vehicle.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class VehiclesList extends StatefulWidget {
  const VehiclesList({Key? key}) : super(key: key);

  @override
  State<VehiclesList> createState() => _VehiclesListState();
}

class _VehiclesListState extends State<VehiclesList> {
  @override
  Widget build(BuildContext context) {
    final dataController = Provider.of<DataController>(context);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 15.0),
        child: ListView.builder(
          itemCount: dataController.vehicles.length,
          itemBuilder: ((context, index) {
            return InkWell(
              onTap: () {
                Navigator.of(context).pushNamed(AddVehicle.routeName,
                    arguments: dataController.vehicles[index]);
              },
              child: Card(
                margin: const EdgeInsets.symmetric(
                  horizontal: 15.0,
                  vertical: 8.0,
                ),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15.0,
                    vertical: 15.0,
                  ),
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: constraints.maxWidth * 0.3,
                            child: const Icon(
                              Icons.time_to_leave,
                              size: 70,
                            ),
                          ),
                          SizedBox(
                            width: constraints.maxWidth * 0.7,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Flexible(
                                      flex: 0,
                                      child: Text(
                                        dataController.vehicles[index].name ??
                                            '',
                                        style: const TextStyle(
                                          fontSize: 15.0,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                    const Spacer(),
                                    IconButton(
                                      onPressed: () {
                                        dataController.deleteVehicle(
                                            id: dataController.vehicles[index]
                                                    .vehicleid ??
                                                '');
                                      },
                                      icon: const Icon(Icons.delete),
                                    )
                                  ],
                                ),
                                Text(
                                  dataController.vehicles[index].model ?? '',
                                  style: const TextStyle(
                                    fontSize: 13.0,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                        "Type: ${dataController.vehicles[index].type ?? ''}"),
                                    Text(
                                      "Seats:${dataController.vehicles[index].capacity ?? ''}",
                                      style: const TextStyle(
                                        fontSize: 13.0,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          )
                        ],
                      );
                    },
                  ),
                ),
              ),
            );
          }),
        ),
      ),
      floatingActionButton: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF107189),
          borderRadius: BorderRadius.circular(30),
        ),
        child: IconButton(
          onPressed: () {
            Navigator.of(context).pushNamed(AddVehicle.routeName);
          },
          icon: const Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
