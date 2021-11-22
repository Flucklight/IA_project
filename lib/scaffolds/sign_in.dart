import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ia_project/scaffolds/app.dart';
import 'package:ia_project/service/auth_service.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffe4e4e3),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(
            left: 16.0,
            right: 16.0,
            bottom: 20.0,
          ),
          child: Column(mainAxisSize: MainAxisSize.max, children: [
            Row(),
            Expanded(
                child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                  Flexible(
                    flex: 1,
                    child:
                        Image.asset('lib/assets/metro_logo.png', height: 160),
                  ),
                  const SizedBox(height: 20),
                  _signInButton(context)
                ]))
          ]),
        ),
      ),
    );
  }

  Widget _signInButton(BuildContext context) {
    return FutureBuilder(
      future: Firebase.initializeApp(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return FloatingActionButton.extended(
              onPressed: () {
                signInWithGoogle().whenComplete(() {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => const App(),
                    ),
                  );
                });
              },
              backgroundColor: const Color(0xff838382),
              icon: Image.asset("lib/assets/google_logo.png",
                  height: 32, width: 32),
              label: const Text('Iniciar sesión con Google'));
        } else {
          return const CupertinoActivityIndicator();
        }
      },
    );
  }
}
