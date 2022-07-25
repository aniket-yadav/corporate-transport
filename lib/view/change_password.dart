import 'package:corporatetransportapp/controller/data_controller.dart';
import 'package:corporatetransportapp/utils/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({Key? key}) : super(key: key);
  static const routeName = "/changePassword";

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final TextEditingController oldPasswordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  bool _obscureTextCurrent = true;
  bool _obscureTextNew = true;
  bool _obscureTextConfirm = true;

  void _toggleCurrent() {
    setState(() {
      _obscureTextCurrent = !_obscureTextCurrent;
    });
  }

  void _toggleNew() {
    setState(() {
      _obscureTextNew = !_obscureTextNew;
    });
  }

  void _toggleConfirm() {
    setState(() {
      _obscureTextConfirm = !_obscureTextConfirm;
    });
  }

  @override
  Widget build(BuildContext context) {
    final dataController = Provider.of<DataController>(context);
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
              child: TextField(
                controller: oldPasswordController,
                decoration: InputDecoration(
                  filled: true,
                  hintText: "Current Password",
                  prefixIcon: const Icon(
                    Icons.lock_outline,
                  ),
                  suffixIcon: IconButton(
                    onPressed: _toggleCurrent,
                    icon: Icon(
                      _obscureTextCurrent
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                  ),
                ),
                keyboardType: TextInputType.visiblePassword,
                obscureText: _obscureTextCurrent,
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(
                horizontal: 12.0,
                vertical: 10.0,
              ),
              child: TextField(
                controller: newPasswordController,
                decoration: InputDecoration(
                  filled: true,
                  hintText: "New Password",
                  prefixIcon: const Icon(
                    Icons.lock_outline,
                  ),
                  suffixIcon: IconButton(
                    onPressed: _toggleNew,
                    icon: Icon(
                      _obscureTextNew ? Icons.visibility : Icons.visibility_off,
                    ),
                  ),
                ),
                keyboardType: TextInputType.visiblePassword,
                obscureText: _obscureTextNew,
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(
                horizontal: 12.0,
                vertical: 10.0,
              ),
              child: TextField(
                controller: confirmPasswordController,
                decoration: InputDecoration(
                  filled: true,
                  hintText: "Confirm Password",
                  prefixIcon: const Icon(
                    Icons.lock_outline,
                  ),
                  suffixIcon: IconButton(
                    onPressed: _toggleCurrent,
                    icon: Icon(
                      _obscureTextConfirm
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                  ),
                ),
                obscureText: _obscureTextConfirm,
                keyboardType: TextInputType.visiblePassword,
              ),
            ),
            Container(
              height: 45.0,
              width: double.infinity,
              margin: const EdgeInsets.symmetric(
                horizontal: 15.0,
                vertical: 50.0,
              ),
              child: ElevatedButton(
                onPressed: () {
                  final oldPass = oldPasswordController.text.trim();
                  final newPass = newPasswordController.text.trim();
                  final confirmPass = confirmPasswordController.text.trim();
                  if (newPass == confirmPass) {
                    dataController.changePassword(
                        role: dataController.user.role ?? '',
                        oldPassword: oldPass,
                        newPassword: newPass);
                  } else {
                    snackBar("new password and confirm password does not match",
                        context);
                  }
                },
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
