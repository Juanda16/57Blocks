part of 'counter_bloc.dart';

abstract class CounterEvent extends Equatable {
  const CounterEvent();
  @override
  List<Object?> get props => [];
}

class AddRandomNumberEvent extends CounterEvent {}

class AddConcreteNumberEvent extends CounterEvent {
  final String stringNumber;

  AddConcreteNumberEvent(this.stringNumber);
  @override
  List<Object?> get props => [stringNumber];
}
