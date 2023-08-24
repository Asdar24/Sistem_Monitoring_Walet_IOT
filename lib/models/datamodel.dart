import 'package:flutter/foundation.dart';

@immutable
class Sensor {
  const Sensor({
    required this.humidity,
    required this.suhu,
  });

  Sensor.fromJson(Map<String, Object?> json)
      : this(
          humidity: json['Humidity']! as double,
          suhu: json['Suhu']! as double,
        );

  final double humidity;
  final double suhu;

  Map<String, Object?> toJson() {
    return {
      'humidity': humidity,
      'Suhu': suhu,
    };
  }
}
