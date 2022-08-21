import 'package:corporatetransportapp/controller/data_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyBilling extends StatefulWidget {
  const MyBilling({Key? key}) : super(key: key);
  static const routeName = "myBillings";
  @override
  State<MyBilling> createState() => _MyBillingState();
}

class _MyBillingState extends State<MyBilling> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final dataController =
          Provider.of<DataController>(context, listen: false);
      dataController.fetchAllMyBillings();
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
            itemCount: dataController.allMyBills.length,
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
                    Text(
                        "Bill Id : ${dataController.allMyBills[index].billId}"),
                    const SizedBox(
                      height: 7,
                    ),
                    Text(
                        "Duration: ${dataController.allMyBills[index].billingMonthYear}"),
                    const SizedBox(
                      height: 7,
                    ),
                    Text("Amount: ${dataController.allMyBills[index].amount}"),
                    const SizedBox(
                      height: 7,
                    ),
                    Text(
                        "Payment Status: ${dataController.allMyBills[index].paymentStatus == "true" ? "Paid" : "Not Paid"}"),
                    if (dataController.allMyBills[index].paymentStatus !=
                        "true")
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: () {
                             dataController.makePayment(
                                  amount: dataController
                                          .allMyBills[index].amount ??
                                      '',
                                  orderid: dataController.allMyBills[index].billId ??
                                      '');
                            },
                            child: const Text("Pay now"),
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
