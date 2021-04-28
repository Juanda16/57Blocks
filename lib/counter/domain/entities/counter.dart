import 'package:equatable/equatable.dart';

class CounterEntity extends Equatable {
  final int number;

  CounterEntity({required this.number});

  @override
  List<Object> get props => [number];
}
// entidad si se pide de DB y si tiene id y se compara por ID
// Entities have value objects w/o any ID
// V_Obj are immutable
