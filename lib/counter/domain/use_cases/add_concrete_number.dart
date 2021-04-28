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
    final result = await repository.getLastNumber();

    return result.map((lastNumber) {
      final sum = lastNumber.number + params.number;
      repository.saveCacheNumber(CounterEntity(number: sum));
      return CounterEntity(number: sum);
    });
  }
}

class Params extends Equatable {
  final int number;
  Params({required this.number});

  @override
  List<Object?> get props => [number];
}
