import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:prico/get_started.dart';
import 'package:prico/models.dart';
import 'package:prico/search_login_access.dart';
import 'package:prico/user_search_list.dart';
import 'package:prico/verify_login.dart';
import 'data_helper.dart';

class AllLogin extends StatefulWidget {
  @override
  _AllLoginState createState() => _AllLoginState();
}

var loginObjects = {};

class _AllLoginState extends State<AllLogin> {
  //FetchLogin userAccess = FetchLogin();
  FocusNode focusNode = FocusNode();
  String hintText = 'PIN';

  List<UserAccess> userList = <UserAccess>[];

  @override
  void initState() {
    super.initState();

    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        hintText = '';
      } else {
        hintText = 'PIN';
      }
    });
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    FetchUser _accessUser = FetchUser();
    final _ctrlAllPass = TextEditingController();

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
                Text('Please enter your PIN'),
              ],
            ),
          );
        },
      );
    }

    showLoginInvalid() {
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
              FontAwesomeIcons.xmark,
              color: Colors.red,
              size: 25.0,
            ),
            content: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Invalid Input, Try Again'),
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
                Text('LOGIN',
                    style: TextStyle(
                      color: Color(0xFFb5a4e6),
                      letterSpacing: 2.0,
                    )),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: TextFormField(
                    focusNode: focusNode,
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      letterSpacing: 3.0,
                    ),
                    controller: _ctrlAllPass,
                    obscureText: true,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      hintText: hintText,
                      prefixText: "   ",
                      suffixIcon: IconButton(
                        onPressed: () async {
                          List<Map<String, dynamic>> queryUserInfo =
                              await DatabaseHelper.instance.queryAllPass();

                          for (int i = 0; i < queryUserInfo.length; i++) {
                            //

                            if (queryUserInfo[i]["loginPin"]
                                .toString()
                                .contains(_ctrlAllPass.text.toString())) {
                              loginObjects = queryUserInfo[i];
                              break;
                            }
                          }

                          if (loginObjects["loginPin"] ==
                              _ctrlAllPass.text.toString()) {
                            var _loginObj = loginObjects.entries.map((entry) {
                              return entry.value;
                            }).toList();
                            _ctrlAllPass.clear();
                            //print(loginObjects);
                            //Navigator.pop(context);

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => GetStarted(loginObjects),
                              ),
                            );
                          } else if (_ctrlAllPass.text.toString().isEmpty) {
                            InpuData();
                          } else if (loginObjects["loginPin"] !=
                              _ctrlAllPass.text.toString()) {
                            showLoginInvalid();
                          }
                        },
                        icon: Icon(
                          FontAwesomeIcons.arrowRight,
                          //size: 2.0,
                        ),
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
                new GestureDetector(
                  onTap: () {
                    _ctrlAllPass.clear();
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) {
                        return VerifyLogin();
                      }),
                    );
                  },
                  child: new Text(
                    "forgot PIN?",
                    style: TextStyle(
                      fontWeight: FontWeight.w300,
                      letterSpacing: 1,
                      color: Colors.white,
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
