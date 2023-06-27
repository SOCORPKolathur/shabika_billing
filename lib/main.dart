import 'package:flutter/material.dart';
import 'LandingPage/LandingPage.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
        apiKey: "AIzaSyDDqPX05pYKoB1QlDvCIBJdp0MhHh2uAS8",
        authDomain: "billingapp-c34a2.firebaseapp.com",
        projectId: "billingapp-c34a2",
        storageBucket: "billingapp-c34a2.appspot.com",
        messagingSenderId: "544636933687",
        appId: "1:544636933687:web:3ce548d8529565f97391b2",
        measurementId: "G-6L3VHHH0MF"
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
      home:drawer(),
    );
  }
}
