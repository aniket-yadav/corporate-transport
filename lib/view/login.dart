import 'package:corporatetransportapp/controller/data_controller.dart';
import 'package:corporatetransportapp/view/forgot_password.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);
  static const routeName = "/login";
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool _obscureText = true;
  // Toggles the password show status
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xff287f95),
            Color(0xff589cac),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          tileMode: TileMode.repeated,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: InkWell(
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: SafeArea(
            child: SingleChildScrollView(
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.symmetric(
                        horizontal: 20.0,
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 15.0,
                        vertical: 25.0,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0x1100000D),
                            blurRadius: 16,
                            spreadRadius: 0,
                          )
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Login",
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(
                              top: 15.0,
                            ),
                            child: TextField(
                              controller: usernameController,
                              decoration: const InputDecoration(
                                filled: true,
                                prefixIcon: Icon(
                                  Icons.person_outline,
                                ),
                                hintText: "username",
                              ),
                              
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(
                              top: 15.0,
                            ),
                            child: TextField(
                              controller: passwordController,
                              decoration: InputDecoration(
                                filled: true,
                                prefixIcon: const Icon(
                                  Icons.lock_outline,
                                ),
                                hintText: "password",
                                suffixIcon: IconButton(
                                  onPressed: _toggle,
                                  icon: Icon(
                                    _obscureText
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                  ),
                                ),
                              ),
                              obscureText: _obscureText,
                              keyboardType: TextInputType.visiblePassword,
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(
                              top: 20.0,
                            ),
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                final dataProvider =
                                    Provider.of<DataController>(context,
                                        listen: false);
                                final username = usernameController.text.trim();
                                final password = passwordController.text.trim();
                                if (username.isEmpty || password.isEmpty) {
                                  return;
                                }
                                dataProvider.login(
                                    username: username, password: password);
                              },
                              child: const Text("Login"),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.of(context)
                                  .pushNamed(ForgotPassword.routeName);
                            },
                            child: Container(
                              alignment: Alignment.center,
                              padding: const EdgeInsets.all(10),
                              margin: const EdgeInsets.only(top: 20),
                              child: const Text(
                                "Forgot password",
                                style: TextStyle(
                                  fontSize: 14.0,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
