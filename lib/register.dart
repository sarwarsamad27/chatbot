import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'login.dart';

class register extends StatefulWidget {
  const register({super.key});

  @override
  State<register> createState() => _registerState();
}

class _registerState extends State<register> {
  // final _dateController = useTextEditingController();

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    return Scaffold(
      body: Column(
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 10),
                child: Text(
                  'Account Registration',
                  style: TextStyle(
                      color: Colors.black26,
                      fontSize: 45,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Anton-Regular'),
                ),
              ),
            ],
          ),const SizedBox(height: 20,),
          Container(
            height: 300,
            width: 600,
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                const BoxShadow(
                  color: Colors.white,
                  blurRadius: 8,
                  offset: Offset(4, 8), // Shadow position
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(6.0),
              child: Column(
                children: [
                  ListTile(
                    title: const Text('Name'),
                    subtitle: TextField(
                      cursorColor: Colors.white,
                      textCapitalization: TextCapitalization.words,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.person),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide.none),
                        hintText: "Enter your name",
                        alignLabelWithHint: false,
                        filled: true,
                      ),
                      keyboardType: TextInputType.visiblePassword,
                      textInputAction: TextInputAction.done,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  // Row(
                  //   children: [
                  //     Expanded(
                  //       child: ListTile(
                  //         title: Text('Department'),
                  //         subtitle: TextFormField(
                  //           decoration: const InputDecoration(
                  //             border: OutlineInputBorder(
                  //                 borderRadius: BorderRadius.all(Radius.circular(8))),
                  //             hintText: '  Department',
                  //           ),
                  //         ),),
                  //     ),
                  //     SizedBox(
                  //       width: 5,
                  //     ),
                  //     Expanded(
                  //       child:ListTile(
                  //         title: Text('Year Of Study'),
                  //         subtitle:  TextFormField(
                  //           decoration: const InputDecoration(
                  //             border: OutlineInputBorder(
                  //                 borderRadius: BorderRadius.all(Radius.circular(8))),
                  //             hintText: '  Year Of Study',
                  //           ),
                  //         ),),
                  //     ),
                  //
                  //     SizedBox(
                  //       width: 5,
                  //     ),
                  //     Expanded(
                  //       child:ListTile(
                  //         title: Text('Year Of Study'),
                  //         subtitle:  TextFormField(
                  //           decoration: const InputDecoration(
                  //             border: OutlineInputBorder(
                  //                 borderRadius: BorderRadius.all(Radius.circular(8))),
                  //             hintText: '  Year Of Study',
                  //           ),
                  //         ),),
                  //     ),
                  //
                  //   ],
                  // ),,

                  // Padding(
                  //   padding: const EdgeInsets.only(top: 10,left: 20,right: 20),
                  //   child: TextFormField(
                  //     readOnly: true,
                  //     controller: _dateController,
                  //     decoration: InputDecoration(
                  //       hintText: "date of birth",
                  //       border: OutlineInputBorder(
                  //         borderRadius: BorderRadius.circular(10)
                  //       )
                  //     ),
                  //     onTap: () async {
                  //       await showDatePicker(
                  //         context: context,
                  //         initialDate: DateTime.now(),
                  //         firstDate: DateTime(2015),
                  //         lastDate: DateTime(2025),
                  //       ).then((selectedDate) {
                  //         if (selectedDate != null) {
                  //           _dateController.text=DateFormat('yyyy-MM-dd').format(selectedDate);
                  //         }
                  //       });
                  //     },
                  //     validator: (value) {
                  //       if (value == null || value.isEmpty) {
                  //         return 'Please enter date.';
                  //       }
                  //       return null;
                  //     },
                  //   ),
                  // )
                  ListTile(
                    title: const Text('Email'),
                    subtitle: TextField(
                      controller: emailController,
                      cursorColor: Colors.white,
                      textCapitalization: TextCapitalization.words,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.email),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide.none),
                        hintText: "Enter your valid Email",
                        alignLabelWithHint: false,
                        filled: true,
                      ),
                      keyboardType: TextInputType.visiblePassword,
                      textInputAction: TextInputAction.done,
                    ),
                  ),

                  const SizedBox(
                    height: 20,
                  ),

                  ListTile(
                    title: const Text('Password'),
                    subtitle: TextField(
                      controller: passwordController,
                      cursorColor: Colors.white,
                      decoration: InputDecoration(
                        prefixIcon:const Icon(Icons.lock),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide.none),
                        hintText: "password",
                        alignLabelWithHint: false,
                        filled: true,
                      ),
                      keyboardType: TextInputType.visiblePassword,
                      textInputAction: TextInputAction.done,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            height: 50,
            width: 200,
            decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                const BoxShadow(
                  color: Colors.white,
                  blurRadius: 8,
                  offset: Offset(4, 8), // Shadow position
                ),
              ],
            ),
            child: Center(
                child: InkWell(
                  child: const Text(
                    'Register',
                    style: TextStyle(fontFamily: 'Anton-Regular', fontSize: 20),
                  ),
                  onTap: () {
                    FirebaseAuth.instance
                        .createUserWithEmailAndPassword(
                        email: emailController.text,
                        password: passwordController.text)
                        .then((value) {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => const login()));
                    }).onError((error, stackTrace) {
                      print("Error ${error.toString()}");
                      emailController.text = '';
                      passwordController.text = '';
                      setState(() {
                        print(error);
                      });
                    });
                  },
                )),
          ),
        ],
      ),
    );
  }

// static useTextEditingController() {}
//
// DateFormat(String s) {
//   setState(() {
//
//   });
}
