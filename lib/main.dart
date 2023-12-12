import 'package:custom_card_flip/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
void main(){
  WidgetsFlutterBinding.ensureInitialized();
  //  Setting the app only in on Orientation
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp,DeviceOrientation.portraitDown]);
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const  MaterialApp(
      home: HomeScreen(),

    );
  }
}
