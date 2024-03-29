import 'package:corporatetransportapp/controller/data_controller.dart';
import 'package:corporatetransportapp/model/driver_model.dart';
import 'package:corporatetransportapp/model/vehicle_model.dart';
import 'package:corporatetransportapp/view/admin/add_driver.dart';
import 'package:corporatetransportapp/widgets/option_modal.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DriverList extends StatefulWidget {
  const DriverList({Key? key}) : super(key: key);

  @override
  State<DriverList> createState() => _DriverListState();
}

class _DriverListState extends State<DriverList> {
  void busAssign(DriverModel driver, DataController dataController) async {
    var res = await showOptionModal(context, driver.vehicleid,
        dataController.vehicles.map((e) => e.platno).toList());
    if (res != null) {
      dataController.updateBus(
        bus: dataController.vehicles
                .firstWhere((element) => element.platno == res)
                .vehicleid ??
            '',
        userId: driver.driverid ?? '',
        role: "driver",
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final dataController = Provider.of<DataController>(context);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 15.0),
        child: ListView.builder(
          itemCount: dataController.drivers.length,
          itemBuilder: ((context, index) {
            return InkWell(
              onTap: () async {
                await showModalBottomSheet(
                    context: context,
                    backgroundColor: Colors.transparent,
                    builder: (context) {
                      return Wrap(
                        children: [
                          Container(
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20),
                              ),
                              color: Colors.white,
                            ),
                            padding: const EdgeInsets.symmetric(
                              vertical: 25.0,
                              horizontal: 25.0,
                            ),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Navigator.of(context).pop();
                                      Navigator.of(context).pushNamed(
                                          AddDriver.routeName,
                                          arguments:
                                              dataController.drivers[index]);
                                    },
                                    child: Container(
                                      width: double.infinity,
                                      padding: const EdgeInsets.all(
                                        10,
                                      ),
                                      child: Row(
                                        children: const [
                                          Icon(Icons.edit),
                                          SizedBox(
                                            width: 15,
                                          ),
                                          Text("Edit"),
                                        ],
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Navigator.of(context).pop();
                                      busAssign(dataController.drivers[index],
                                          dataController);
                                    },
                                    child: Container(
                                      width: double.infinity,
                                      padding: const EdgeInsets.all(
                                        10,
                                      ),
                                      child: Row(
                                        children: const [
                                          Icon(Icons.directions_bus),
                                          SizedBox(
                                            width: 15,
                                          ),
                                          Text("Assign bus"),
                                        ],
                                      ),
                                    ),
                                  ),
                                ]),
                          ),
                        ],
                      );
                    });
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
                              Icons.account_circle,
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
                                        dataController.drivers[index].name ??
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
                                        dataController.deleteDriver(
                                            id: dataController
                                                    .drivers[index].driverid ??
                                                '');
                                      },
                                      icon: const Icon(Icons.delete),
                                    )
                                  ],
                                ),
                                Text(
                                  dataController.drivers[index].mobile ?? '',
                                  style: const TextStyle(
                                    fontSize: 13.0,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    if (dataController.vehicles.isNotEmpty)
                                      Text(
                                        "#${dataController.vehicles.firstWhere((element) => element.vehicleid == dataController.drivers[index].vehicleid, orElse: () => VehicleModel()).platno ?? 'N/A'}",
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
            Navigator.of(context).pushNamed(AddDriver.routeName);
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
