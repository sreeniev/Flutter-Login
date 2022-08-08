import 'package:flutter/material.dart';
import 'package:flutter_learn/home.dart';
import 'package:flutter_learn/splash.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _usernameCtrl = TextEditingController();

  final _passCtrl = TextEditingController();
  bool hasError = false;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Enter same username & password'),
                SizedBox(height: 20),
                TextFormField(
                  controller: _usernameCtrl,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), hintText: 'Username'),
                  validator: (text) {
                    if (text == null || text.isEmpty) {
                      return 'Enter username';
                    } else {
                      return null;
                    }
                  },
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: _passCtrl,
                  obscureText: true,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), hintText: 'Pass'),
                  validator: (text) {
                    if (text == null || text.isEmpty) {
                      return 'Enter password';
                    } else {
                      return null;
                    }
                  },
                ),
                SizedBox(height: 20),
                Visibility(
                    visible: hasError,
                    child: Text('Invalid credentials',
                        style: TextStyle(color: Colors.red))),
                SizedBox(height: 20),
                ElevatedButton.icon(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        checkLogin(context);
                      } else {
                        print('Data empty');
                      }
                    },
                    icon: Icon(Icons.check),
                    label: Text('Login'))
              ],
            ),
          ),
        ),
      ),
    );
  }

  checkLogin(BuildContext ctx) async {
    final _username = _usernameCtrl.text;
    final _pass = _passCtrl.text;

    if (_username != _pass) {
      setState(() => hasError = true);
      // showAlertMessage(ctx);

      ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(
        content: Text('Error'),
        margin: EdgeInsets.all(5),
        behavior: SnackBarBehavior.floating,
      ));
    } else {
      setState(() => hasError = false);
      final _sharedPrefs = await SharedPreferences.getInstance();
      await _sharedPrefs.setBool(USERLOGEDIN, true);
      Navigator.of(ctx)
          .pushReplacement(MaterialPageRoute(builder: (ctx1) => Home()));
    }
  }

  showAlertMessage(BuildContext ctx) {
    showDialog(
        context: ctx,
        builder: (ctx1) => AlertDialog(
              title: Text('Error'),
              content: Text('Not match'),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.of(ctx1).pop();
                    },
                    child: Text('Close'))
              ],
            ));
  }
}
