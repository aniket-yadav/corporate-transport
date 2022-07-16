import 'package:corporatetransportapp/controller/data_controller.dart';
import 'package:corporatetransportapp/view/admin/add_driver.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DriverList extends StatefulWidget {
  const DriverList({Key? key}) : super(key: key);

  @override
  State<DriverList> createState() => _DriverListState();
}

class _DriverListState extends State<DriverList> {
  @override
  Widget build(BuildContext context) {
    final dataController = Provider.of<DataController>(context);
    print(dataController.drivers);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 15.0),
        child: ListView.builder(
          itemCount: dataController.drivers.length,
          itemBuilder: ((context, index) {
            return Card(
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
                              Text(
                                dataController.drivers[index].name ?? '',
                                style: const TextStyle(
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.w600,
                                ),
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
                                  const Icon(
                                    Icons.numbers,
                                    size: 15,
                                  ),
                                  Text(
                                    dataController.drivers[index].vehicleid ??
                                        '',
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
            Icons.person_add,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
