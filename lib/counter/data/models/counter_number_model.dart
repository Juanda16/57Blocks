import 'package:bloc_counter/counter/domain/entities/counter.dart';

class CounterNumberModel extends CounterEntity {
  CounterNumberModel({required int number}) : super(number: number);

  factory CounterNumberModel.fromJson(Map<String, dynamic> json) {
    return CounterNumberModel(
      number: (json['random'] as num).toInt(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "random": number,
    };
  }
}
