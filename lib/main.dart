import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:prico/about_me.dart';
import 'package:prico/all_product.dart';
import 'package:prico/open_search.dart';
import 'all_login.dart';
import 'input_page.dart';
import 'get_started.dart';
import 'open_admin_options.dart';

void main() => runApp(const PriceAssistant());

class PriceAssistant extends StatelessWidget {
  const PriceAssistant({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          appBarTheme: const AppBarTheme(
            backgroundColor: Color(0xff482b9a),
          ),
          scaffoldBackgroundColor: const Color(0xFF482b9a)),
      home: InputPage(),
    );
  }
}
