import 'package:ai/login.dart';
// import 'package:chat_ai/messaginghere.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

// import 'package:flutter_stripe/flutter_stripe.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // Stripe.publishableKey='pk_test_51NjekpD2nWLJscfgASqPMpRU3PaznVOLVgQ0fj5gy1bmamMc990ObjgdqNUnoxGJaULkBI7AfZSTHuYmvkqoCBfo00iGAjBpU7';
  // Stripe.merchantIdentifier = 'Sarwar';
  // await Stripe.instance.applySettings();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: new ThemeData(scaffoldBackgroundColor: Colors.black26),
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        home: login());
  }
}
