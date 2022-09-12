import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:prico/admin_setting.dart';
import 'package:prico/all_login.dart';
import 'package:prico/get_started.dart';
import 'data_helper.dart';

class InputPage extends StatefulWidget {
  @override
  _InputPageState createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  @override
  void initState() {
    super.initState();
  }

  Future<void> userData() async {
    List<Map<String, dynamic>> queryUserInfo =
        await DatabaseHelper.instance.queryAllPass();

    var productObjects = {};
    for (int i = 0; i < queryUserInfo.length; i++) {
      productObjects = queryUserInfo[i];
    }

    if (productObjects.isNotEmpty) {
      Navigator.pop(context);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) {
          return AllLogin();
        }),
      );
    } else {
      Navigator.pop(context);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) {
          return AdminSetting();
        }),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    child: Icon(
                      FontAwesomeIcons.cartShopping,
                      color: Colors.black,
                      size: 25.0,
                    ),
                    backgroundColor: Colors.white,
                    radius: 40.0,
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  Text('PRICE ASSISTANT',
                      style: TextStyle(
                        color: Color(0xFFb5a4e6),
                        letterSpacing: 2.0,
                      )),
                ],
              ),
            ),
          ),
          //=================================================
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [],
          ),
          //=================================================
          TextButton(
            onPressed: () {
              userData();
            },
            style: TextButton.styleFrom(
              primary: Colors.white,
              backgroundColor: Colors.white,
              minimumSize: Size(double.infinity, 65),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.zero)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Get Started',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20.0,
                    fontWeight: FontWeight.w400,
                    letterSpacing: 2.0,
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
