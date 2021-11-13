import 'package:chat_final/screens/login_screen.dart';
import 'package:chat_final/screens/registration_screen.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:chat_final/components/rounded_button.dart';

class WelcomeScreen extends StatefulWidget {
  static const String id = 'welcome_screen ';

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  AnimationController? myControler;
  Animation? myAnimation;

  @override
  void initState() {
    super.initState();

    myControler = AnimationController(
      duration: Duration(seconds: 1),
      vsync: this,
    );

    myAnimation = ColorTween(begin: Colors.blueGrey, end: Colors.white)
        .animate(myControler!);
    myControler!.forward();

    myControler!.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
    myControler!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: myAnimation!.value,
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                Hero(
                  tag: 'logo',
                  child: Container(
                    child: Image.asset('images/logo.png'),
                    height: 90,
                  ),
                ),
                TextLiquidFill(
                  boxHeight: 80,
                  boxWidth: 250,
                  loadUntil: 1,
                  loadDuration: Duration(seconds: 6),
                  waveDuration: Duration(seconds: 2),
                  text: 'Easy Chat_',
                  waveColor: Colors.blue,
                  boxBackgroundColor: Colors.white,
                  textStyle: TextStyle(
                    fontSize: 45.0,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 48.0,
            ),
            RoundedButton(
              onClick: () {
                Navigator.pushNamed(context, LoginScreen.id);
              },
              kolorek: Colors.lightBlueAccent,
              tittleButton: 'Log In',
            ),
            RoundedButton(
              onClick: () {
                Navigator.pushNamed(context, RegistrationScreen.id);
              },
              tittleButton: 'Register',
              kolorek: Colors.blueAccent,
            ),
          ],
        ),
      ),
    );
  }
}

// liightblueaccent
// blueaccent
