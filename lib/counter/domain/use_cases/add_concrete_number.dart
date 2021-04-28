import 'package:bloc_counter/core/error/failures.dart';
import 'package:bloc_counter/core/usecases/usecase.dart';
import 'package:bloc_counter/counter/domain/entities/counter.dart';
import 'package:bloc_counter/counter/domain/repositories/counter_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class AddConcreteNumber extends UseCase<CounterEntity, Params> {
  final CounterRepository repository;

  AddConcreteNumber(this.repository);

  @override
  Future<Either<Failure, CounterEntity>> call(Params params) async {
    return await repository.getLastNumber(params.number);
  }
}

class Params extends Equatable {
  final int number;
  Params({required this.number});

  @override
  List<Object?> get props => [number];
}
