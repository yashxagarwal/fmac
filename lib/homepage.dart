import 'package:flutter/material.dart';
import 'package:fmac_application/Sign%20In/google_sign_in.dart';
import 'package:fmac_application/equipment_cards.dart';
import 'package:provider/provider.dart';

class homepage extends StatelessWidget {
  const homepage({Key? key}) : super(key: key);

  void signOutApp(BuildContext context) async {
    await Provider.of<GoogleSignInProvider>(context, listen: false).logOut();
    Navigator.of(context).pushReplacementNamed("/signin");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "FMaC",
          style: TextStyle(fontFamily: 'inter2'),
        ),
        backgroundColor: Colors.black87,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.logout),
          onPressed: () => signOutApp(context),
        ),
      ),
      body: equipmentcards(),
    );
  }
}
