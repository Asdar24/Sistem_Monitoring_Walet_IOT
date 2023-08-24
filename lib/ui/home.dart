import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:monitoring/kostum/color.dart';
import 'package:monitoring/models/cart.dart';

import 'package:monitoring/models/cartkeren.dart';

class Ragil extends StatefulWidget {
  const Ragil({Key? key}) : super(key: key);

  @override
  State<Ragil> createState() => _RagilState();
}

class _RagilState extends State<Ragil> with SingleTickerProviderStateMixin {
  AnimationController? progressController;
  Animation<double>? suhuAnimation;
  Animation<double>? kelembapanAnimation;
  String celsiusSymbol = '\u00B0';
  bool iscek = false;

  final DatabaseReference dbRef = FirebaseDatabase.instance.ref().child('Data');

  @override
  void initState() {
    super.initState();
    progressController = AnimationController(
      vsync: this, // the SingleTickerProviderStateMixin
      duration: const Duration(milliseconds: 2000),
    );
  }

  // ignore: non_constant_identifier_names
  _DashboardInit(int suhu, int kelembapan) {
    //5s

    suhuAnimation = Tween<double>(begin: 0, end: suhu.toDouble())
        .animate(progressController!)
      ..addListener(() {
        setState(() {});
      });

    kelembapanAnimation = Tween<double>(begin: -50, end: kelembapan.toDouble())
        .animate(progressController!)
      ..addListener(() {
        setState(() {});
      });

    progressController!.forward();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kMainBG,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "MONITORING WALET",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: StreamBuilder<DatabaseEvent>(
            stream: dbRef.onValue,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else if (snapshot.hasData) {
                final datanya =
                    snapshot.data!.snapshot.value as Map<dynamic, dynamic>;
                // ignore: unused_local_variable
                final suhu = datanya['Suhu'];
                // ignore: unused_local_variable
                final kelembapan = datanya['Kelembapan'];
                // ignore: unused_local_variable
                final pompa = datanya['Pompa'];

                _DashboardInit(suhu, kelembapan);

                return SingleChildScrollView(
                  child: Column(
                    children: [
                      MySensorCard(
                        cek: false,
                        unit: ' %',
                        name: 'Kelembapan',
                        assetImage: const AssetImage(
                          "assets/images/humidity_icon.png",
                        ),
                        circular: kelembapanAnimation!.value,
                        nilai: kelembapanAnimation!.value.toInt(),
                      ),
                      const SizedBox(height: 10),
                      MySensorCard(
                        cek: true,
                        unit: '$celsiusSymbol C',
                        name: 'Suhu',
                        assetImage: const AssetImage(
                          "assets/images/temperaturee.png",
                        ),
                        circular: suhuAnimation!.value,
                        nilai: suhuAnimation!.value.toInt(),
                      ),
                      const SizedBox(height: 10),
                      MySensorCard2(
                          valid: pompa == 1 ? false : true,
                          name: "Pompa",
                          assetImage:
                              const AssetImage("assets/images/water.png"),
                          nilai: pompa == 1 ? "ON" : "OFF"),
                    ],
                  ),
                );
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            }),
      ),
    );
  }
}
