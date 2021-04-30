import 'package:bloc_counter/core/util/input_converter.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';

main() {
  late InputConverter inputConverter;

  setUp(() {
    inputConverter = InputConverter();
  });

  group('String to Integer Conversion', () {
    test('Should return an Integer when the string represents an  integer',
        () async {
      //Arrange
      final String inputNumber = '0123000';
      //Act
      final result = inputConverter.stringToInteger(inputNumber);
      //Result
      expect(result, Right(123000));
    });

    test('Should return an Failure when the string not an integer', () async {
      //Arrange
      final String inputNumber = 'hye!';
      //Act
      final result = inputConverter.stringToInteger(inputNumber);
      //Result
      expect(result, Left(InvalidInputFailure()));
    });
  });
}
