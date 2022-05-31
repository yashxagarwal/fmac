import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fmac_application/Sign%20In/signinpage.dart';
import 'package:fmac_application/homepage.dart';
import 'package:fmac_application/main.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_core/firebase_core.dart';

class Home_Page extends StatelessWidget {
  const Home_Page({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(),
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            //print(snapshot.toString());
            return homepage();
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          }
          return SignInPage();
        },
      ),
    );
  }
}
  
// class _Home_PageState extends State<Home_Page> {
//   GoogleSignIn _googleSignIn = GoogleSignIn();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: Text('hemlo'),
//         ),
//         body: StreamBuilder<User?>(
//             stream: FirebaseAuth.instance.authStateChanges(),
//             builder: (context, snapshot) {
//               if (snapshot.hasData) {
//                 return Container();
//               }
//               if (snapshot.connectionState == ConnectionState.waiting) {
//                 return const CircularProgressIndicator();
//               }
//               return Container(
//                 child: Center(
//                   child: GestureDetector(
//                     onTap: () async {
//                       final newuser = await _googleSignIn.signIn();
//                       final googleauth = await newuser!.authentication;
//                       final creds = GoogleAuthProvider.credential(
//                           accessToken: googleauth.accessToken,
//                           idToken: googleauth.idToken);
//                       await FirebaseAuth.instance.signInWithCredential(creds);
//                     },
//                     child: Center(
//                       child: Container(
//                         color: Colors.amber,
//                         child: Text('Loginwithgoogle'),
//                       ),
//                     ),
//                   ),
//                 ),
//               );
//             }));
//   }
// }
