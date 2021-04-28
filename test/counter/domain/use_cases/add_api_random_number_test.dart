import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_counter/core/usecases/usecase.dart';
import 'package:bloc_counter/counter/domain/entities/counter.dart';
import 'package:bloc_counter/counter/domain/repositories/counter_repository.dart';
import 'package:bloc_counter/counter/domain/use_cases/add_api_random_number.dart';
import 'package:dartz/dartz.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'add_api_random_number_test.mocks.dart';

@GenerateMocks([CounterRepository])
void main() {
  late MockCounterRepository mockCounterRepository;
  late AddRandomNumber useCase;

  setUp(() {
    mockCounterRepository = MockCounterRepository();
    useCase = AddRandomNumber(mockCounterRepository);
  });
  final CounterEntity tNumber = CounterEntity(number: 1);

  test('Should get random number from the repository', () async {
    //Arrange
    when(mockCounterRepository.addApiRandomNumber())
        .thenAnswer((_) async => Right(tNumber));
    //Act

    final result = await useCase(NoParams());

    //Assert
    expect(result, Right(tNumber));
    verify(mockCounterRepository.addApiRandomNumber());
    verifyNoMoreInteractions(mockCounterRepository);
  });
}
