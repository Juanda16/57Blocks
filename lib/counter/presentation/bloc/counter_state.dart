part of 'counter_bloc.dart';

abstract class CounterState extends Equatable {
  const CounterState();
  @override
  List<Object> get props => [];
}

class Empty extends CounterState {}

class Loading extends CounterState {}

class Loaded extends CounterState {
  final CounterEntity number;

  Loaded({required this.number});

  @override
  List<Object> get props => [number];
}

class Error extends CounterState {
  final String message;

  Error({required this.message});

  @override
  List<Object> get props => [message];
}
