import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:monitoring/models/cart.dart';

import 'package:monitoring/models/cartkeren.dart';

class Ragil extends StatefulWidget {
  const Ragil({Key? key}) : super(key: key);

  @override
  State<Ragil> createState() => _RagilState();
}

class _RagilState extends State<Ragil> with WidgetsBindingObserver {
  AnimationController? progressController;
  Animation<double>? suhuAnimation;
  Animation<double>? kelembapanAnimation;
  Animation<double>? kadarAnimation;
  String celsiusSymbol = '\u00B0';
  bool iscek = false;

  final DatabaseReference dbRef = FirebaseDatabase.instance.ref().child('Data');
  final DatabaseReference dbwrite = FirebaseDatabase.instance.ref();
  int _seconds = 0;
  late Timer _timer;
  bool _isPaused = false;
  bool _isStarted = false;
  bool value = true;

  onUpdate() {
    setState(() {
      value = !value;
    });
  }

  @override
  void initState() {
    super.initState();
    // progressController = AnimationController(
    //   vsync: this, // the SingleTickerProviderStateMixin
    //   duration: const Duration(milliseconds: 2000),
    // );
    WidgetsBinding.instance.addObserver(this as WidgetsBindingObserver);
  }

  String _formatDuration(Duration duration) {
    return '${duration.inHours.toString().padLeft(2, '0')}:${(duration.inMinutes % 60).toString().padLeft(2, '0')}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
  }

  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      // Aplikasi kembali ke foreground, jangan lakukan apa-apa
    } else if (state == AppLifecycleState.paused) {
      // Aplikasi ditutup (background mode), timer tetap berjalan
    }
  }

  @override
  void dispose() {
    _timer.cancel(); // Hentikan timer saat widget dihapus
    WidgetsBinding.instance.removeObserver(this as WidgetsBindingObserver);
    super.dispose();
  }

  // ignore: non_constant_identifier_names
  // _DashboardInit(int suhu, int kelembapan, double kadarair) {
  //   //5s

  //   suhuAnimation = Tween<double>(begin: 0, end: suhu.toDouble())
  //       .animate(progressController!)
  //     ..addListener(() {
  //       setState(() {});
  //     });

  //   kelembapanAnimation = Tween<double>(begin: -50, end: kelembapan.toDouble())
  //       .animate(progressController!)
  //     ..addListener(() {
  //       setState(() {});
  //     });

  //   kadarAnimation =
  //       Tween<double>(begin: 0, end: kadarair).animate(progressController!)
  //         ..addListener(() {
  //           setState(() {});
  //         });

  //   progressController!.forward();
  // }

  @override
  Widget build(BuildContext context) {
    Duration duration = Duration(seconds: _seconds);
    String formattedDuration = _formatDuration(duration);
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "PENGERING BAWANG MERAH",
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
                final pompa = datanya['Heater'];
                // ignore: unused_local_variable
                final kadarair = datanya['KadarAir'];
                // _DashboardInit(suhu, kelembapan, kadarair);

                return SingleChildScrollView(
                  child: Column(
                    children: [
                      MySensorCard(
                        unit: ' %',
                        name: 'Kelembapan',
                        assetImage: const AssetImage(
                          "assets/images/humidity_icon.png",
                        ),
                        nilai: kelembapan,
                      ),
                      const SizedBox(height: 10),
                      MySensorCard(
                        unit: '$celsiusSymbol C',
                        name: 'Suhu',
                        assetImage: const AssetImage(
                          "assets/images/temperaturee.png",
                        ),
                        nilai: suhu,
                      ),
                      const SizedBox(height: 10),
                      MySensorCard(
                        unit: ' %',
                        name: 'kadar Air',
                        assetImage: const AssetImage(
                          "assets/images/Asset1.png",
                        ),
                        nilai: kadarair.toInt(),
                      ),
                      const SizedBox(height: 10),
                      MySensorCard2(
                          valid: pompa == 1 ? false : true,
                          name: "Heater",
                          assetImage:
                              const AssetImage("assets/images/heater.png"),
                          nilai: pompa == 1 ? "ON" : "OFF"),
                      const SizedBox(height: 10),
                      // Card(
                      //     shape: RoundedRectangleBorder(
                      //       borderRadius: BorderRadius.circular(18),
                      //     ),
                      //     shadowColor: const Color.fromARGB(255, 169, 169, 169),
                      //     elevation: 15.0,
                      //     color: Colors.white,
                      //     child: SizedBox(
                      //       width: MediaQuery.of(context).size.width,
                      //       height: 160,
                      //       child: Row(
                      //         children: [
                      //           Expanded(
                      //             flex: 1,
                      //             child: Column(
                      //               mainAxisAlignment: MainAxisAlignment.center,
                      //               crossAxisAlignment:
                      //                   CrossAxisAlignment.center,
                      //               children: [
                      //                 const Image(
                      //                   width: 80,
                      //                   image: AssetImage(
                      //                       "assets/images/brawel.png"),
                      //                   height: 80,
                      //                 ),
                      //                 const SizedBox(
                      //                   height: 10,
                      //                 ),
                      //                 Text("Blower",
                      //                     style: kBodyText.copyWith()),
                      //                 const SizedBox(
                      //                   height: 10,
                      //                 ),
                      //               ],
                      //             ),
                      //           ),
                      //           Expanded(
                      //             flex: 1,
                      //             child: Padding(
                      //               padding: const EdgeInsets.only(
                      //                   left: 30, right: 30),
                      //               child: FloatingActionButton(
                      //                   onPressed: () {
                      //                     onUpdate();
                      //                     onWrite();
                      //                   },
                      //                   child: value
                      //                       ? const Text("OFF")
                      //                       : const Text("ON")),
                      //             ),
                      //           ),
                      //         ],
                      //       ),
                      //     )),
                      // const SizedBox(height: 10),
                      Column(
                        children: [
                          Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18),
                              ),
                              shadowColor:
                                  const Color.fromARGB(255, 169, 169, 169),
                              elevation: 15.0,
                              color: Colors.white,
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width,
                                height: 160,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      formattedDuration,
                                      style: const TextStyle(fontSize: 35),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        ElevatedButton(
                                          onPressed: () {
                                            if (!_isStarted) {
                                              _startTimer();

                                              onWrite();
                                            } else {
                                              _restartTimer();
                                            }
                                          },
                                          child: Text(
                                            !_isStarted ? 'Start' : 'Restart',
                                          ),
                                        ),
                                        const SizedBox(width: 20),
                                        ElevatedButton(
                                          onPressed: () {
                                            if (_isStarted && !_isPaused) {
                                              _pauseTimer();
                                            } else if (_isPaused) {
                                              _resumeTimer();
                                            }
                                          },
                                          child: Text(
                                            _isPaused ? 'Resume' : 'Pause',
                                          ),
                                        ),
                                        const SizedBox(width: 20),
                                        ElevatedButton(
                                          onPressed: () {
                                            _stopTimer();
                                            onWrite1();
                                          },
                                          child: const Text(
                                            'Stop',
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              )),
                        ],
                      )
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

  Future<void> onWrite() async {
    dbwrite.child("Blawer").set({"BlawerButton": true});
  }

  Future<void> onWrite1() async {
    dbwrite.child("Blawer").set({"BlawerButton": false});
  }

  void _pauseTimer() {
    if (_timer.isActive && !_isPaused) {
      _timer.cancel();
      setState(() {
        _isPaused = true;
      });
    }
  }

  void _resumeTimer() {
    if (_isPaused) {
      _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        setState(() {
          if (_seconds >= 68400) {
            _timer.cancel();
          } else {
            _seconds++;
          }
        });
      });
      setState(() {
        _isPaused = false;
      });
    }
  }

  void _stopTimer() {
    _timer.cancel();
    setState(() {
      _seconds = 0;
      _isPaused = false;
      _isStarted = false;
    });
  }

  void _restartTimer() {
    _timer.cancel();
    setState(() {
      _seconds = 0;
      _isPaused = false;
      _isStarted = false;
    });
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_seconds >= 68400) {
          _timer.cancel();
        } else {
          _seconds++;
        }
      });
    });
    setState(() {
      _isPaused = false;
      _isStarted = true;
    });
  }
}
