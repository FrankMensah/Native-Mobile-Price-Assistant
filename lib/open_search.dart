import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:prico/user_search_list.dart';
import 'database_helper.dart';
import 'models.dart';
import 'package:get/get.dart';

class OpenSearch extends StatefulWidget {
  const OpenSearch({Key? key}) : super(key: key);

  @override
  _OpenSearchState createState() => _OpenSearchState();
}

class _OpenSearchState extends State<OpenSearch> {
  //String userSearchInput = "";
  bool doItOnce = false;
  FetchUser _userList = FetchUser();
  List<PricoData> list = [];
  List<PricoData> filteredList = <PricoData>[];
  void filterList(value) {
    setState(() {
      filteredList = list
          .where((text) =>
              text.productName.toLowerCase().contains(value.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Container(
            child: Column(
              children: [
                Text(
                  'Search',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w200,
                      fontSize: 30.0,
                      letterSpacing: 3.0),
                ),
              ],
            ),
          ),
          //backgroundColor: Color(0xff482b9a),
        ),
        body: Column(
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Row(
                    children: [
                      Text(
                        "All Products:",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w200,
                            fontSize: 20.0,
                            letterSpacing: 3.0),
                      )
                    ],
                  ),
                ),
                Container(
                  height: 60,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: TextField(
                      onChanged: (value) => filterList(value),
                      decoration: InputDecoration(
                        prefixIcon: new Icon(
                          FontAwesomeIcons.searchengin,
                          color: Color(0xFF482b9a),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50.0),
                          borderSide: BorderSide.none,
                        ),
                        label: Text(
                          "Search products",
                          style: TextStyle(color: Color(0xFFb5a4e6)),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                decoration: BoxDecoration(),
                child: FutureBuilder(
                    future: _userList.pricoData(),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      var data = snapshot.data;
                      if (snapshot.hasData) {
                        if (!doItOnce) {
                          list = snapshot.data!;
                          filteredList = list;
                          doItOnce = !doItOnce;
                        }
                        return ListView.builder(
                            reverse: false,
                            shrinkWrap: true,
                            physics: const AlwaysScrollableScrollPhysics(),
                            itemCount: filteredList.length,
                            itemBuilder: (BuildContext context, int index) {
                              PricoData item = filteredList[index];
                              return Card(
                                child: ListTile(
                                  leading: Text('${item.id}'),
                                  title: Text(
                                    '${item.productName}',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        letterSpacing: 3.0),
                                  ),
                                  subtitle: Text(
                                      "Ghc" + " " + '${item.productAmount}'),
                                  trailing: Icon(
                                    FontAwesomeIcons.eye,
                                    color: Color(0xFF482b9a),
                                    size: 20.0,
                                  ),
                                  onTap: () {
                                    Get.defaultDialog(
                                      title: 'Prico',
                                      backgroundColor: Color(0xFF482b9a),
                                      titleStyle: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w200,
                                          letterSpacing: 3.0),
                                      content: setupAlertDialoadContainer(item),
                                    );
                                  },
                                ),
                              );
                            });
                      }

                      return Center(child: CircularProgressIndicator());
                    }),
              ),
            ),
          ],
        ));
  }
}

String totTitle(String input) {
  final List<String> splitStr = input.split(' ');
  for (int i = 0; i < splitStr.length; i++) {
    splitStr[i] = '${splitStr[i][0].toUpperCase()}${splitStr[i].substring(1)}';
  }
  final output = splitStr.join(' ');
  return output;
}

Widget setupAlertDialoadContainer(PricoData item) {
  return Container(
    //height: 300.0, // Change as per your requirement
    //width: 300.0, // Change as per your requirement
    child: SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircleAvatar(
            child: Icon(
              FontAwesomeIcons.cartShopping,
              color: Color(0xFF482b9a),
              size: 10.0,
            ),
            backgroundColor: Colors.white,
            radius: 20.0,
          ),
          SizedBox(
            height: 10.0,
          ),
          Form(
            child: Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.only(top: 10.0, right: 20, left: 20),
                  child: TextFormField(
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      letterSpacing: 3.0,
                    ),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      label: Center(
                        child: Text('${item.productCode}'),
                      ),
                      contentPadding: EdgeInsets.symmetric(vertical: 10.0),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(width: 1),
                        borderRadius: const BorderRadius.all(
                          const Radius.circular(2.0),
                        ),
                      ),
                    ),
                    enabled: false,
                  ),
                ),
//=========================================
                Padding(
                  padding:
                      const EdgeInsets.only(top: 20.0, right: 20, left: 20),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(2.0),
                    ),
                    width: double.infinity,
//height: 100.0,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: Column(
                            children: [
                              Text(
                                "Ghc",
                                style: TextStyle(
                                    color: Color(0xFF482b9a),
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.w200),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 10.0, bottom: 20.0, left: 10.0, right: 10.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                '${item.productAmount}',
                                style: TextStyle(
                                    color: Color(0xFF482b9a),
                                    fontSize: 50.0,
                                    fontWeight: FontWeight.w900),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
//=========================================
                Padding(
                  padding:
                      const EdgeInsets.only(top: 20.0, right: 20, left: 20),
                  child: Column(
                    children: [
                      Text(
                        totTitle('${item.productName}'),
                        style: TextStyle(
                          color: Colors.white,
                          letterSpacing: 3.0,
                          fontSize: 25.0,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          //SizedBox(height: 20.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  Get.back();
                },
                style: ElevatedButton.styleFrom(primary: Colors.black),
                child: Text("Cancel"),
              ),
            ],
          )
        ],
      ),
    ),
  );
}
