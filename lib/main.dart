import 'package:flutter/material.dart';
import 'package:chat_final/screens/welcome_screen.dart';
import 'package:chat_final/screens/registration_screen.dart';
import 'package:chat_final/screens/login_screen.dart';
import 'package:chat_final/screens/chat_screen.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  runApp(FlashChat());
}

class FlashChat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Mapa routes key - String oraz funkcja odwolania do context i gdzie sie przeniesc

      initialRoute: WelcomeScreen.id,
      routes: {
        WelcomeScreen.id: (context) => WelcomeScreen(),
        LoginScreen.id: (context) => LoginScreen(),
        RegistrationScreen.id: (context) => RegistrationScreen(),
        ChatScreen.id: (context) => ChatScreen(),
      },
    );
  }
}

/*test 1 branch*/
///sss
/// ///sss

/// ///ssss
/// ss
