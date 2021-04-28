import 'dart:convert';

import 'package:bloc_counter/counter/data/remote/data_sources/counter_number_remote_ds.dart';
import 'package:bloc_counter/counter/data/repositories/counter_repository_impl.dart';
import 'package:bloc_counter/counter/domain/repositories/counter_repository.dart';
import 'package:bloc_counter/counter/domain/use_cases/add_api_random_number.dart';
import 'package:bloc_counter/counter/domain/use_cases/add_concrete_number.dart';
import 'package:bloc_counter/counter/presentation/bloc/counter_bloc.dart';
//import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'core/network/network_info.dart';
import 'core/util/input_converter.dart';
import 'counter/data/local/data_sources/counter_number_local_ds.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl.registerFactory(
    () => CounterBloc(
      addConcreteNumber: sl(),
      addRandomNumber: sl(),
      inputConverter: sl(),
    ),
  );

  // Use cases
  sl.registerLazySingleton(() => AddConcreteNumber(sl()));
  sl.registerLazySingleton(() => AddRandomNumber(sl()));

  // Repository
  sl.registerLazySingleton<CounterRepository>(
    () => CounterRepositoryImpl(
      localDataSource: sl(),
      networkInfo: sl(),
      remoteDataSource: sl(),
    ),
  );
  // Data sources
  sl.registerLazySingleton<CounterNumberRemoteDataSource>(
    () => CounterNumberRemoteDataSourceImpl(client: sl()),
  );

  sl.registerLazySingleton<CounterNumberLocalDataSource>(
    () => CounterNumberLocalDataSourceImpl(sharedPreferences: sl()),
  );

  //! Core
  sl.registerLazySingleton(() => InputConverter());
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl());

  //! External
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
  //sl.registerLazySingleton(() => DataConnectionChecker());
  final initialValue = json.encode({"random": 0});
  sharedPreferences.setString('CACHED_NUMBER', initialValue);
}
