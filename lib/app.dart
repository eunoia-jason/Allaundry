import 'dart:async';

import 'package:flutter/material.dart';

import 'login.dart';
import 'address.dart';

class AllaundryApp extends StatelessWidget {
  const AllaundryApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: const Color(0xff4B6EFE),
      ),
      title: 'Allaundry',
      initialRoute: '/loading',
      routes: {
        '/loading': (BuildContext context) => const LoadingPage(),
        '/login': (BuildContext context) => const LoginPage(),
        // TODO: Change to a Backdrop with a HomePage frontLayer (104)
        '/': (BuildContext context) => const HomePage(),
        // TODO: Make currentCategory field take _currentCategory (104)
        // TODO: Pass _currentCategory for frontLayer (104)
        // TODO: Change backLayer field value to CategoryMenuPage (104)
      },
      // TODO: Add a theme (103)
    );
  }
}

class LoadingPage extends StatefulWidget {
  const LoadingPage({Key? key}) : super(key: key);

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  @override
  void initState() {
    Timer(const Duration(milliseconds: 3000), () {
      Navigator.push(context, MaterialPageRoute(
          builder: (context) => const LoginPage(),
      ));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    const String imageLogoName = 'https://firebasestorage.googleapis.com/v0/b/project-e3738.appspot.com/o/source%2FAllaundry%20Loading.png?alt=media&token=0798e668-4dae-4a4e-9272-219b54c04d42';

    return WillPopScope(
      onWillPop: () async => false,
      child: MediaQuery(
        data: MediaQuery.of(context).copyWith(textScaleFactor:1.0),
        child: Scaffold(
          body: SizedBox(
            width: MediaQuery.of(context).size.width,
            height : MediaQuery.of(context).size.height,
            child: Image.network(
              imageLogoName,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}