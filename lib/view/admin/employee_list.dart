import 'package:corporatetransportapp/controller/data_controller.dart';
import 'package:corporatetransportapp/model/vehicle_model.dart';
import 'package:corporatetransportapp/view/admin/add_employee.dart';
import 'package:corporatetransportapp/widgets/option_modal.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EmployeeList extends StatefulWidget {
  const EmployeeList({Key? key}) : super(key: key);

  @override
  State<EmployeeList> createState() => _EmployeeListState();
}

class _EmployeeListState extends State<EmployeeList> {
  @override
  Widget build(BuildContext context) {
    final dataController = Provider.of<DataController>(context);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 15.0),
        child: ListView.builder(
          itemCount: dataController.employees.length,
          itemBuilder: ((context, index) {
            return InkWell(
              onTap: () async {
                var res = await showOptionModal(
                    context,
                    dataController.employees[index].vehicleid,
                    dataController.vehicles.map((e) => e.platno).toList());
                if (res != null) {
                  dataController.updateBus(
                    bus: dataController.vehicles
                            .firstWhere((element) => element.platno == res)
                            .vehicleid ??
                        '',
                    userId: dataController.employees[index].employeeid ?? '',
                    role: "employee",
                  );
                }
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
                                        dataController.employees[index].name ??
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
                                        dataController.deleteEmployee(
                                            id: dataController.employees[index]
                                                    .employeeid ??
                                                '');
                                      },
                                      icon: const Icon(Icons.delete),
                                    )
                                  ],
                                ),
                                Text(
                                  dataController.employees[index].mobile ?? '',
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
                                        "#${dataController.vehicles.firstWhere((element) => element.vehicleid == dataController.employees[index].vehicleid, orElse: () => VehicleModel()).platno ?? 'N/A'}",
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
            Navigator.of(context).pushNamed(AddEmployee.routeName);
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
