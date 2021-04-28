import 'package:bloc_counter/counter/presentation/bloc/counter_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NumberControls extends StatefulWidget {
  @override
  _NumberControlsState createState() => _NumberControlsState();
}

class _NumberControlsState extends State<NumberControls> {
  final controller = TextEditingController();
  String inputStr = '1';
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //TextField
        TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Input a number',
            //floatingLabelBehavior: ,
            //fillColor: Colors.grey,
          ),
          onChanged: (value) {
            inputStr = value;
          },
          onSubmitted: (_) {
            dispatchConcrete();
          },
        ),
        SizedBox(height: 10),
        Row(
          //mainAxisAlignment: MainAxisAlignment.center,
          //crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              //Search concrete Button
              child: ElevatedButton(
                child: Text('Add number'),
                //color: Theme.of(context).accentColor,
                //textTheme: ButtonTextTheme.primary,
                onPressed: dispatchConcrete,
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              //Random Button
              child: ElevatedButton(
                child: Text('Add random Number'),
                //color: Theme.of(context).accentColor,
                //textTheme: ButtonTextTheme.primary,
                onPressed: dispatchRandom,
              ),
            )
          ],
        )
      ],
    );
  }

  void dispatchConcrete() {
    // Clearing the TextField to prepare it for the next inputted number
    controller.clear();
    BlocProvider.of<CounterBloc>(context).add(AddConcreteNumberEvent(inputStr));
  }

  void dispatchRandom() {
    controller.clear();
    BlocProvider.of<CounterBloc>(context).add(AddRandomNumberEvent());
  }
}
