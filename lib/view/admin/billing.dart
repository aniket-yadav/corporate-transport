import 'package:corporatetransportapp/controller/data_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Billing extends StatefulWidget {
  const Billing({Key? key}) : super(key: key);
  static const routeName = "billings";
  @override
  State<Billing> createState() => _BillingState();
}

class _BillingState extends State<Billing> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final dataController =
          Provider.of<DataController>(context, listen: false);
      dataController.getAllBills();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final dataController = Provider.of<DataController>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Bills"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: ListView.builder(
            itemCount: dataController.allBills.length,
            itemBuilder: (context, index) {
              return Container(
                margin: const EdgeInsets.symmetric(
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(6),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x1100000D),
                      blurRadius: 16,
                      spreadRadius: 0,
                    )
                  ],
                ),
                padding: const EdgeInsets.all(15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Bill Id : ${dataController.allBills[index].billId}"),
                    const SizedBox(
                      height: 7,
                    ),
                    Text(
                        "Employee Id : ${dataController.allBills[index].employeeId}"),
                    const SizedBox(
                      height: 7,
                    ),
                    Text(
                        "Duration: ${dataController.allBills[index].billingMonthYear}"),
                    const SizedBox(
                      height: 7,
                    ),
                    Text("Amount: ${dataController.allBills[index].amount}"),
                    const SizedBox(
                      height: 7,
                    ),
                    Text(
                        "Payment Status: ${dataController.allBills[index].paymentStatus == "true" ? "Paid" : "Not Paid"}"),
                    if (dataController.allBills[index].paymentStatus != "true")
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: () {
                              dataController.markPaid(
                                  dataController.allBills[index].billId ?? '');
                            },
                            child: const Text("Mark Paid"),
                          )
                        ],
                      )
                  ],
                ),
              );
            }),
      ),
    );
  }
}
