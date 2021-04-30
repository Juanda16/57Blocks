import 'package:bloc_counter/core/error/failures.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_counter/core/usecases/usecase.dart';
import 'package:bloc_counter/counter/domain/entities/counter.dart';
import 'package:bloc_counter/counter/domain/repositories/counter_repository.dart';
import 'package:bloc_counter/counter/domain/use_cases/add_api_random_number.dart';
import 'package:dartz/dartz.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'add_api_random_number_test.mocks.dart';

//class MockCounterRepository extends Mock implements CounterRepository {}

@GenerateMocks([],
    customMocks: [MockSpec<CounterRepository>(returnNullOnMissingStub: true)])
void main() {
  late MockCounterRepository mockCounterRepository;
  late AddRandomNumber useCase;

  setUp(() {
    mockCounterRepository = MockCounterRepository();
    useCase = AddRandomNumber(mockCounterRepository);
  });
  final CounterEntity tNumber = CounterEntity(number: 1);
  final CounterEntity tAddNumber = CounterEntity(number: 2);

  test('Should get random number from the repository', () async {
    //Arrange
    when(mockCounterRepository.getApiRandomNumber())
        .thenAnswer((_) async => Right(tNumber));
    when(mockCounterRepository.getLastNumber())
        .thenAnswer((realInvocation) async {
      mockCounterRepository.saveCacheNumber(tNumber);
      return Right(tNumber);
    });
    // when(mockCounterRepository.saveCacheNumber(tNumber))
    //     .thenAnswer((realInvocation) async {});
    //Act

    final result = await useCase(NoParams());

    //Assert
    expect(result, Right(tAddNumber));
    verify(mockCounterRepository.getApiRandomNumber());
    verify(mockCounterRepository.getLastNumber());
    verify(mockCounterRepository.saveCacheNumber(tAddNumber));
    //verifyNoMoreInteractions(mockCounterRepository);
  });
}
