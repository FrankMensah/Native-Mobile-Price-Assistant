import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:prico/models.dart';
import 'database_helper.dart';
import 'open_admin_options.dart';

class AdminEdit extends StatefulWidget {
  final PricoData item;
  AdminEdit(this.item);

  @override
  State<AdminEdit> createState() => _AdminEditState();
}

class _AdminEditState extends State<AdminEdit> {
  @override
  Widget build(BuildContext context) {
    int? postid = widget.item.id;
    String postcode = widget.item.productCode;
    String postProduct = widget.item.productName;
    String postAmount = widget.item.productAmount;

    final _ctrlCode = TextEditingController(text: postcode);
    final _ctrlName = TextEditingController(text: postProduct);
    final _ctrlAmount = TextEditingController(text: postAmount);

    showDeleted() {
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
              FontAwesomeIcons.faceFrown,
              color: Colors.red,
              size: 25.0,
            ),
            content: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Deleted Successfully'),
              ],
            ),
          );
        },
      );
    }

    showUpdated() {
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
                Text('Updated Successfully'),
              ],
            ),
          );
        },
      );
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xFF482b9a),
      body: Row(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Card(
                    shadowColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    color: Color(0xFF482b9a),
                    //elevation: 10,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        SizedBox(
                          height: 20.0,
                        ),
                        CircleAvatar(
                          child: Icon(
                            FontAwesomeIcons.cartShopping,
                            color: Color(0xFF482b9a),
                            size: 20.0,
                          ),
                          backgroundColor: Colors.white,
                          radius: 30.0,
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Text(
                          'PRICO',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w200,
                            letterSpacing: 3.0,
                          ),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Text(
                          'Update Product Info',
                          style: TextStyle(
                            color: Color(0xFFb5a4e6),
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                            letterSpacing: 3.0,
                          ),
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
                                  controller: _ctrlCode,
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Color(0xFFb5a4e6),
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
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.white,
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
                                    top: 20.0, right: 20, left: 20),
                                child: TextFormField(
                                  keyboardType: TextInputType.number,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    letterSpacing: 1.0,
                                  ),
                                  controller: _ctrlAmount,
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.white,
                                    prefixText: "Ghc",
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
                                        Container(
                                            child: Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Icon(
                                                FontAwesomeIcons
                                                    .personWalkingLuggage,
                                                color: Colors.red,
                                                size: 50.0,
                                              ),
                                              Icon(
                                                FontAwesomeIcons.arrowRight,
                                                color: Colors.red,
                                                size: 25.0,
                                              ),
                                              Icon(
                                                FontAwesomeIcons.trashCan,
                                                color: Colors.red,
                                                size: 20.0,
                                              ),
                                            ],
                                          ),
                                        )),
                                        SizedBox(
                                          height: 10.0,
                                        ),
                                        Text(
                                          "Do you want Delete?",
                                          style: TextStyle(color: Colors.black),
                                        ),
                                        SizedBox(height: 10.0),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            ElevatedButton(
                                              onPressed: () {
                                                Get.back();

                                                // scanQR();
                                              },
                                              style: ElevatedButton.styleFrom(
                                                  primary: Colors.black),
                                              child: Text("Cancel"),
                                            ),
                                            SizedBox(
                                              width: 20,
                                            ),
                                            ElevatedButton(
                                              onPressed: () async {
                                                Get.back();
                                                int deleted =
                                                    await DatabaseHelper
                                                        .instance
                                                        .delete(postid!);
                                                Navigator.pop(context);
                                                showDeleted();
                                              },
                                              style: ElevatedButton.styleFrom(
                                                  primary: Colors.red.shade300),
                                              child: Text("Delete"),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ));
                                // Get.back();
                              },
                              style: ElevatedButton.styleFrom(
                                  primary: Colors.red.shade300),
                              child: Text("Delete"),
                            ),
                            SizedBox(
                              width: 20.0,
                            ),
                            ElevatedButton(
                              onPressed: () {
                                Get.back();
                              },
                              style: ElevatedButton.styleFrom(
                                  primary: Colors.black),
                              child: Text("Cancel"),
                            ),
                            SizedBox(
                              width: 20.0,
                            ),
                            ElevatedButton(
                              onPressed: () {
                                //Get.back();
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
                                            color: Colors.white,
                                            size: 10.0,
                                          ),
                                          backgroundColor: Color(0xFF482b9a),
                                          radius: 20.0,
                                        ),
                                        SizedBox(height: 20.0),
                                        Text(
                                          "Are you want to Update?",
                                          style: TextStyle(
                                              color: Color(0xFF482b9a)),
                                        ),
                                        SizedBox(height: 15.0),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            ElevatedButton(
                                              onPressed: () {
                                                Get.back();

                                                // scanQR();
                                              },
                                              style: ElevatedButton.styleFrom(
                                                  primary: Colors.black),
                                              child: Text("Cancel"),
                                            ),
                                            SizedBox(width: 20.0),
                                            ElevatedButton(
                                              onPressed: () async {
                                                Get.back();

                                                String updateCode =
                                                    _ctrlCode.text;
                                                String updateName =
                                                    _ctrlName.text;
                                                String updateAmount =
                                                    _ctrlAmount.text;

                                                if (updateName.endsWith(" ")) {
                                                  updateName =
                                                      updateName.substring(
                                                          0,
                                                          updateName.length -
                                                              1);
                                                  int i = await DatabaseHelper
                                                      .instance
                                                      .update({
                                                    DatabaseHelper.columnId:
                                                        postid,
                                                    DatabaseHelper.columnCode:
                                                        updateCode,
                                                    DatabaseHelper.columnName:
                                                        updateName,
                                                    DatabaseHelper.columnAmount:
                                                        updateAmount,
                                                  });
                                                } else {
                                                  int i = await DatabaseHelper
                                                      .instance
                                                      .update({
                                                    DatabaseHelper.columnId:
                                                        postid,
                                                    DatabaseHelper.columnCode:
                                                        updateCode,
                                                    DatabaseHelper.columnName:
                                                        updateName,
                                                    DatabaseHelper.columnAmount:
                                                        updateAmount,
                                                  });
                                                }

                                                Navigator.pop(context);

                                                showUpdated();
                                              },
                                              style: ElevatedButton.styleFrom(
                                                  primary: Colors.green),
                                              child: Text("Update"),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ));
                                //scanQR(); //5=@#$%*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                              },
                              style: ElevatedButton.styleFrom(
                                  primary: Colors.white),
                              child: Text(
                                "Update",
                                style: TextStyle(color: Color(0xFF482b9a)),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          //=================================================

          //=================================================
        ],
      ),
    );
  }
}
