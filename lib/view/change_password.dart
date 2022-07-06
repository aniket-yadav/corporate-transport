import 'package:flutter/material.dart';

class ChangePassword extends StatelessWidget {
  const ChangePassword({Key? key}) : super(key: key);
  static const routeName = "/changePassword";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Change Password"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 50,
            ),
            Container(
              margin: const EdgeInsets.symmetric(
                horizontal: 12.0,
                vertical: 10.0,
              ),
              child: const TextField(
                decoration: InputDecoration(
                  filled: true,
                  hintText: "Current Password",
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(
                horizontal: 12.0,
                vertical: 10.0,
              ),
              child: const TextField(
                decoration: InputDecoration(
                  filled: true,
                  hintText: "New Password",
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(
                horizontal: 12.0,
                vertical: 10.0,
              ),
              child: const TextField(
                decoration: InputDecoration(
                  filled: true,
                  hintText: "Confirm Password",
                ),
              ),
            ),
            Container(
              height: 45.0,
              width: double.infinity,
              margin: const EdgeInsets.symmetric(
                horizontal: 15.0,
              ),
              child: ElevatedButton(
                onPressed: () {},
                child: const Text(
                  "Submit",
                  style: TextStyle(
                    fontSize: 20.0,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
