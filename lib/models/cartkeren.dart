import 'package:flutter/material.dart';
import 'package:monitoring/kostum/color.dart';
import 'package:monitoring/kostum/textstyle.dart';
import 'package:monitoring/models/circleprogres.dart';

class MySensorCard extends StatelessWidget {
  const MySensorCard(
      {Key? key,
      required this.name,
      required this.assetImage,
      required this.unit,
      required this.circular,
      required this.cek,
      required this.nilai})
      : super(key: key);

  final String name;
  final String unit;
  final double circular;
  final int nilai;
  final AssetImage assetImage;
  final bool cek;

  @override
  Widget build(BuildContext context) {
    return Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
        ),
        shadowColor: const Color.fromARGB(255, 169, 169, 169),
        elevation: 15.0,
        color: kMainBG,
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: 200,
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image(
                      width: 80,
                      image: assetImage,
                      height: 80,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(name, style: kBodyText.copyWith(color: Colors.white)),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 30, horizontal: 8),
                  child: CustomPaint(
                    foregroundPainter: CircleProgress(circular, cek),
                    child: SizedBox(
                      width: 200,
                      height: 200,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text('$nilai$unit', style: kHeadline),
                          ],
                        ),
                      ),
                    ),
                  ),
                  // child: Sparkline(
                  //   data: circular,
                  //   lineWidth: 5.0,
                  //   lineColor: Colors.white,
                  //   averageLine: true,
                  //   fillMode: FillMode.below,
                  //   fillGradient: const LinearGradient(
                  //     begin: Alignment.topCenter,
                  //     end: Alignment.bottomCenter,
                  //     colors: [kMainBG, kTextFieldFill],
                  //   ),
                  //   sharpCorners: false,
                  //   pointsMode: PointsMode.last,
                  //   pointSize: 20,
                  //   pointColor: nilai,
                  //   useCubicSmoothing: true,
                  // ),
                ),
              ),
            ],
          ),
        ));
  }
}
