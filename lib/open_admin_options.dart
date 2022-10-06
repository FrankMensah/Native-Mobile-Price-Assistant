import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:prico/admin_setting.dart';
import 'package:prico/all_product.dart';
import 'package:prico/models.dart';
import 'package:prico/update_admin.dart';
import 'database_helper.dart';

class OpenAdmin extends StatefulWidget {
  Map<dynamic, dynamic> loginObject;
  OpenAdmin(this.loginObject);

  @override
  _OpenAdminState createState() => _OpenAdminState();
}

class _OpenAdminState extends State<OpenAdmin> {
  final _formKey = GlobalKey<FormState>();

  final _ctrlCode = TextEditingController();
  final _ctrlName = TextEditingController();
  final _ctrlAmount = TextEditingController();

  String _scanBarcode = 'Unknown';

  //get note => null;

  //late DB db;

  @override
  void initState() {
    super.initState();
    setState(() {});
  }

  Future<void> scanQR() async {
    String barcodeScanRes;

    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.BARCODE);
      //print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    if (!mounted) return;

    _scanBarcode = barcodeScanRes;

    String printPrice = _scanBarcode;

    String postcode;
    String postProduct;
    String postAmount;

    if (printPrice == '-1') {
      //print("******************Nothing Scanned*********************");
      //Get.back();
    } else if (printPrice == _scanBarcode) {
      //================PRICE PULLOUT-----DATABASE
      //printPrice = "Ghc50.00";
      setState(() {
        _scanBarcode = printPrice;
        _ctrlCode.text = barcodeScanRes;
        //DATABASE SCANNED PRODUCT*********************************************
        Get.defaultDialog(
          title: 'Prico',
          backgroundColor: Colors.white,
          titleStyle: const TextStyle(
              color: Color(0xFFb5a4e6),
              fontWeight: FontWeight.w200,
              letterSpacing: 3.0),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircleAvatar(
                child: Icon(
                  FontAwesomeIcons.cartShopping,
                  color: Colors.black,
                  size: 10.0,
                ),
                backgroundColor: Color(0xFFb5a4e6),
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
                        //onSaved: (val) => setState(() => _product.code = val),
                        //validator: (val) => (val?.length == 0
                        //  ? 'This Field is Required'
                        // : null),
                        controller: _ctrlCode,
                        decoration: InputDecoration(
                          label: Text("Product Code"),
                          contentPadding: EdgeInsets.symmetric(vertical: 10.0),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(width: 1),
                            borderRadius: const BorderRadius.all(
                              const Radius.circular(10.0),
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
                      child: TextFormField(
                        controller: _ctrlName,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          letterSpacing: 1.0,
                        ),
                        //onSaved: (val) => setState(() => _product.name = val),
                        //validator: (val) => (val?.length == 0
                        //  ? 'This Field is Required'
                        // : null),
                        decoration: InputDecoration(
                          label: Text("Product Name"),
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 5.0, horizontal: 10.0),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(width: 1),
                            borderRadius: const BorderRadius.all(
                              const Radius.circular(5.0),
                            ),
                          ),
                        ),
                      ),
                    ),
                    //=========================================
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 20.0, right: 20, left: 20),
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          letterSpacing: 1.0,
                        ),
                        //onSaved: (val) => setState(() => _product.amount = val),
                        //validator: (val) => (val?.length == 0
                        //  ? 'This Field is Required'
                        // : null),
                        controller: _ctrlAmount,
                        decoration: InputDecoration(
                          prefixText: "Ghc",
                          label: Text("Amount"),
                          hintText: "0.00",
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 5.0, horizontal: 10.0),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(width: 1),
                            borderRadius: const BorderRadius.all(
                              const Radius.circular(5.0),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Get.back();
                      _ctrlName.clear();
                      _ctrlAmount.clear();
                    },
                    style: ElevatedButton.styleFrom(primary: Colors.black),
                    child: Text("Cancel"),
                  ),
                  SizedBox(
                    width: 20.0,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      postcode = _ctrlCode.text;
                      postProduct = _ctrlName.text;
                      postAmount = _ctrlAmount.text;

                      if (postProduct.endsWith(" ")) {
                        postProduct =
                            postProduct.substring(0, postProduct.length - 1);
                        int i = await DatabaseHelper.instance.insert({
                          DatabaseHelper.columnCode: postcode,
                          DatabaseHelper.columnName: postProduct,
                          DatabaseHelper.columnAmount: postAmount,
                        });
                      } else {
                        int i = await DatabaseHelper.instance.insert({
                          DatabaseHelper.columnCode: postcode,
                          DatabaseHelper.columnName: postProduct,
                          DatabaseHelper.columnAmount: postAmount,
                        });
                      }

                      Get.back();
                      Get.defaultDialog(
                          title: 'Prico',
                          backgroundColor: Colors.white,
                          titleStyle: const TextStyle(
                              color: Color(0xFFb5a4e6),
                              fontWeight: FontWeight.w200,
                              letterSpacing: 3.0),
                          content: Column(
                            children: [
                              CircleAvatar(
                                child: Icon(
                                  FontAwesomeIcons.cartShopping,
                                  color: Colors.black,
                                  size: 10.0,
                                ),
                                backgroundColor: Color(0xFFb5a4e6),
                                radius: 20.0,
                              ),
                              SizedBox(height: 20.0),
                              Text(
                                "Saved Successfully",
                                style: TextStyle(color: Colors.green.shade400),
                              ),
                              SizedBox(height: 10.0),
                              Text("Do you want to Add Again?"),
                              SizedBox(height: 30.0),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ElevatedButton(
                                    onPressed: () {
                                      Get.back();
                                      _ctrlName.clear();
                                      _ctrlAmount.clear();
                                      scanQR();
                                    },
                                    style: ElevatedButton.styleFrom(
                                      primary: Color(0xFFb5a4e6),
                                    ),
                                    child: Text("Yes"),
                                  ),
                                  SizedBox(
                                    width: 20.0,
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      Get.back();
                                      _ctrlName.clear();
                                      _ctrlAmount.clear();
                                    },
                                    style: ElevatedButton.styleFrom(
                                        primary: Colors.black),
                                    child: Text("No"),
                                  )
                                ],
                              ),
                            ],
                          ));
                      //scanQR(); //5=@#$%*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                    },
                    style: ElevatedButton.styleFrom(primary: Color(0xFF482b9a)),
                    child: Text("Save"),
                  )
                ],
              )
            ],
          ),
        );

        //DATABASE SCANNED PRODUCT*********************************************
        //  style: TextStyle(fontSize: 15))
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
                        color: Color(0xFF482b9a),
                        size: 20.0,
                      ),
                      backgroundColor: Colors.white,
                      radius: 30.0,
                    ),
                  ],
                ),
                SizedBox(
                  height: 20.0,
                ),
                Text(
                  'ADMIN OPTIONS',
                  style: TextStyle(
                    color: Color(0xFFb5a4e6),
                    fontSize: 15.0,
                  ),
                ),
                Expanded(
                  child: Container(
                    margin:
                        EdgeInsets.symmetric(vertical: 30.0, horizontal: 110.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: ListView(
                      //mainAxisAlignment: MainAxisAlignment.center,
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
                                FontAwesomeIcons.folderPlus,
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
                                "Add to Database",
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
                              height: 5.0,
                            ),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) {
                                    return AllProduct();
                                  }),
                                );
                              }, //=> OptionDownList,
                              child: new Icon(
                                FontAwesomeIcons.list,
                                color: Colors.white,
                                size: 30.0,
                              ),
                              style: ElevatedButton.styleFrom(
                                  shape: CircleBorder(),
                                  padding: EdgeInsets.all(15),
                                  primary: Color(0xFF482b9a)),
                            ), //DATABASE SCANNED PRODUCT
                            SizedBox(
                              height: 10.0,
                            ),
                            new GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) {
                                    return AllProduct();
                                  }),
                                );
                              },
                              child: new Text(
                                "All Products",
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
                              height: 5.0,
                            ),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) {
                                    return UpdateAdmin(widget.loginObject);
                                  }),
                                );
                              },
                              child: new Icon(
                                FontAwesomeIcons.gear,
                                color: Colors.white,
                                size: 30.0,
                              ),
                              style: ElevatedButton.styleFrom(
                                  shape: CircleBorder(),
                                  padding: EdgeInsets.all(15),
                                  primary: Color(0xFF482b9a)),
                            ), //DATABASE SCANNED PRODUCT
                            SizedBox(
                              height: 10.0,
                            ),
                            new GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) {
                                    return UpdateAdmin(widget.loginObject);
                                  }),
                                );
                              },
                              child: new Text(
                                "Setting",
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
                              height: 5.0,
                            ),
                            ElevatedButton(
                              onPressed: () {}, //=> OptionDownList,
                              child: new Icon(
                                FontAwesomeIcons.cartFlatbed,
                                color: Colors.white,
                                size: 30.0,
                              ),
                              style: ElevatedButton.styleFrom(
                                  shape: CircleBorder(),
                                  padding: EdgeInsets.all(15),
                                  primary: Color(0xFF482b9a)),
                            ), //DATABASE SCANNED PRODUCT
                            SizedBox(
                              height: 10.0,
                            ),

                            new GestureDetector(
                              onTap: () {},
                              child: new Text(
                                "Inventory",
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
        ],
      ),
    );
  }
}

extension E on String {
  String lastChars(int n) => substring(length - n);
}
