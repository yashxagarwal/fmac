import 'package:flutter/material.dart';
import 'package:fmac_application/Sign%20In/google_sign_in.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import './data/data_collection.dart';
import 'package:sortedmap/sortedmap.dart';

class equipmentcards extends StatefulWidget {
  equipmentcards({Key? key}) : super(key: key);

  @override
  State<equipmentcards> createState() => _equipmentcardsState();
}

class _equipmentcardsState extends State<equipmentcards> {
  String? name = "";
  Map<String, dynamic> equipmentsList = {};
  String status = "loading";

  void equipment(BuildContext context) async {
    //print("object");
    final googleObj = await Provider.of<GoogleSignInProvider>(context).user;
    name = googleObj.displayName;
    //print("Name");
  }

  void updatedList(String device) async {
    print("Hello");
    equipment(context);
    var temp = Provider.of<dataCollectionProvider>(context, listen: false);
    await temp.updateList(device, this.name!);

    setState(() {});
  }

  void getData() async {
    var temp = Provider.of<dataCollectionProvider>(context, listen: false);
    await temp.getEquipment();

    equipmentsList = SortedMap(Ordering.byKey());
    equipmentsList.addAll(temp.equipmentList);
    if (!mounted) return;
    setState(() {
      status = "done";
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //equipmentsList = Provider.of<dataCollectionProvider>(context, listen: false).equipmentList;
  }

  @override
  Widget build(BuildContext context) {
    if (status == "loading") {
      getData();
    }
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/fmacappbg.png'), fit: BoxFit.cover)),
      child: status == "loading"
          ? Center(
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            )
          : Scaffold(
              backgroundColor: Colors.transparent,
              body: ListView(
                children: equipmentsList.entries.map((entry) {
                  print(entry.key);
                  return cardDesign(
                    equipment: entry.key,
                    name: entry.value,
                  );
                }).toList(),
              ),
            ),
    );
  }
}

class cardDesign extends StatefulWidget {
  String equipment;
  String name;

  cardDesign({
    Key? key,
    required this.equipment,
    required this.name,
  }) : super(key: key);

  @override
  State<cardDesign> createState() => _cardDesignState();
}

class _cardDesignState extends State<cardDesign> {
  TextEditingController holderName = new TextEditingController();
  void changeName({required String device}) async {
    print("Hello");
    final googleObj =
        await Provider.of<GoogleSignInProvider>(context, listen: false).user;
    print(googleObj.displayName);
    var name = holderName.text == "" ? googleObj.displayName : holderName.text;

    var temp = Provider.of<dataCollectionProvider>(context, listen: false);
    await temp.updateList(device, name!);

    setState(() {
      widget.name = name;
    });
  }

  @override
  Widget build(BuildContext context) {
    print("I was executed");
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        color: Color.fromARGB(255, 255, 255, 255).withOpacity(0.85),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              trailing: IconButton(
                icon: Icon(Icons.add),
                onPressed: () => changeName(device: widget.equipment),
              ),
              title: Text(
                widget.equipment,
                style: TextStyle(fontFamily: 'inter'),
                textScaleFactor: 1.1,
              ),
              subtitle: Text(
                'with ${widget.name}',
                style: TextStyle(
                  fontFamily: 'inter2',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0, bottom: 10),
              child: TextField(
                controller: holderName,
                decoration: InputDecoration(
                    hintText: "Enter Name of Holder",
                    // fillColor: Colors.blue,
                    border: InputBorder.none),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
