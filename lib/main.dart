import 'package:flutter/material.dart';
import 'package:zoe/pages/add_bot.dart';
import 'package:zoe/pages/bot.dart';
import 'package:zoe/pages/home.dart';
import 'package:zoe/pages/login.dart';
import 'package:zoe/pages/register.dart';
import 'package:zoe/pages/robots.dart';

import 'constants/themes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Zoe Demo',
      theme: Claro,
    onGenerateRoute: (RouteSettings settings) {
      return MaterialPageRoute(builder: (BuildContext context) {
        switch (settings.name) {
          case '/Login':
            return Login();
          case '/Register':
            return Register();
          case '/Home':
            return Home();
            case '/Robots':
            return Robots();
          case '/Add_Bot':
            return Add_Bot();
          case '/Bot':
            var arg = settings.arguments;
            return Bot(index: arg as int);
          default:
            return Login();
        }
      });
    }
    );
  }
}
