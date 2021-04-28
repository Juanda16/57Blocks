import 'package:bloc_counter/counter/presentation/bloc/counter_bloc.dart';
import 'package:bloc_counter/counter/presentation/widgets/counter_controls.dart';
import 'package:bloc_counter/counter/presentation/widgets/counter_display.dart';
import 'package:bloc_counter/counter/presentation/widgets/loading_widget.dart';
import 'package:bloc_counter/counter/presentation/widgets/message_display.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../injection_container.dart';

class MainCounterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Silly Counter'),
        elevation: 30.0,
      ),
      body: buildBody(context),
    );
  }

  BlocProvider<CounterBloc> buildBody(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<CounterBloc>(),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //crossAxisAlignment: CrossAxisAlignment.center,
            //crossAxisAlignment: ,
            children: [
              SizedBox(
                height: 10,
              ),
              //Top Half
              BlocBuilder<CounterBloc, CounterState>(
                builder: (context, state) {
                  if (state is Empty) {
                    return MessageDisplay(
                      text: 'Star Searching',
                    );
                  } else if (state is Loading) {
                    return LoadingWidget();
                  } else if (state is Loaded) {
                    print('Loaded');
                    return CounterDisplay(numberCounter: state.number);
                  } else if (state is Error) {
                    return MessageDisplay(text: state.message);
                  } else {
                    return MessageDisplay(text: 'error');
                  }
                },
              ),

              SizedBox(
                height: 20,
              ),
              NumberControls()
            ],
          ),
        ),
      ),
    );
  }
}
