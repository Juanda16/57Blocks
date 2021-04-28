import 'package:bloc_counter/counter/domain/entities/counter.dart';
import 'package:flutter/material.dart';

class CounterDisplay extends StatelessWidget {
  final CounterEntity numberCounter;

  const CounterDisplay({Key? key, required this.numberCounter})
      : super(key: key);
  //final CounterEntity numberCounter = CounterEntity(number: 0);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 3,
      child: Column(
        children: [
          Text(
            numberCounter.number.toString(),
            style: TextStyle(
              fontSize: 50,
              fontWeight: FontWeight.bold,
            ),
          ),
          Expanded(
            child: Center(
              child: SingleChildScrollView(
                child: Text(
                  ' ',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
