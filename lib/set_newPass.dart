import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:prico/admin_login.dart';
import 'package:prico/get_started.dart';
import 'package:prico/models.dart';
import 'package:prico/search_login_access.dart';
import 'package:prico/user_search_list.dart';
import 'package:prico/verify_login.dart';
import 'all_login.dart';
import 'data_helper.dart';

class SetNewPass extends StatefulWidget {
  Map<dynamic, dynamic> loginObjects;
  SetNewPass(this.loginObjects);
  @override
  _SetNewPassState createState() => _SetNewPassState();
}

var loginObjects = {};

class _SetNewPassState extends State<SetNewPass> {
  //FetchLogin userAccess = FetchLogin();
  FocusNode focusNo = FocusNode();
  FocusNode focusNod = FocusNode();
  String hintPIN = 'Password';
  String hintVerifyPIN = 'Verify Password';

  List<UserAccess> userList = <UserAccess>[];

  @override
  void initState() {
    super.initState();
    focusNo.addListener(() {
      if (focusNo.hasFocus) {
        hintPIN = '';
      } else {
        hintPIN = 'Password';
      }

      setState(() {});
    });

    focusNod.addListener(() {
      if (focusNod.hasFocus) {
        hintVerifyPIN = '';
      } else {
        hintVerifyPIN = 'Verify Password';
      }

      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    FetchUser _accessUser = FetchUser();
    final _ctrlPass = TextEditingController();
    final _ctrlVerifyPass = TextEditingController();

    int? postid = widget.loginObjects["id"];
    String ctrlPin = widget.loginObjects["adminPass"];

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
                Text('Password doesn\'t Match'),
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
                Text('Password Reseted Successfully'),
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
                  Text('Set New Password',
                      style: TextStyle(
                        color: Color(0xFFb5a4e6),
                        letterSpacing: 2.0,
                      )),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Text('Password',
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
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        letterSpacing: 3.0,
                      ),
                      controller: _ctrlPass,
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
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Text('Verify Password',
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
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        letterSpacing: 3.0,
                      ),
                      controller: _ctrlVerifyPass,
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
                            if (_ctrlPass.text.isEmpty &&
                                _ctrlVerifyPass.text.isEmpty) {
                              InpuData();
                            } else if (_ctrlPass.text.toString() ==
                                _ctrlVerifyPass.text.toString()) {
                              int i =
                                  await DatabaseHelper.instance.updateAllPass({
                                DatabaseHelper.columnIdS: postid,
                                DatabaseHelper.columnadminPass:
                                    _ctrlPass.text.toString()
                              });

                              //print(postid);
                              //print(_ctrlPass.text);

                              Navigator.pop(context);
                              Navigator.pop(context);
                              Navigator.pop(context);
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) {
                                  return AdminLogin(widget.loginObjects);
                                }),
                              );

                              showUpdated();
                            } else if (_ctrlPass.text.toString() !=
                                _ctrlVerifyPass.text.toString()) {
                              InputNotMatch();
                            }
                          },
                          style: ElevatedButton.styleFrom(
                              primary: Color(0xFFb5a4e6)),
                          child: Text("Reset Password"),
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
