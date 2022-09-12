import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:prico/input_page.dart';
import 'package:prico/models.dart';
import 'data_helper.dart';
import 'package:get/get.dart';

class UpdateAdmin extends StatefulWidget {
  Map<dynamic, dynamic> loginObject;
  UpdateAdmin(this.loginObject);
  @override
  _UpdateAdminState createState() => _UpdateAdminState();
}

class _UpdateAdminState extends State<UpdateAdmin> {
  @override
  void initState() {
    super.initState();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    int? postid = widget.loginObject["id"];
    String ctrlPin = widget.loginObject["loginPin"];
    String ctrlPhone = widget.loginObject["phoneNo"];
    String dobYear = widget.loginObject["dodYear"];
    String adminPass = widget.loginObject["adminPass"];

    final _ctrlPin = TextEditingController();
    final _ctrlNum = TextEditingController(text: ctrlPhone);
    final _ctrlDob = TextEditingController(text: dobYear);
    final _ctrlPass = TextEditingController();

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

    InpuData() {
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
                Text('Field Required'),
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
            Duration(seconds: 2),
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
      body: Column(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  child: Icon(
                    FontAwesomeIcons.cartShopping,
                    color: Colors.black,
                    size: 10.0,
                  ),
                  backgroundColor: Colors.white,
                  radius: 20.0,
                ),
                SizedBox(
                  height: 5.0,
                ),
                Text(
                  'PRICO',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w200,
                    letterSpacing: 3.0,
                    fontSize: 18.0,
                  ),
                ),
                SizedBox(
                  height: 5.0,
                ),
                Text('Update User Access',
                    style: TextStyle(
                      color: Color(0xFFb5a4e6),
                      letterSpacing: 2.0,
                    )),
                SizedBox(
                  height: 5.0,
                ),
                Column(
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 35.0),
                          child: Text('PIN',
                              style: TextStyle(
                                color: Color(0xFFb5a4e6),
                                letterSpacing: 2.0,
                              )),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 30.0, bottom: 15.0, right: 30.0),
                      child: TextFormField(
                        maxLength: 6,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          letterSpacing: 3.0,
                        ),
                        controller: _ctrlPin,
                        decoration: InputDecoration(
                          counterStyle: TextStyle(color: Color(0xFFb5a4e6)),
                          filled: true,
                          fillColor: Colors.white,
                          prefixIcon: Icon(
                            FontAwesomeIcons.key,
                            color: Color(0xFF482b9a),
                            size: 15,
                          ),
                          contentPadding: EdgeInsets.symmetric(vertical: 10.0),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(width: 1),
                            borderRadius: const BorderRadius.all(
                              const Radius.circular(10.0),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 35.0),
                          child: Text('Phone Number',
                              style: TextStyle(
                                color: Color(0xFFb5a4e6),
                                letterSpacing: 2.0,
                              )),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 30.0, bottom: 15.0, right: 30.0),
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          letterSpacing: 3.0,
                        ),
                        controller: _ctrlNum,
                        decoration: InputDecoration(
                          counterStyle: TextStyle(color: Color(0xFFb5a4e6)),
                          filled: true,
                          fillColor: Colors.white,
                          prefixText: "+233",
                          prefixIcon: Icon(
                            FontAwesomeIcons.phone,
                            color: Color(0xFF482b9a),
                            size: 15,
                          ),
                          contentPadding: EdgeInsets.symmetric(vertical: 10.0),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(width: 1),
                            borderRadius: const BorderRadius.all(
                              const Radius.circular(10.0),
                            ),
                          ),
                        ),
                        maxLength: 10,
                      ),
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 35.0),
                          child: Text('Year of Birth',
                              style: TextStyle(
                                color: Color(0xFFb5a4e6),
                                letterSpacing: 2.0,
                              )),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 30.0, bottom: 15.0, right: 30.0),
                      child: TextFormField(
                        maxLength: 4,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          letterSpacing: 3.0,
                        ),
                        controller: _ctrlDob,
                        decoration: InputDecoration(
                          counterStyle: TextStyle(color: Color(0xFFb5a4e6)),
                          filled: true,
                          fillColor: Colors.white,
                          prefixIcon: Icon(
                            FontAwesomeIcons.file,
                            color: Color(0xFF482b9a),
                            size: 15,
                          ),
                          contentPadding: EdgeInsets.symmetric(vertical: 10.0),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(width: 1),
                            borderRadius: const BorderRadius.all(
                              const Radius.circular(10.0),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 35.0),
                          child: Text('Admin Password',
                              style: TextStyle(
                                color: Color(0xFFb5a4e6),
                                letterSpacing: 2.0,
                              )),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 30.0, bottom: 15.0, right: 30.0),
                      child: TextFormField(
                        //keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          letterSpacing: 3.0,
                        ),
                        controller: _ctrlPass,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          prefixIcon: Icon(
                            FontAwesomeIcons.lock,
                            color: Color(0xFF482b9a),
                            size: 15,
                          ),
                          contentPadding: EdgeInsets.symmetric(vertical: 10.0),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(width: 1),
                            borderRadius: const BorderRadius.all(
                              const Radius.circular(10.0),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
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
                                            int deleted = await DatabaseHelper
                                                .instance
                                                .deleteAllPass(postid!);

                                            Navigator.pop(context);
                                            Navigator.pop(context);
                                            Navigator.pop(context);

                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) {
                                                return InputPage();
                                              }),
                                            );
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
                          },
                          style: ElevatedButton.styleFrom(
                              primary: Colors.red.shade300),
                          child: Text("Delete"),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 35.0),
                          child: ElevatedButton(
                            onPressed: () async {
                              String postPin = _ctrlPin.text.toString();
                              String postNum = _ctrlNum.text.toString();
                              String postDob = _ctrlDob.text.toString();
                              String postPass = _ctrlPass.text.toString();

                              if (postPin.isNotEmpty &&
                                  postNum.isNotEmpty &&
                                  postDob.isNotEmpty &&
                                  postPass.isNotEmpty) {
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
                                          "Are you want to Update?",
                                          style: TextStyle(
                                              color: Colors.green.shade400),
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

                                                if (postPass.endsWith(" ")) {
                                                  postPass = postPass.substring(
                                                      0, postPass.length - 1);
                                                  int i = await DatabaseHelper
                                                      .instance
                                                      .updateAllPass({
                                                    DatabaseHelper.columnIdS:
                                                        postid,
                                                    DatabaseHelper
                                                            .columnLoginPin:
                                                        postPin,
                                                    DatabaseHelper
                                                        .columnphoneNo: postNum,
                                                    DatabaseHelper
                                                        .columndobyear: postDob,
                                                    DatabaseHelper
                                                            .columnadminPass:
                                                        postPass,
                                                  });
                                                } else {
                                                  int i = await DatabaseHelper
                                                      .instance
                                                      .updateAllPass({
                                                    DatabaseHelper.columnIdS:
                                                        postid,
                                                    DatabaseHelper
                                                            .columnLoginPin:
                                                        postPin,
                                                    DatabaseHelper
                                                        .columnphoneNo: postNum,
                                                    DatabaseHelper
                                                        .columndobyear: postDob,
                                                    DatabaseHelper
                                                            .columnadminPass:
                                                        postPass,
                                                  });
                                                }

                                                //Navigator.pop(context);
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

                                //print("==========================>s");
                              } else {
                                InpuData();
                              }

                              //********************
                            },
                            style: ElevatedButton.styleFrom(
                                primary: Color(0xFFb5a4e6)),
                            child: Text("Update"),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
          //=================================================
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [],
          ),
          //=================================================
        ],
      ),
    );
  }
}
