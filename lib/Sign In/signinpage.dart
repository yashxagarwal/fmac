import 'package:flutter/material.dart';
import 'package:fmac_application/Sign%20In/google_sign_in.dart';
import 'package:fmac_application/homepage.dart';
import 'package:provider/provider.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  String status = "Not Signed In";

  void logIn(BuildContext context) async {
    final provider = Provider.of<GoogleSignInProvider>(context, listen: false);
    await provider.googleLogin();
    Navigator.of(context).pushReplacementNamed("/home");
  }

  void checkStatus() async {
    final provider = Provider.of<GoogleSignInProvider>(context, listen: false);

    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkStatus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF292929),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 80),
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: Text(
                'film making club.',
                style: TextStyle(fontFamily: 'inter', color: Colors.white),
                textScaleFactor: 4,
              ),
            ),
            // Image.asset('assets/Fmac Vertical white with text LOGO.png',
            //     scale: 8),
            SizedBox(height: 100),
            ElevatedButton(
              style: ButtonStyle(
                  padding: MaterialStateProperty.all(
                      EdgeInsets.fromLTRB(30, 15, 30, 15)),
                  backgroundColor: MaterialStateProperty.all<Color>(
                      Color.fromARGB(255, 34, 34, 34))),
              onPressed: () => logIn(context),
              child: const Text(
                'Sign In with BITS ID',
                textScaleFactor: 1.3,
                style: TextStyle(fontFamily: 'inter'),
              ),
            ),
            SizedBox(
              height: 79.6,
            ),
            Image.asset(
              'assets/fmacnew2.png',
            )
          ],
        ),
      ),
    );
  }
}
