import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'dart:async';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:prico/admin_edit.dart';
import 'package:prico/user_search_list.dart';
import 'barcode_edit.dart';
import 'database_helper.dart';
import 'get_started.dart';
import 'models.dart';

class AllProduct extends StatefulWidget {
  const AllProduct({Key? key}) : super(key: key);

  @override
  _AllProductState createState() => _AllProductState();
}

class _AllProductState extends State<AllProduct> {
  showInputed() {
    showDialog(
      context: context,
      builder: (context) {
        Future.delayed(
          Duration(seconds: 1),
          () {
            Navigator.of(context).pop(true);
          },
        );

        return AlertDialog(
          title: Icon(
            FontAwesomeIcons.faceSmile,
            color: Colors.green,
            size: 25.0,
          ),
          content: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Inserted Successfully'),
            ],
          ),
        );
      },
    );
  }

  //String userSearchInput = "";
  bool doItOnce = false;
  FetchUser _userList = FetchUser();

  List<PricoData> list = [];
  List<PricoData> filteredList = <PricoData>[];
  void filterList(value) {
    setState(() {
      filteredList = list
          .where((text) =>
              text.productName.toLowerCase().contains(value.toLowerCase()))
          .toList();
    });
  }

  int number = 0;
  void countPeople() async {
    int? count = await DatabaseHelper.instance.countPeople();
    setState(() {
      number = count!;
      //print(number);
    });
  }

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
    //print("*************************$_scanBarcode");
    //print(_scanBarcode.runtimeType);
    //print("===========================>$queryRows");

    var productObjects = {};
    for (int i = 0; i < queryRows.length; i++) {
      if (queryRows[i]["productCode"]
          .toString()
          .contains(_scanBarcode.toString())) {
        productObjects = queryRows[i];
        //print(productObject);
        break;
      }
    }
    //print(productObject["productCode"]);
/*

*/
    if (productObjects["productCode"].toString() == barcodeScanRes.toString()) {
      print("==========================>$productObjects");

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) {
          return BarcodeEdit(productObjects);
        }),
      );
    } else if (_scanBarcode == '-1') {
      print("******************Nothing Scanned*********************");
    } else if (_scanBarcode != productObjects) {
      //DATABASE SCANNED PRODUCT*********************************************
      setState(() {
        //DATABASE SCANNED PRODUCT*********************************************
        Get.defaultDialog(
            title: 'Prico',
            backgroundColor: Color(0xFF482b9a),
            titleStyle: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w200,
                letterSpacing: 3.0),
            content: setupAlertDialoadContainer(_scanBarcode.toString(), "0.00",
                "Not In Database", showInputed));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    countPeople();
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          elevation: 0,
          title: Container(
            child: Column(
              children: [
                Text(
                  'Search',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w200,
                      fontSize: 25.0,
                      letterSpacing: 3.0),
                ),
              ],
            ),
          ),
          //backgroundColor: Color(0xff482b9a),
        ),
        body: Column(
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Row(
                    children: [
                      Text(
                        "Total Products" + ": " + number.toString(),
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w200,
                            fontSize: 15.0,
                            letterSpacing: 3.0),
                      )
                    ],
                  ),
                ),
                Container(
                  height: 60,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: TextField(
                      onChanged: (value) => filterList(value),
                      decoration: InputDecoration(
                        prefixIcon: new Icon(
                          FontAwesomeIcons.magnifyingGlass,
                          color: Color(0xFF482b9a),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50.0),
                          borderSide: BorderSide.none,
                        ),
                        label: Text(
                          "Search products",
                          style: TextStyle(
                              color: Color(0xFFb5a4e6),
                              fontWeight: FontWeight.w200),
                        ),
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Row(
                          children: [
                            new GestureDetector(
                              onTap: () {
                                scanQR();
                              },
                              child: new Icon(
                                FontAwesomeIcons.camera,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            new GestureDetector(
                              onTap: () {
                                scanQR();
                              },
                              child: new Text(
                                "Scan to update",
                                style: TextStyle(
                                  fontWeight: FontWeight.w300,
                                  letterSpacing: 1,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                )
              ],
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                decoration: BoxDecoration(
                    //color: Colors.grey.shade900,
                    //borderRadius: BorderRadius.circular(10.0),
                    ),
                child: RefreshIndicator(
                  onRefresh: () {
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (a, b, c) => AllProduct(),
                        transitionDuration: Duration(seconds: 0),
                      ),
                    );
                    return Future.value(false);
                  },
                  child: FutureBuilder(
                      future: _userList.pricoData(),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        var data = snapshot.data;
                        if (snapshot.hasData) {
                          if (!doItOnce) {
                            list = snapshot.data!;
                            filteredList = list;
                            doItOnce = !doItOnce;
                          }
                          return ListView.builder(
                              reverse: false,
                              shrinkWrap: true,
                              physics: const AlwaysScrollableScrollPhysics(),
                              itemCount: filteredList.length,
                              itemBuilder: (BuildContext context, int index) {
                                PricoData item = filteredList[index];
                                return Card(
                                  child: ListTile(
                                    leading: CircleAvatar(
                                      backgroundColor: Color(0xFF482b9a),
                                      radius: 8,
                                    ),
                                    title: Text(
                                      '${item.productName}',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w300,
                                          letterSpacing: 2.0),
                                    ),
                                    subtitle: Text(
                                        "Ghc" + " " + '${item.productAmount}'),
                                    trailing: Icon(
                                      FontAwesomeIcons.pencil,
                                      color: Color(0xFF482b9a),
                                      size: 12.0,
                                    ),
                                    onTap: () {
                                      //print(item);
                                      //print(_userList);
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  AdminEdit(item)));
                                    },
                                  ),
                                );
                              });
                        }

                        return Center(child: CircularProgressIndicator());
                      }),
                ),
              ),
            ),
          ],
        ));
  }
}

