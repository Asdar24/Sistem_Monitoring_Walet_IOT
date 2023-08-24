import 'dart:async';

import 'package:flutter/material.dart';
// import 'package:lottie/lottie.dart';

import 'package:monitoring/ui/home.dart';

class SplashScreenPage extends StatefulWidget {
  const SplashScreenPage({Key? key}) : super(key: key);
  @override
  SplashScreenPageState createState() => SplashScreenPageState();
}

class SplashScreenPageState extends State<SplashScreenPage> {
  @override
  void initState() {
    super.initState();
    openSplashScreen();
  }

  openSplashScreen() async {
    //bisa diganti beberapa detik sesuai keinginan
    var durasiSplash = const Duration(seconds: 3);
    return Timer(durasiSplash, () {
      //pindah ke halaman home
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) {
        return const Ragil();
      }));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              "assets/images/waleet.jpg",
              width: 200,
              height: 200,
            )
          ],
        ),
      ),
      // body: ListView(
      //   padding: const EdgeInsets.symmetric(vertical: 200),
      //   children: [
      //     Lottie.asset(
      //       "assets/images/walet.json",
      //       width: 200,
      //       height: 200,
      //     ),
      //     const Text(
      //       "Welcome To Monitoring Walet",
      //       textAlign: TextAlign.center,
      //       style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
      //     )
      //   ],
      // )
    );
  }
}
