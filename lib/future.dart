import 'package:ai/login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class future extends StatefulWidget {
  const future({super.key});

  @override
  State<future> createState() => _futureState();
}

class _futureState extends State<future> {

  Future<FirebaseApp> _initializeFirebase() async{
    FirebaseApp firebaseApp = await Firebase.initializeApp();
    return firebaseApp;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Log In',style: TextStyle(fontFamily:'Anton-Regular'),),
          centerTitle: true,
          backgroundColor: Colors.grey,
          actions: [
            Icon(
              Icons.threesixty_rounded,
              size: 20,
            )
          ],
        ),
        body: FutureBuilder(
          future: _initializeFirebase(),
          builder: (context , snapshot){
            if(snapshot.connectionState == ConnectionState.done){
              return login();
            }
            return const Center(child: CircularProgressIndicator(),
            );
          },
        )
    );
  }
}
