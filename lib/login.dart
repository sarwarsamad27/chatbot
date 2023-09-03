// import 'dart:html';

import 'package:ai/register.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'message.dart';

class login extends StatefulWidget {
  const login({super.key});

  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
  // GlobalKey<FormState> _userLoginFormKey = GlobalKey();
  // late FirebaseUser _user;
  // final FirebaseAuth _auth = FirebaseAuth.instance;
  // final GoogleSignIn _googleSignIn = GoogleSignIn();
  //
  // bool isSignIn =false;
  // bool google =false;

  // bool passwordVisible = false;
  // @override
  // void initState() {
  //
  //   passwordVisible = true;
  // }

  static Future<User?> _loginUsingEmailPassword(
      {required String email,
      required String password,
      required BuildContext context}) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      user = userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == "user not found") {
        print('No user found for that email');
      }
    }
    return user;
  }

  // @override
  // dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    return Scaffold(
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 80,
                width: 100,
                decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image: NetworkImage(
                            'https://static1.xdaimages.com/wordpress/wp-content/uploads/2018/02/Flutter-Framework-Feature-Image-Background-Colour.png'),
                        fit: BoxFit.fill)),
              ),
              const Text(
                'Welcome to\n Flutter Chat',
                style: TextStyle(
                    fontFamily: 'Anton-Regular',
                    fontSize: 30,
                    color: Colors.white),
              )
            ],
          ),
          const SizedBox(
            height: 50,
          ),
          Column(
            children: [
              Container(
                width: 300,
                height: 220,
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
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        height: 60,
                        width: 550,
                        decoration: BoxDecoration(
                            border: Border.all(width: 3, color: Colors.grey),
                            color: const Color(0xffe9ebec),
                            borderRadius: BorderRadius.circular(20)),
                        child: TextField(
                          controller: emailController,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            labelText: "Email",
                            prefixIcon: Icon(Icons.email),
                            alignLabelWithHint: false,
                            filled: true,
                          ),
                          keyboardType: TextInputType.visiblePassword,
                          textInputAction: TextInputAction.done,
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Container(
                        height: 60,
                        width: 550,
                        decoration: BoxDecoration(
                            border: Border.all(width: 3, color: Colors.grey),
                            color: const Color(0xffe9ebec),
                            borderRadius: BorderRadius.circular(20)),
                        child: TextField(
                          controller: passwordController,
                          obscureText: true,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            labelText: "Password",
                            prefixIcon: Icon(Icons.lock),
                            alignLabelWithHint: false,
                            filled: true,
                          ),
                          keyboardType: TextInputType.visiblePassword,
                          textInputAction: TextInputAction.done,
                        ),
                      ),
                      // Padding(
                      //   padding: const EdgeInsets.only(left: 8.0),
                      //   child: Text(
                      //     'forgot Password?',
                      //     style: TextStyle(fontWeight: FontWeight.bold),
                      //   ),
                      // )
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            height: 50,
            width: 200,
            child: RawMaterialButton(
              fillColor: Colors.black26,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              onPressed: () async {
                User? user = await _loginUsingEmailPassword(
                    email: emailController.text,
                    password: passwordController.text,
                    context: context);
                emailController.text = '';
                passwordController.text = '';
                print(user);
                if (user != null) {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => const message()));
                }
              },
              child: const Text(
                'Login',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            decoration: const BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.white,
                  blurRadius: 8,
                  offset: Offset(4, 8), // Shadow position
                ),
              ],
            ),
          ),
          //   Center(
          //       child: Text(
          //     'Log In',
          //     style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          //   )),
          //   decoration: BoxDecoration(
          //       color: Colors.black26,
          //       borderRadius: BorderRadius.circular(20)),
          // ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Center(child: Text("Don't have an account?")),
              InkWell(
                child: const Text(
                  'Sign in',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline),
                ),
                onTap: () {
                  setState(() {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const register()));
                  });
                },
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 80, top: 20),
            child: Row(
              children: [
                InkWell(
                  child: Container(
                      height: 40,
                      width: 120,
                      decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(10)),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child:
                                const Icon(FontAwesomeIcons.google, size: 20),
                          ),
                          Text('SignIn with\ngoogle'),
                        ],
                      )),
                  onTap: () => AuthService().signInWithGoogle(),
                  // async{
                  //     signInWithGoogle(model)
                  //       .then((FirebaseUser user){
                  //     model.clearAllModels();
                  //     Navigator.of(context).push
                  //       (MaterialPageRoute(builder: (context)=>
                  //
                  //     )
                  //
                  //     ) ;}
                  //   ).catchError((e) => print(e));
                  // },
                ),
                const SizedBox(
                  width: 15,
                ),
                Container(
                  height: 40,
                  width: 120,
                  decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(10)),
                ),
                // Container(
                //   height: 30,
                //   width: 30,
                //   color: Colors.green,
                // ),SizedBox(width: 10,),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            height: 40,
            width: 120,
            decoration: BoxDecoration(
                color: Colors.green, borderRadius: BorderRadius.circular(10)),
          ),
          // Center(
          //   child: InkWell(
          //     child: Text(
          //       'Sign in',
          //       style: TextStyle(
          //           fontWeight: FontWeight.bold,
          //           decoration: TextDecoration.underline),
          //     ),
          //     onTap: () {
          //       setState(() {
          //         Navigator.push(context,
          //             MaterialPageRoute(builder: (context) => register()));
          //       });
          //     },
          //   ),
          // ),

// loginUsingEmailPassword({required String email, required String password, required BuildContext context}) {
// }  Center(child: Text('Sign In'))
        ],
      ),
    );
  }

// Future<FirebaseUser> signInWithGoogle(SignInViewModel model) async {
//   model.state =ViewState.Busy;
//
//   GoogleSignInAccount? googleSignInAccount = await _googleSignIn.signIn();
//
//   GoogleSignInAuthentication googleSignInAuthentication =
//
//   await googleSignInAccount!.authentication;
//
//   AuthCredential credential = GoogleAuthProvider.getCredential(
//
//     accessToken: googleSignInAuthentication.accessToken,
//
//     idToken: googleSignInAuthentication.idToken,
//
//   );
//
//   AuthResult authResult = await _auth.signInWithCredential(credential);
//
//   _user = authResult.user;
//
//   assert(!_user.isAnonymous);
//
//   assert(await _user.getIdToken() != null);
//
//   FirebaseUser currentUser = await _auth.currentUser!;
//
//   assert(_user.uid == currentUser.uid);
//
//
//   model.state =ViewState.Idle;
//
//   print("User Name: ${_user.displayName}");
//   print("User Email ${_user.email}");
//
// }
}

// class ViewState {
// }
//
// mixin FirebaseUser {
//   var email;
//
//   var displayName;
//
//   get uid => null;
// }
//

class AuthService {
  signInWithGoogle() async {
    final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication gAuth = await gUser!.authentication;
    final Credential = GoogleAuthProvider.credential(
      accessToken: gAuth.accessToken,
      idToken: gAuth.idToken,
    );
    return await FirebaseAuth.instance.signInWithCredential(Credential);
  }
}
