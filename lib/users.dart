import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Users extends StatefulWidget {
  @override
  _UsersState createState() => _UsersState();
}

class _UsersState extends State<Users> {
  final firestoreInstance = FirebaseFirestore.instance;

  var dataFF2;
  List<dynamic> g = [];
  void _onPressed2() {
    firestoreInstance.collection("users").get().then((querySnapshot) {
      querySnapshot.docs.forEach((result) {
        dataFF2 = result.data();
        setState(() {
          g.add(dataFF2);
        });
      });
    });
  }

  @override
  void initState() {
    _onPressed2();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return g == null
        ? Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          )
        : Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.deepPurple,
              leading: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Padding(
                  padding: EdgeInsets.all(5.0),
                  child: Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                  ),
                ),
              ),
              title: Text('Users',
                  style: TextStyle(
                    fontSize: 25,
                    fontFamily: 'Gilroy',
                  )),
              centerTitle: true,
            ),
            body: ListView.builder(
                itemCount: g.length,
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    children: [
                      ListTile(
                        onTap: () {
                          //gg
                        },
                        title: Row(
                          children: [
                            Image.asset(
                              g[index]['sex'] == true
                                  ? 'asset/businessman-character-avatar-isolated_24877-60111.jpg'
                                  : 'asset/young-woman-white_25030-39527.jpg',
                              height: (MediaQuery.of(context).size.width / 4),
                              width: (MediaQuery.of(context).size.width / 4),
                            ),
                            Container(
                              width:
                                  (MediaQuery.of(context).size.width / 3) * 1.7,
                              child: Center(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: AutoSizeText(g[index]['name'],
                                          minFontSize: 10,
                                          maxLines: 3,
                                          overflow: TextOverflow.visible,
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontFamily: 'Gilroy',
                                          )),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: AutoSizeText(g[index]['email'],
                                          minFontSize: 10,
                                          maxLines: 3,
                                          overflow: TextOverflow.visible,
                                          style: TextStyle(
                                            fontSize: 15,
                                            fontFamily: 'Gilroy',
                                          )),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: AutoSizeText(g[index]['phn'],
                                          minFontSize: 10,
                                          maxLines: 3,
                                          overflow: TextOverflow.visible,
                                          style: TextStyle(
                                            fontSize: 15,
                                            fontFamily: 'Gilroy',
                                          )),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Divider(
                        height: 2,
                      )
                    ],
                  );
                }),
          );
  }
}
