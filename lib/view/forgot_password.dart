import 'package:corporatetransportapp/controller/data_controller.dart';
import 'package:corporatetransportapp/enum/roles.dart';
import 'package:corporatetransportapp/utils/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);
  static const routeName = "/forgotPassword";
  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final TextEditingController emailController = TextEditingController();
  Role? _selectedRole;
  @override
  Widget build(BuildContext context) {
    final dataController = Provider.of<DataController>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Forgot Password"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 50,
          ),
          Container(
            margin: const EdgeInsets.symmetric(
              horizontal: 15.0,
              vertical: 15.0,
            ),
            child: TextField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                filled: true,
                hintText: "Enter your registered email",
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            margin: const EdgeInsets.symmetric(
              horizontal: 15.0,
            ),
            width: double.infinity,
            height: 40,
            child: ElevatedButton(
              onPressed: () {
                FocusScope.of(context).requestFocus(FocusNode());
                final email = emailController.text.trim();
                if (email.isEmpty) {
                  snackBar("Please select role/enter email", context);
                  return;
                }

                dataController.resetPassword(email: email);
              },
              child: const Text("Reset Password"),
            ),
          ),
        ],
      ),
    );
  }
}