Widget setupAlertDialoadContainer(
    String item, String item2, String item3, Function() showInputed) {
  String postcode;
  String postProduct;
  String postAmount;

  final _ctrlCode = TextEditingController(text: item);
  final _ctrlName = TextEditingController();
  final _ctrlAmount = TextEditingController();
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
                                    color: Colors.red,
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
                                    color: Colors.red,
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
                      const EdgeInsets.only(top: 10.0, right: 20, left: 20),
                  child: Column(
                    children: [
                      //SizedBox(height: 10),
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
              SizedBox(width: 20.0),
              ElevatedButton(
                onPressed: () {
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
                                padding: const EdgeInsets.only(
                                    top: 10.0, right: 20, left: 20),
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
                                    contentPadding:
                                        EdgeInsets.symmetric(vertical: 10.0),
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
                                padding: const EdgeInsets.only(
                                    top: 20.0, right: 20, left: 20),
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
                                padding: const EdgeInsets.only(
                                    top: 10.0, right: 20, left: 20),
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
                        SizedBox(height: 10.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                Get.back();
                                _ctrlName.clear();
                                _ctrlAmount.clear();
                              },
                              style: ElevatedButton.styleFrom(
                                  primary: Colors.black),
                              child: Text("Cancel"),
                            ),
                            SizedBox(
                              width: 20.0,
                            ),
                            ElevatedButton(
                              onPressed: () async {
                                int i = await DatabaseHelper.instance.insert({
                                  DatabaseHelper.columnCode: _ctrlCode.text,
                                  DatabaseHelper.columnName: _ctrlName.text,
                                  DatabaseHelper.columnAmount: _ctrlAmount.text,
                                });
                                Get.back();
                                Get.back();
                                showInputed();

                                //scanQR(); //5=@#$%*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                              },
                              style: ElevatedButton.styleFrom(
                                  primary: Color(0xFF482b9a)),
                              child: Text("Save"),
                            )
                          ],
                        )
                      ],
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(primary: Color(0xFFb5a4e6)),
                child: Text("Add to Database"),
              ),
            ],
          )
        ],
      ),
    ),
  );
}
