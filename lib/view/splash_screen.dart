import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:corporatetransportapp/assets/constants.dart' as constants;

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);
static const  routeName ="/";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const [
            Text(
              constants.appName,
            ),
          ],
        ),
      ),
    );
  }
}
