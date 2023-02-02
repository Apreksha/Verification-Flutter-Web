import 'package:authe/homepage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
        //these are variable for each firebase project
          apiKey: "AIzaSyCt0gWtHfeP_8zRehBi3vX1bWODgyM_RSs",
          authDomain: "auth-3fcf7.firebaseapp.com",
          projectId: "auth-3fcf7",
          storageBucket: "auth-3fcf7.appspot.com",
          messagingSenderId: "855924669317",
          appId: "1:855924669317:web:b99e4fb211673cebd4a2ec",
          measurementId: "G-JF0QWJZSB8")
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}