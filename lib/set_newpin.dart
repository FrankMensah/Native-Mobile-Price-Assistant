import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:prico/get_started.dart';
import 'package:prico/models.dart';
import 'package:prico/search_login_access.dart';
import 'package:prico/user_search_list.dart';
import 'package:prico/verify_login.dart';
import 'all_login.dart';
import 'data_helper.dart';

class SetNewpin extends StatefulWidget {
  Map<dynamic, dynamic> verifyObjects;
  SetNewpin(this.verifyObjects);
  @override
  _SetNewpinState createState() => _SetNewpinState();
}

var loginObjects = {};

class _SetNewpinState extends State<SetNewpin> {
  //FetchLogin userAccess = FetchLogin();
  FocusNode focusNo = FocusNode();
  FocusNode focusNod = FocusNode();
  String hintPIN = 'PIN';
  String hintVerifyPIN = 'Verify PIN';

  List<UserAccess> userList = <UserAccess>[];

  @override
  void initState() {
    super.initState();
    focusNo.addListener(() {
      if (focusNo.hasFocus) {
        hintPIN = '';
      } else {
        hintPIN = 'PIN';
      }

      setState(() {});
    });

    focusNod.addListener(() {
      if (focusNod.hasFocus) {
        hintVerifyPIN = '';
      } else {
        hintVerifyPIN = 'Phone Number';
      }

      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    FetchUser _accessUser = FetchUser();
    final _ctrlPin = TextEditingController();
    final _ctrlVerifyPin = TextEditingController();

    int? postid = widget.verifyObjects["id"];
    String ctrlPin = widget.verifyObjects["loginPin"];

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

    InputNotMatch() {
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
              FontAwesomeIcons.faceFrown,
              color: Colors.red,
              size: 25.0,
            ),
            content: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('PIN doesn\'t Match'),
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
                Text('PIN Reseted Successfully'),
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
            child: Card(
              shadowColor: Colors.white,
              margin: EdgeInsets.symmetric(vertical: 150.0, horizontal: 30.0),
              color: Color(0xFF482b9a),
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
                  Text('Set New PIN',
                      style: TextStyle(
                        color: Color(0xFFb5a4e6),
                        letterSpacing: 2.0,
                      )),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 40.0),
                        child: Text('PIN',
                            style: TextStyle(
                              color: Color(0xFFb5a4e6),
                              letterSpacing: 2.0,
                            )),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 10.0),
                    child: TextFormField(
                      //focusNode: focusNo,
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        letterSpacing: 3.0,
                      ),
                      controller: _ctrlPin,
                      maxLength: 6,
                      obscureText: true,
                      decoration: InputDecoration(
                        counterStyle: TextStyle(color: Color(0xFFb5a4e6)),
                        filled: true,
                        fillColor: Colors.white,
                        hintText: hintPIN,
                        prefixText: "   ",
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
                        padding: const EdgeInsets.only(left: 40.0),
                        child: Text('Verify PIN',
                            style: TextStyle(
                              color: Color(0xFFb5a4e6),
                              letterSpacing: 2.0,
                            )),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 10.0),
                    child: TextFormField(
                      //focusNode: focusNod,
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      maxLength: 6,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        letterSpacing: 3.0,
                      ),
                      controller: _ctrlVerifyPin,
                      obscureText: true,
                      decoration: InputDecoration(
                        counterStyle: TextStyle(color: Color(0xFFb5a4e6)),
                        filled: true,
                        fillColor: Colors.white,
                        hintText: hintVerifyPIN,
                        prefixText: "   ",
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
                        padding: const EdgeInsets.only(right: 10.0),
                        child: ElevatedButton(
                          onPressed: () async {
                            if (_ctrlPin.text.isEmpty &&
                                _ctrlVerifyPin.text.isEmpty) {
                              InpuData();
                            } else if (_ctrlPin.text.toString() ==
                                _ctrlVerifyPin.text.toString()) {
                              int i =
                                  await DatabaseHelper.instance.updateAllPass({
                                DatabaseHelper.columnIdS: postid,
                                DatabaseHelper.columnLoginPin:
                                    _ctrlPin.text.toString()
                              });

                              //print(postid);
                              //print(_ctrlPin.text);

                              Navigator.pop(context);
                              Navigator.pop(context);
                              Navigator.pop(context);
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) {
                                  return AllLogin();
                                }),
                              );

                              showUpdated();
                            } else if (_ctrlPin.text.toString() !=
                                _ctrlVerifyPin.text.toString()) {
                              InputNotMatch();
                            }
                          },
                          style: ElevatedButton.styleFrom(
                              primary: Color(0xFFb5a4e6)),
                          child: Text("Reset PIN"),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          //=================================================

          //=================================================
        ],
      ),
    );
  }
}
