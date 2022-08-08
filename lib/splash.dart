import 'package:flutter/material.dart';
import 'package:flutter_learn/home.dart';
import 'package:flutter_learn/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

const USERLOGEDIN = 'USERLOGEDIN';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    if (true) {
      // check login
      gotoLogin();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: (Center(child: Text('Loading...'))));
  }

  Future<void> gotoLogin() async {
    await Future.delayed(Duration(seconds: 0));
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (ctx) => LoginPage()));
  }

  Future<void> checkUserLoggedIn() async {
    final _sharedPrefs = await SharedPreferences.getInstance();
    final _userLogedIn = _sharedPrefs.getBool(USERLOGEDIN);
    if (_userLogedIn == null || _userLogedIn == false) {
      gotoLogin();
    } else {
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (ctx) => Home()));
    }
  }
}
