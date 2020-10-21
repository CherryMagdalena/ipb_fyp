import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:ipb_fyp/components/alert_dialog.dart';
import 'package:ipb_fyp/resources/color.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ipb_fyp/screens/home_screen.dart';
import 'package:ipb_fyp/screens/sign_up_screen.dart';
import 'package:ipb_fyp/services/app_state.dart';
import 'package:ipb_fyp/services/firebase.dart';
import 'package:firebase_core/firebase_core.dart';

main() {
  runApp(LogInScreen());
}

class LogInScreen extends StatefulWidget {
  @override
  _LogInScreenState createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        color: kBackgroundColor,
        home: Scaffold(
          backgroundColor: kBackgroundColor,
          body: Center(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Image.asset('image/logo.png'),
              FutureBuilder(
                // Initialize FlutterFire
                future: Firebase.initializeApp(),
                builder: (context, snapshot) {
                  // Check for errors
                  if (snapshot.hasError) {
                    showSkipRegistrationDialog(context, () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return HomeScreen();
                      }));
                    });
                  }

                  // Once complete, show your application
                  if (snapshot.connectionState == ConnectionState.done) {
                    return Form(
                      key: _formKey,
                      child: Padding(
                        padding: EdgeInsets.only(left: 50.0, right: 50.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            TextFormField(
                              controller: _emailController,
                              decoration: const InputDecoration(
                                  labelText: 'Email',
                                  border: OutlineInputBorder(),
                                  filled: true,
                                  fillColor: Colors.white54),
                              validator: (String value) {
                                if (value.isEmpty) {
                                  return 'Please enter some text';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 30.0),
                            TextFormField(
                              controller: _passwordController,
                              obscureText: true,
                              decoration: const InputDecoration(
                                  labelText: 'Password',
                                  border: OutlineInputBorder(),
                                  filled: true,
                                  fillColor: Colors.white54),
                              validator: (String value) {
                                if (value.isEmpty) {
                                  return 'Please enter some text';
                                }
                                return null;
                              },
                            ),
                            Container(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 16.0),
                              alignment: Alignment.center,
                              child: RaisedButton(
                                onPressed: () async {
                                  if (_formKey.currentState.validate()) {
                                    _logIn();
                                    AppState().logIn();
                                  }
                                },
                                child: const Text('Log In'),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('No account yet? Register '),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (context) {
                                      return SignUpScreen();
                                    }));
                                  },
                                  child: Text(
                                    'here',
                                    style: TextStyle(color: kPrimaryColor),
                                  ),
                                ),
                                Text('!'),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  }
                  // Otherwise, show something whilst waiting for initialization to complete
                  return Container();
                },
              ),
              RaisedButton(
                color: kPrimaryColor,
                child: Text('Skip Registration'),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => HomeScreen()));
                },
              )
            ]),
          ),
        ));
  }

  void _logIn() async {
    bool success = await FirebaseService().logIn(
        email: _emailController.text, password: _passwordController.text);
    if (success) {
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return HomeScreen();
      }));
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}

class CustomTextField extends StatelessWidget {
  final String hint;
  CustomTextField(this.hint);
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            color: kDarkestColor, borderRadius: BorderRadius.circular(5.0)),
        width: 250.0,
        child: TextField(
          decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: hint,
              hintStyle: TextStyle(color: Colors.white)),
        ));
  }
}
