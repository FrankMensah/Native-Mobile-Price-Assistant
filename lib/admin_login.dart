import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:prico/admin_verify.dart';
import 'package:prico/all_login.dart';
import 'package:prico/get_started.dart';
import 'package:prico/open_admin_options.dart';
import 'data_helper.dart';

//hcbxbb
class AdminLogin extends StatefulWidget {
  Map<dynamic, dynamic> loginObjects;
  AdminLogin(this.loginObjects);
  @override
  _AdminLoginState createState() => _AdminLoginState();
}

class _AdminLoginState extends State<AdminLogin> {
  FocusNode focusNode = FocusNode();
  String hintText = 'Password';

  @override
  void initState() {
    super.initState();
    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        hintText = '';
      } else {
        hintText = 'Password';
      }
    });
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final _ctrlAllPass = TextEditingController();

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
                Text('ADMIN LOGIN',
                    style: TextStyle(
                      color: Color(0xFFb5a4e6),
                      letterSpacing: 2.0,
                    )),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: TextFormField(
                    focusNode: focusNode,
                    //keyboardType: TextInputType.number,
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

                          var productObjects = {};
                          for (int i = 0; i < queryUserInfo.length; i++) {
                            productObjects = queryUserInfo[i];
                            if (queryUserInfo[i]["adminPass"] ==
                                _ctrlAllPass.text.toString()) {
                              //print(widget.loginObjects);
                              Navigator.pop(context);
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) {
                                  return OpenAdmin(widget.loginObjects);
                                }),
                              );

                              //Navigator.pop(context);
                              // showLoginSuccess();
                            } else if (_ctrlAllPass.text.toString().isEmpty) {
                              print("Enter PIN");
                            } else if (queryUserInfo[i]["loginPin"] !=
                                _ctrlAllPass.text.toString()) {
                              showLoginInvalid();
                            }
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
                        return AdminVerify(loginObjects);
                      }),
                    );
                  },
                  child: new Text(
                    "forgot Password?",
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
