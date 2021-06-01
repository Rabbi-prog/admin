import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:helpadmin/ar.dart';
import 'package:helpadmin/home.dart';
import 'package:helpadmin/users.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MaterialApp(
    home: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SignIn(),
    );
  }
}

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  TextEditingController _userName = TextEditingController();
  TextEditingController _password = TextEditingController();
  final firestoreInstance = FirebaseFirestore.instance;
  List<dynamic> userData = [];

  final _loginForm = GlobalKey<FormState>();
  check() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.getBool('isLogin');
    setState(() {
      if (prefs.getBool('isLogin') == true) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => MyHomePage()));
      }
    });
  }

  @override
  void initState() {
    check();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Form(
          key: _loginForm,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(flex: 2, child: StakedIcons()),
              Expanded(
                flex: 1,
                child: Text(
                  'Help Droid',
                  style: TextStyle(
                      fontSize: 35, fontFamily: 'Gilroy', color: Colors.blue),
                ),
              ),
              Expanded(
                flex: 1,
                child: Text(
                  'Admin Sign In',
                  style: TextStyle(
                      fontSize: 30, fontFamily: 'Gilroy', color: Colors.blue),
                ),
              ),
              Expanded(
                flex: 1,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: TextFormField(
                    controller: _userName,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Email can not be empty';
                      }

                      return null;
                    },
                    decoration: new InputDecoration(
                      focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.white, width: 0.0),
                          borderRadius: BorderRadius.circular(10)),
                      enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.grey[200], width: 0.0),
                          borderRadius: BorderRadius.circular(10)),
                      errorBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.red[300], width: 0.0),
                          borderRadius: BorderRadius.circular(10)),
                      focusedErrorBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.red[300], width: 0.0),
                          borderRadius: BorderRadius.circular(10)),
                      filled: true,
                      border: InputBorder.none,
                      hintText: 'Email',
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: TextFormField(
                    controller: _password,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Password can not be empty';
                      }

                      return null;
                    },
                    decoration: new InputDecoration(
                      focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.white, width: 0.0),
                          borderRadius: BorderRadius.circular(10)),
                      enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.grey[200], width: 0.0),
                          borderRadius: BorderRadius.circular(10)),
                      errorBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.red[300], width: 0.0),
                          borderRadius: BorderRadius.circular(10)),
                      focusedErrorBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.red[300], width: 0.0),
                          borderRadius: BorderRadius.circular(10)),
                      filled: true,
                      border: InputBorder.none,
                      hintText: 'Password',
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () async {
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      if (_loginForm.currentState.validate()) {
                        if ("adminX" == _userName.text &&
                            'pwX' == _password.text) {
                          prefs.setBool('isLogin', true);
                          Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (_) => MyHomePage()));
                        } else {}
                      }
                    },
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.lightBlue,
                      ),
                      width: MediaQuery.of(context).size.width,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: Text(
                            'Sign In',
                            style: TextStyle(
                                fontFamily: 'Gilroy',
                                fontSize: 20,
                                //  fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
  //https://www.youtube.com/watch?v=0sR1rU3gLzQ&ab_channel=TwoMinutePapers
//http://covid19tracker.gov.bd/api/country/latest?onlyCountries=true&iso3=BGD&fbclid=IwAR2hmNRpUxZ6785QTrCp_6CwbdQVUyptX5Wnw_SHCHPI7ZViaItngoQiqUs
  showAlertDialog(BuildContext context) {
    // set up the button
    Widget okButton = TextButton(
      child: Text("Try Again"),
      onPressed: () {
        Navigator.of(context, rootNavigator: true).pop();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Something Wrong"),
      content: Text("Your Username/Password combination may wrong"),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}

class StakedIcons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Stack(
      alignment: Alignment.center,
      children: <Widget>[
        new Container(
          height: 60.0,
          width: 60.0,
          decoration: new BoxDecoration(
              borderRadius: new BorderRadius.circular(50.0),
              color: Color(0xFF18D191)),
          child: new Icon(
            Icons.local_offer,
            color: Colors.white,
          ),
        ),
        new Container(
          margin: new EdgeInsets.only(right: 50.0, top: 50.0),
          height: 60.0,
          width: 60.0,
          decoration: new BoxDecoration(
              borderRadius: new BorderRadius.circular(50.0),
              color: Color(0xFFFC6A7F)),
          child: new Icon(
            Icons.home,
            color: Colors.white,
          ),
        ),
        new Container(
          margin: new EdgeInsets.only(left: 30.0, top: 50.0),
          height: 60.0,
          width: 60.0,
          decoration: new BoxDecoration(
              borderRadius: new BorderRadius.circular(50.0),
              color: Color(0xFFFFCE56)),
          child: new Icon(
            Icons.local_car_wash,
            color: Colors.white,
          ),
        ),
        new Container(
          margin: new EdgeInsets.only(left: 90.0, top: 40.0),
          height: 60.0,
          width: 60.0,
          decoration: new BoxDecoration(
              borderRadius: new BorderRadius.circular(50.0),
              color: Color(0xFF45E0EC)),
          child: new Icon(
            Icons.place,
            color: Colors.white,
          ),
        )
      ],
    );
  }
}
