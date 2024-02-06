import 'package:flutter/material.dart';

import 'package:monitoring/kostum/textstyle.dart';

class MySensorCard2 extends StatelessWidget {
  const MySensorCard2(
      {Key? key,
      required this.name,
      required this.valid,
      required this.assetImage,
      required this.nilai})
      : super(key: key);

  final String name;
  final bool valid;
  final String nilai;
  final AssetImage assetImage;

  @override
  Widget build(BuildContext context) {
    return Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
        ),
        shadowColor: const Color.fromARGB(255, 169, 169, 169),
        elevation: 15.0,
        color: Colors.white,
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: 160,
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
                    Text(name, style: kBodyText.copyWith()),
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
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
                  child: SizedBox(
                    width: 200,
                    height: 200,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(nilai, style: kHeadline),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
