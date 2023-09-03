import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class sign extends StatefulWidget {
  const sign({super.key});

  @override
  State<sign> createState() => _signState();
}

class _signState extends State<sign> {

  static Future<User?> _loginUsingEmailPassword ({required String email , required String password , required BuildContext context})async{
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user ;
    try{
      UserCredential userCredential = await auth.signInWithEmailAndPassword(email: email, password: password);
      user = userCredential.user;
    }on FirebaseAuthException catch(e){
      if (e.code == "user not found"){
        print('No user found for that email');
      }
    }
    return user ;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
