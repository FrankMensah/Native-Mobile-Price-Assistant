import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class AboutUsMe extends StatefulWidget {
  @override
  _AboutUsMeState createState() => _AboutUsMeState();
}

class _AboutUsMeState extends State<AboutUsMe> {
  final phoneNumber = 'tel: +233277172086';
  final eMail =
      'mailto:levelskent@gmail.com?subject=Prico Assistant User&body=Supporting Prico Team';
  final linkIn = 'https://www.linkedin.com/in/levels-kent';

  void launcherUrl(String urlString) async {
    await canLaunchUrlString(urlString)
        ? await launchUrlString(urlString)
        : throw "Couldn't Launch $urlString";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF482b9a),
      body: SafeArea(
          child: Card(
        shadowColor: Colors.white,
        margin: EdgeInsets.symmetric(vertical: 130.0, horizontal: 30.0),
        color: Color(0xFF482b9a),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'PRICO',
              style: TextStyle(
                fontWeight: FontWeight.w200,
                letterSpacing: 3.0,
                color: Colors.white,
                fontSize: 20.0,
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            CircleAvatar(
              backgroundColor: Color(0xFF482b9a),
              radius: 50.0,
              backgroundImage: AssetImage('images/me.jpg'),
            ), //Profile Pic

            Text('Frank Mensah',
                style: TextStyle(
                  fontFamily: 'Pacifico',
                  fontSize: 30.0,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                )), //Full Name

            Text(
              'Ethical Hacker',
              style: TextStyle(
                  fontFamily: 'SourceSans',
                  color: Color(0xFFb5a4e6),
                  fontSize: 12.0,
                  letterSpacing: 2.5,
                  fontWeight: FontWeight.w200),
            ), //Profession
            Text(
              'Graphic Designer',
              style: TextStyle(
                  fontFamily: 'SourceSans',
                  color: Color(0xFFb5a4e6),
                  fontSize: 12.0,
                  letterSpacing: 2.5,
                  fontWeight: FontWeight.w200),
            ), //Prof
            Text(
              'Professional Programmer',
              style: TextStyle(
                  fontFamily: 'SourceSans',
                  color: Color(0xFFb5a4e6),
                  fontSize: 12.0,
                  letterSpacing: 2.5,
                  fontWeight: FontWeight.w200),
            ), //Profession
            SizedBox(
              height: 10.0,
              width: 150.0,
              child: Divider(
                color: Color(0xFFb5a4e6),
              ),
            ),
            new GestureDetector(
              onTap: () async {
                launcherUrl(phoneNumber);
              },
              child: Card(
                margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                child: Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Row(
                    children: [
                      Icon(
                        Icons.phone,
                        color: Color(0xFF482b9a),
                      ),
                      SizedBox(width: 15.0),
                      Text(
                        "+233 277 17 2086",
                        style: TextStyle(
                          fontSize: 12.0,
                        ),
                      )
                    ],
                  ),
                ),
              ), //Phone #
            ), //Divider

            new GestureDetector(
              onTap: () async {
                launcherUrl(eMail);
              },
              child: Card(
                margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                child: Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Row(
                    children: [
                      Icon(
                        Icons.mail,
                        color: Color(0xFF482b9a),
                      ),
                      SizedBox(width: 15.0),
                      Text(
                        "levelskent@gmail.com",
                        style: TextStyle(fontSize: 12.0),
                      ),
                    ],
                  ),
                ),
              ), //Email
            ), //Divider

            new GestureDetector(
                onTap: () async {
                  launcherUrl(linkIn);
                },
                child: Card(
                  margin:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 12.0),
                  child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Row(
                      children: [
                        Icon(
                          FontAwesomeIcons.linkedin,
                          color: Color(0xFF482b9a),
                        ),
                        SizedBox(width: 15.0),
                        Text(
                          "https://www.linkedin.com/in/levels-kent",
                          style: TextStyle(fontSize: 12.0),
                        ),
                      ],
                    ),
                  ),
                )), //Divider
          ],
        ),
      )),
    );
  }
}
