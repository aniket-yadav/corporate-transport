import 'package:corporatetransportapp/route/routes.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

void main() {
  runApp(const TransportApp());
}

class TransportApp extends StatelessWidget {
  const TransportApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NeumorphicApp(
      routes: routes,
      theme: const NeumorphicThemeData(
        baseColor: Color(0xff121212),    
      ),
    );
  }
}
