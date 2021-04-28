import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_counter/core/error/failures.dart';
import 'package:bloc_counter/core/usecases/usecase.dart';
import 'package:bloc_counter/core/util/input_converter.dart';
import 'package:bloc_counter/counter/domain/entities/counter.dart';
import 'package:bloc_counter/counter/domain/use_cases/add_api_random_number.dart';
import 'package:bloc_counter/counter/domain/use_cases/add_concrete_number.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

part 'counter_event.dart';
part 'counter_state.dart';

const String SERVER_FAILURE_MESSAGE = 'Server Failure';
const String CACHE_FAILURE_MESSAGE = 'Cache Failure';
const String INVALID_INPUT_FAILURE_MESSAGE =
    'Invalid Input - The number must be a integer or zero.';

class CounterBloc extends Bloc<CounterEvent, CounterState> {
  final AddConcreteNumber addConcreteNumber;
  final AddRandomNumber addRandomNumber;
  final InputConverter inputConverter;

  CounterBloc(
      {required this.addConcreteNumber,
      required this.addRandomNumber,
      required this.inputConverter})
      : super(Empty());

  @override
  Stream<CounterState> mapEventToState(
    CounterEvent event,
  ) async* {
    if (event is AddConcreteNumberEvent) {
      final inputEither = inputConverter.stringToInteger(event.stringNumber);
      yield* inputEither.fold(
        (failure) async* {
          yield Error(message: INVALID_INPUT_FAILURE_MESSAGE);
        },
        (integer) async* {
          yield Loading();
          final failureOrNumber =
              await addConcreteNumber(Params(number: integer));

          yield* _eitherLoadedOrErrorState(failureOrNumber);
        },
      );
    } else if (event is AddRandomNumberEvent) {
      yield Loading();
      final failureOrNumber = await addRandomNumber(NoParams());
      yield* _eitherLoadedOrErrorState(failureOrNumber);
    }
  }

  Stream<CounterState> _eitherLoadedOrErrorState(
    Either<Failure, CounterEntity> failureOrNumber,
  ) async* {
    yield failureOrNumber.fold(
      (failure) => Error(message: _mapFailureToMessage(failure)),
      (number) => Loaded(number: number),
    );
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case CacheFailure:
        return CACHE_FAILURE_MESSAGE;
      default:
        return 'Unexpected error';
    }
  }
}
