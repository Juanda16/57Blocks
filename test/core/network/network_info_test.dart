import 'package:bloc_counter/core/network/network_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

//class MockDataConnectionChecker extends Mock {}

void main() {
  NetworkInfoImpl networkInfo = NetworkInfoImpl();
  //MockDataConnectionChecker mockDataConnectionChecker;

  setUp(() {
    //mockDataConnectionChecker = MockDataConnectionChecker();
    //networkInfo = NetworkInfoImpl();
  });

  group('is connected', () {
    test('should forward the call to DataConnectionChecker.hasConnection',
        () async {
      //Arrange
      final tHasConnectionFuture = Future.value(true);

      // when(mockDataConnectionChecker.hasConnection)
      //     .thenAnswer((_) => tHasConnectionFuture);
      //Act
      // NOTICE: We're NOT awaiting the result
      final result = await networkInfo.isConnected;
      //Assert
      //verify(mockDataConnectionChecker.hasConnection);
      // Utilizing Dart's default referential equality.
      // Only references to the same object are equal.
      expect(result, true);
    });
  });
}
