import 'package:bloc_counter/counter/domain/entities/counter.dart';
import 'package:bloc_counter/counter/domain/repositories/counter_repository.dart';
import 'package:bloc_counter/counter/domain/use_cases/add_concrete_number.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'add_api_random_number_test.mocks.dart';

void main() {
  late MockCounterRepository mockCounterRepository;
  late AddConcreteNumber useCase;

  setUp(() {
    mockCounterRepository = MockCounterRepository();
    useCase = AddConcreteNumber(mockCounterRepository);
  });
  final CounterEntity tNumber = CounterEntity(number: 1);
  final CounterEntity tAddedNumber = CounterEntity(number: 2);
  final int number = 1;

  test('Should get concrete number from the repository', () async {
    //Arrange
    when(mockCounterRepository.getLastNumber())
        .thenAnswer((_) async => Right(tNumber));
    //Act

    final result = await useCase(Params(number: number));

    //Assert
    expect(result, Right(tAddedNumber));
    verify(mockCounterRepository.getLastNumber());
    verify(mockCounterRepository.saveCacheNumber(tAddedNumber));
    //verifyNoMoreInteractions(mockCounterRepository.getApiRandomNumber());
  });
}
