import 'package:corporatetransportapp/assets/custom_theme.dart';
import 'package:corporatetransportapp/controller/data_controller.dart';
import 'package:corporatetransportapp/route/routes.dart';
import 'package:corporatetransportapp/utils/global_variable.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
//API key -  AIzaSyCjlgdj4BdbdMMpjwmWqnPbiTLmSgftBLY
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const TransportApp());
}

class TransportApp extends StatelessWidget {
  const TransportApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => DataController()),
      ],
      child: MaterialApp(
        navigatorKey: GlobalVariable.navState,
        routes: routes,
        debugShowCheckedModeBanner: false,
        theme: customTheme,
      ),
    );
  }
}
