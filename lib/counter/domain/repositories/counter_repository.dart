import 'package:bloc_counter/core/error/failures.dart';
import 'package:bloc_counter/counter/domain/entities/counter.dart';
import 'package:dartz/dartz.dart';

abstract class CounterRepository {
  Future<Either<Failure, CounterEntity>> addApiRandomNumber();

  Future<Either<Failure, CounterEntity>> getLastNumber(int number);
}
