import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:prico/admin_login.dart';
import 'package:prico/database_helper.dart';
import 'about_me.dart';
import 'user_search_list.dart';
import 'package:prico/open_admin_options.dart';
import 'package:prico/open_search.dart';
import 'user_search_list.dart';
import 'models.dart';

class GetStarted extends StatefulWidget {
  Map<dynamic, dynamic> loginObjects;
  GetStarted(this.loginObjects);

  @override
  _GetStartedState createState() => _GetStartedState();
}

class _GetStartedState extends State<GetStarted> {
  String _scanBarcode = 'Unknown';

  Future<void> scanQR() async {
    List<Map<String, dynamic>> queryRows =
        await DatabaseHelper.instance.queryAll();

    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.BARCODE);
      //print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    //setState(() {
    //  _scanBarcode = barcodeScanRes;
    //});
    _scanBarcode = barcodeScanRes;
    //print(_scanBarcode.runtimeType);

    var productObject = {};
    for (int i = 0; i < queryRows.length; i++) {
      if (queryRows[i]["productCode"]
          .toString()
          .contains(_scanBarcode.toString())) {
        productObject = queryRows[i];
        break;
      }
    }
    //print(barcodeScanRes);
    //print(productObject["productCode"]);
    //print(productObject);

    if (productObject["productCode"].toString() == barcodeScanRes.toString()) {
      //================PRICE PULLOUT-----DATABASE
      String inDatabase = productObject["productCode"].toString();
      String printProduct = productObject["productName"].toString();
      String printPrice = productObject["productAmount"].toString();

      setState(() {
        //_scanBarcode = printPrice;
        Get.defaultDialog(
            title: 'Prico',
            backgroundColor: Color(0xFF482b9a),
            titleStyle: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w200,
                letterSpacing: 3.0),
            content: setupAlertDialoadContainer(
                inDatabase, printPrice, printProduct));
      });
    } else if (_scanBarcode == '-1') {
      print("******************Nothing Scanned*********************");
    } else if (productObject["productCode"].toString() !=
        barcodeScanRes.toString()) {
      setState(() {
        //DATABASE SCANNED PRODUCT*********************************************
        Get.defaultDialog(
            title: 'Prico',
            backgroundColor: Color(0xFF482b9a),
            titleStyle: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w200,
                letterSpacing: 3.0),
            content: setupAlertDialoadContainer("N/A", "0.00", "N/A"));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'PRICO',
            style: TextStyle(
              fontWeight: FontWeight.w200,
              letterSpacing: 3.0,
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 50.0,
          ),
          Expanded(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      child: Icon(
                        FontAwesomeIcons.cartShopping,
                        color: Colors.black,
                        size: 20.0,
                      ),
                      backgroundColor: Colors.white,
                      radius: 30.0,
                    ),
                  ],
                ),
                SizedBox(
                  height: 30.0,
                ),
                Text(
                  'OPTIONS',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15.0,
                  ),
                ),
                Expanded(
                  child: Container(
                    margin:
                        EdgeInsets.symmetric(vertical: 20.0, horizontal: 110.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: ListView(
                      children: [
                        Column(
                          children: [
                            SizedBox(
                              height: 20.0,
                            ),
                            ElevatedButton(
                              onPressed: () {
                                scanQR();
                              },
                              child: new Icon(
                                FontAwesomeIcons.barcode,
                                color: Colors.white,
                                size: 30.0,
                              ),
                              style: ElevatedButton.styleFrom(
                                  shape: CircleBorder(),
                                  padding: EdgeInsets.all(15),
                                  primary: Color(0xFF482b9a)),
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            new GestureDetector(
                              onTap: () {
                                scanQR();
                              },
                              child: new Text(
                                "Find Price",
                                style: TextStyle(
                                  fontWeight: FontWeight.w300,
                                  letterSpacing: 1,
                                  color: Color(0xFF482b9a),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 100.0,
                              child: Divider(
                                color: Color(0xFF482b9a),
                              ),
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) {
                                    return OpenSearch();
                                  }),
                                );
                              },
                              child: new Icon(
                                FontAwesomeIcons.magnifyingGlass,
                                color: Colors.white,
                                size: 30.0,
                              ),
                              style: ElevatedButton.styleFrom(
                                  shape: CircleBorder(),
                                  padding: EdgeInsets.all(15),
                                  primary: Color(0xFF482b9a)),
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            new GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) {
                                    return OpenSearch();
                                  }),
                                );
                              },
                              child: new Text(
                                "Search",
                                style: TextStyle(
                                  fontWeight: FontWeight.w300,
                                  letterSpacing: 1,
                                  color: Color(0xFF482b9a),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 100.0,
                              child: Divider(
                                color: Color(0xFF482b9a),
                              ),
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) {
                                    return AdminLogin(widget.loginObjects);
                                  }),
                                );
                              },
                              child: new Icon(
                                FontAwesomeIcons.lock,
                                color: Colors.white,
                                size: 30.0,
                              ),
                              style: ElevatedButton.styleFrom(
                                  shape: CircleBorder(),
                                  padding: EdgeInsets.all(15),
                                  primary: Color(0xFF482b9a)),
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            new GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) {
                                    return AdminLogin(widget.loginObjects);
                                  }),
                                );
                              },
                              child: new Text(
                                "Admin",
                                style: TextStyle(
                                  fontWeight: FontWeight.w300,
                                  letterSpacing: 1,
                                  color: Color(0xFF482b9a),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 100.0,
                              child: Divider(
                                color: Color(0xFF482b9a),
                              ),
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) {
                                    return AboutUsMe();
                                  }),
                                );
                              },
                              child: new Icon(
                                FontAwesomeIcons.addressCard,
                                color: Colors.white,
                                size: 30.0,
                              ),
                              style: ElevatedButton.styleFrom(
                                  shape: CircleBorder(),
                                  padding: EdgeInsets.all(15),
                                  primary: Color(0xFF482b9a)),
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            new GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) {
                                    return AboutUsMe();
                                  }),
                                );
                              },
                              child: new Text(
                                "About",
                                style: TextStyle(
                                  fontWeight: FontWeight.w300,
                                  letterSpacing: 1,
                                  color: Color(0xFF482b9a),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          //==========================================
        ],
      ),
    );
  }
}

