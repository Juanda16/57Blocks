import 'package:bloc_counter/core/error/exceptions.dart';
import 'package:bloc_counter/core/error/failures.dart';
import 'package:bloc_counter/core/network/network_info.dart';
import 'package:bloc_counter/counter/data/local/data_sources/counter_number_local_ds.dart';
import 'package:bloc_counter/counter/data/models/counter_number_model.dart';
import 'package:bloc_counter/counter/data/remote/data_sources/counter_number_remote_ds.dart';
import 'package:bloc_counter/counter/domain/entities/counter.dart';
import 'package:bloc_counter/counter/domain/repositories/counter_repository.dart';
import 'package:dartz/dartz.dart';

typedef Future<CounterEntity> _ConcreteOrRandomChooser();

class CounterRepositoryImpl implements CounterRepository {
  final CounterNumberRemoteDataSource remoteDataSource;
  final CounterNumberLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  CounterRepositoryImpl(
      {required this.remoteDataSource,
      required this.localDataSource,
      required this.networkInfo});

  @override
  Future<Either<Failure, CounterEntity>> addApiRandomNumber() async {
    return await _getResult(() {
      return remoteDataSource.getRemoteRandomNumber();
    });
  }

  @override
  Future<Either<Failure, CounterEntity>> getLastNumber(int number) async {
    return await _getResult(() {
      return localDataSource.getLastNumber();
    });
  }

  Future<Either<Failure, CounterEntity>> _getResult(
    _ConcreteOrRandomChooser getConcreteOrRandom,
  ) async {
    CounterEntity num = CounterEntity(number: 1);
    if (await networkInfo.isConnected) {
      try {
        final remoteNumber = await getConcreteOrRandom();
        CounterNumberModel modelRemoteNumber =
            CounterNumberModel(number: remoteNumber.number);
        localDataSource.cacheNumber(modelRemoteNumber);
        return Right(remoteNumber);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localNumber = await localDataSource.getLastNumber();
        return Right(localNumber);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }
}
