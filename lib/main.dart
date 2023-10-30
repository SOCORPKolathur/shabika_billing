import 'package:flutter/material.dart';
import 'LandingPage/LandingPage.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
        apiKey: "AIzaSyDR6I-aZpCAAK4wYRD573PeRALEMfgpTTY",
        authDomain: "billingapp-cab55.firebaseapp.com",
        projectId: "billingapp-cab55",
        storageBucket: "billingapp-cab55.appspot.com",
        messagingSenderId: "873474452092",
        appId: "1:873474452092:web:d72fcc0a5e363fcc4b77f9",
        measurementId: "G-VJP1FD05QV"
    )
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: drawer("Admin"),
    );
  }
}
