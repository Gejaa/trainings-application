import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mytrainingsapp/screens/home_trainings_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FirebaseApp firebaseApp=await Firebase.initializeApp();
  runApp( MaterialApp(
    theme: ThemeData(
      primarySwatch: Colors.blue,
    ),
    debugShowCheckedModeBanner: false,
    home: HomeTrainingsScreen(firebaseApp: firebaseApp,),
  ));
}
