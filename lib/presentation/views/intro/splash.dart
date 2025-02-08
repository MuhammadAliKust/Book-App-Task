import 'dart:async';

import 'package:book_app/configs/frontend.dart';
import 'package:book_app/presentation/views/auth/login.dart';
import 'package:flutter/material.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    Timer(const Duration(seconds: 3), () {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => LoginView()));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: FrontendConfigs.kPrimaryColor,
      bottomNavigationBar: const Padding(
        padding: EdgeInsets.symmetric(vertical: 18.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Powered By: Ali Nizami",
              style: TextStyle(
                  fontSize: 12,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
      body: Center(
        child: Image.asset(
          'assets/images/book.png',
          color: Colors.white,
          height: 100,
        ),
      ),
    );
  }
}
