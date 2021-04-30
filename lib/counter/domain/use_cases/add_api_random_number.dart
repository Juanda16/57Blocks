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
    final lastValue = await repository.getLastNumber();
    final resultRandom = await repository.getApiRandomNumber();

    return resultRandom.fold((failure) => Left(failure), (random) {
      return lastValue.fold((failure) => Left(failure), (last) {
        final sum = last.number + random.number;
        repository.saveCacheNumber(CounterEntity(number: sum));
        return Right(CounterEntity(number: sum));
      });
    });
  }
}

// resultRandom.map((random) {
//   return lastValue
//       .map((last) => CounterEntity(number: (random.number + last.number)));
// });

//return result.map((r) => (CounterEntity(number: r.number + params.number)));
//lastValue.map((last) => CounterEntity(number: last.number+r.number ));
