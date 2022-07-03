import 'package:corporatetransportapp/view/admin/add_employee.dart';
import 'package:flutter/material.dart';

class EmployeeList extends StatefulWidget {
  const EmployeeList({Key? key}) : super(key: key);

  @override
  State<EmployeeList> createState() => _EmployeeListState();
}

class _EmployeeListState extends State<EmployeeList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 15.0),
        child: ListView.builder(
          itemCount: 10,
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
                              const Text(
                                "John Doe",
                                style: TextStyle(
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const Text(
                                "9298234889",
                                style: TextStyle(
                                  fontSize: 13.0,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: const [
                                  Icon(
                                    Icons.numbers,
                                    size: 15,
                                  ),
                                  Text(
                                    "MH04RG3422",
                                    style: TextStyle(
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
            Navigator.of(context).pushNamed(AddEmployee.routeName);
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
