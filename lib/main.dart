import 'package:flutter/material.dart';
import 'package:fmac_application/Sign%20In/google_sign_in.dart';
import 'package:fmac_application/Sign%20In/home_page.dart';
import 'package:fmac_application/Sign%20In/signinpage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fmac_application/data/data_collection.dart';
import 'package:fmac_application/homepage.dart';
import 'package:provider/provider.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => GoogleSignInProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => dataCollectionProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Home_Page(),
        routes: {
          //"/": (context) => Home_Page(),
          "/home": (context) => homepage(),
          "/signin": (context) => SignInPage(),
        },
      ),
    );
  }
}