class Optionx extends StatelessWidget {
  Optionx(
      {required this.OptionName,
      required this.OptionIcon,
      required this.OptionQrcode});
  final String OptionName;
  final IconData OptionIcon;
  final Function OptionQrcode;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 30.0,
        ),
        ElevatedButton(
          onPressed: () {},
          child: new Icon(
            OptionIcon,
            color: Colors.black,
            size: 55.0,
          ),
          style: ElevatedButton.styleFrom(
              shape: CircleBorder(),
              padding: EdgeInsets.all(15),
              primary: Colors.white),
        ), //DATABASE SCANNED PRODUCT
        SizedBox(
          height: 10.0,
        ),
        Text(
          OptionName,
          style: TextStyle(fontWeight: FontWeight.w900),
        ),
        SizedBox(
          width: 100.0,
          child: Divider(
            color: Color(0xFF482b9a),
          ),
        ),
      ],
    );
  }
}

String totTitle(String input) {
  final List<String> splitStr = input.split(' ');
  for (int i = 0; i < splitStr.length; i++) {
    splitStr[i] = '${splitStr[i][0].toUpperCase()}${splitStr[i].substring(1)}';
  }
  final output = splitStr.join(' ');
  return output;
}

Widget setupAlertDialoadContainer(String item, String item2, String item3) {
  return Container(
    //height: 300.0, // Change as per your requirement
    //width: 300.0, // Change as per your requirement
    child: SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircleAvatar(
            child: Icon(
              FontAwesomeIcons.cartShopping,
              color: Color(0xFF482b9a),
              size: 10.0,
            ),
            backgroundColor: Colors.white,
            radius: 20.0,
          ),
          SizedBox(
            height: 10.0,
          ),
          Form(
            child: Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.only(top: 10.0, right: 20, left: 20),
                  child: TextFormField(
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      letterSpacing: 3.0,
                    ),
                    decoration: InputDecoration(
                      label: Center(
                        child: Text(item),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: EdgeInsets.symmetric(vertical: 10.0),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(width: 1),
                        borderRadius: const BorderRadius.all(
                          const Radius.circular(2.0),
                        ),
                      ),
                    ),
                    enabled: false,
                  ),
                ),
//=========================================
                Padding(
                  padding:
                      const EdgeInsets.only(top: 20.0, right: 20, left: 20),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(2.0),
                    ),
                    width: double.infinity,
//height: 100.0,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: Column(
                            children: [
                              Text(
                                "Ghc",
                                style: TextStyle(
                                    color: Color(0xFF482b9a),
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.w200),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 10.0, bottom: 20.0, left: 10.0, right: 10.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                item2,
                                style: TextStyle(
                                    color: Color(0xFF482b9a),
                                    fontSize: 50.0,
                                    fontWeight: FontWeight.w900),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
//=========================================
                Padding(
                  padding:
                      const EdgeInsets.only(top: 20.0, right: 20, left: 20),
                  child: Column(
                    children: [
                      Text(
                        totTitle(item3),
                        style: TextStyle(
                          color: Colors.white,
                          letterSpacing: 3.0,
                          fontSize: 25.0,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          //SizedBox(height: 20.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  Get.back();
                },
                style: ElevatedButton.styleFrom(primary: Colors.black),
                child: Text("Cancel"),
              ),
            ],
          )
        ],
      ),
    ),
  );
}
