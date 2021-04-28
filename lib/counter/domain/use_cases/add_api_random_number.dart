import 'package:bloc_counter/core/error/failures.dart';
import 'package:bloc_counter/core/usecases/usecase.dart';
import 'package:bloc_counter/counter/domain/entities/counter.dart';
import 'package:bloc_counter/counter/domain/repositories/counter_repository.dart';
import 'package:dartz/dartz.dart';

class AddRandomNumber extends UseCase<CounterEntity, NoParams> {
  final CounterRepository repository;

  AddRandomNumber(this.repository);

  @override
  Future<Either<Failure, CounterEntity>> call(NoParams params) async {
    return await repository.addApiRandomNumber();
  }
}
