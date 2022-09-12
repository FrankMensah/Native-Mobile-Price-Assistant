import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:prico/set_newpin.dart';
import 'all_login.dart';
import 'data_helper.dart';

class VerifyLogin extends StatefulWidget {
  @override
  _VerifyLoginState createState() => _VerifyLoginState();
}

var verifyObjects = {};

class _VerifyLoginState extends State<VerifyLogin> {
  //final _ctrlPin = TextEditingController();
  final _ctrlNum = TextEditingController();
  final _ctrlDob = TextEditingController();
  final _ctrlPass = TextEditingController();

  //FocusNode focusNo = FocusNode();
  FocusNode focusNod = FocusNode();
  FocusNode focusNode = FocusNode();
  FocusNode focusNodes = FocusNode();
  //String hintPin = 'PIN';
  String hintNum = 'Phone Number';
  String hintDOB = 'YYYY';
  String hintAdmin = 'Password';

  @override
  void initState() {
    super.initState();

    focusNod.addListener(() {
      if (focusNod.hasFocus) {
        hintNum = '';
      } else {
        hintNum = 'Phone Number';
      }

      setState(() {});
    });

    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        hintDOB = '';
      } else {
        hintDOB = 'YYYY';
      }

      setState(() {});
    });

    focusNodes.addListener(() {
      if (focusNodes.hasFocus) {
        hintAdmin = '';
      } else {
        hintAdmin = 'Password';
      }

      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    showInvalid() {
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
              color: Colors.red,
              size: 25.0,
            ),
            content: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Invalid Input'),
              ],
            ),
          );
        },
      );
    }

    showVerified() {
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
                Text('Your input has been verified'),
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
                    size: 15.0,
                  ),
                  backgroundColor: Colors.white,
                  radius: 25.0,
                ),
                SizedBox(
                  height: 10.0,
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
                Text('Verify Your Information',
                    style: TextStyle(
                      color: Colors.white,
                      letterSpacing: 2.0,
                    )),
                SizedBox(
                  height: 10.0,
                ),
                Column(
                  children: [
                    /*Row(
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
                          top: 5.0, left: 30.0, bottom: 15.0, right: 30.0),
                      child: TextFormField(
                        focusNode: focusNo,
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
                          hintText: hintPin,
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
                    ),*/
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
                          top: 5.0, left: 30.0, bottom: 15.0, right: 30.0),
                      child: TextFormField(
                        focusNode: focusNod,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          letterSpacing: 3.0,
                        ),
                        controller: _ctrlNum,
                        maxLength: 10,
                        decoration: InputDecoration(
                          counterStyle: TextStyle(color: Color(0xFFb5a4e6)),
                          filled: true,
                          fillColor: Colors.white,
                          hintText: hintNum,
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
                          top: 5.0, left: 30.0, bottom: 15.0, right: 30.0),
                      child: TextFormField(
                        focusNode: focusNode,
                        keyboardType: TextInputType.number,
                        maxLength: 4,
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
                          hintText: hintDOB,
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
                          top: 5.0, left: 30.0, bottom: 15.0, right: 30.0),
                      child: TextFormField(
                        focusNode: focusNodes,
                        //keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          letterSpacing: 3.0,
                        ),
                        controller: _ctrlPass,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: hintAdmin,
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
                        Padding(
                          padding: const EdgeInsets.only(right: 35.0),
                          child: ElevatedButton(
                            onPressed: () async {
                              //String postPin = _ctrlPin.text.toString();
                              String postNum = _ctrlNum.text.toString();
                              String postDob = _ctrlDob.text.toString();
                              String postPass = _ctrlPass.text.toString();

                              List<Map<String, dynamic>> queryUserInfo =
                                  await DatabaseHelper.instance.queryAllPass();

                              for (int i = 0; i < queryUserInfo.length; i++) {
                                //

                                if (queryUserInfo[i]["phoneNo"]
                                        .toString()
                                        .contains(postNum) &&
                                    queryUserInfo[i]["dodYear"]
                                        .toString()
                                        .contains(postDob) &&
                                    queryUserInfo[i]["adminPass"]
                                        .toString()
                                        .contains(postPass)) {
                                  verifyObjects = queryUserInfo[i];

                                  break;
                                }
                              }

                              if (verifyObjects["phoneNo"] == postNum &&
                                  verifyObjects["dodYear"] == postDob &&
                                  verifyObjects["adminPass"] == postPass) {
                                //print("Almost here");
                                //_ctrlAllPass.clear();
                                //print(loginObjects);
                                //Navigator.pop(context);
                                _ctrlNum.clear();
                                _ctrlDob.clear();
                                _ctrlPass.clear();

                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        SetNewpin(verifyObjects),
                                  ),
                                );
                                showVerified();
                              } else if (postNum.isEmpty &&
                                  postDob.isEmpty &&
                                  postPass.isEmpty) {
                                InpuData();
                              } else if (verifyObjects["phoneNo"] != postNum &&
                                  verifyObjects["dodYear"] != postDob &&
                                  verifyObjects["adminPass"] != postPass) {
                                showInvalid();
                              }
                            },
                            style: ElevatedButton.styleFrom(
                                primary: Color(0xFFb5a4e6)),
                            child: Text("Verify"),
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
