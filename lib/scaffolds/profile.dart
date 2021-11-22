import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:ia_project/scaffolds/sign_in.dart';
import 'package:ia_project/service/auth_service.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          CircleAvatar(
            backgroundImage: NetworkImage(
              userAcount.photoURL,
            ),
            radius: 60,
            backgroundColor: Colors.transparent,
          ),
          const SizedBox(height: 40),
          const Text(
            'Nombre',
            style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Colors.black54),
          ),
          Text(userAcount.displayName),
          const SizedBox(height: 20),
          const Text(
            'Email',
            style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Colors.black54),
          ),
          Text(
            userAcount.email,
          ),
          const SizedBox(height: 40),
          FloatingActionButton.extended(
              onPressed: () {
                signOutGoogle();
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) {
                  return const SignIn();
                }), ModalRoute.withName('/'));
              },
              backgroundColor: const Color(0xff838382),
              label: const Text(
                'Cerrar sesión',
                style: TextStyle(fontSize: 20),
              ))
        ],
      ),
    );
  }
}
