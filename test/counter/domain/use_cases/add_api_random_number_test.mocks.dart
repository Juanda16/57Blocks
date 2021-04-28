// Mocks generated by Mockito 5.0.5 from annotations
// in bloc_counter/test/counter/domain/use_cases/add_api_random_number_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i4;

import 'package:bloc_counter/core/error/failures.dart' as _i5;
import 'package:bloc_counter/counter/domain/entities/counter.dart' as _i6;
import 'package:bloc_counter/counter/domain/repositories/counter_repository.dart'
    as _i3;
import 'package:dartz/dartz.dart' as _i2;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: comment_references
// ignore_for_file: unnecessary_parenthesis

class _FakeEither<L, R> extends _i1.Fake implements _i2.Either<L, R> {}

/// A class which mocks [CounterRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockCounterRepository extends _i1.Mock implements _i3.CounterRepository {
  MockCounterRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<_i2.Either<_i5.Failure, _i6.CounterEntity>> addApiRandomNumber() =>
      (super.noSuchMethod(Invocation.method(#addApiRandomApiNumber, []),
          returnValue: Future<_i2.Either<_i5.Failure, _i6.CounterEntity>>.value(
              _FakeEither<_i5.Failure, _i6.CounterEntity>())) as _i4
          .Future<_i2.Either<_i5.Failure, _i6.CounterEntity>>);
  @override
  _i4.Future<_i2.Either<_i5.Failure, _i6.CounterEntity>> getLastNumber(
          int? number) =>
      (super.noSuchMethod(Invocation.method(#addConcreteNumber, [number]),
          returnValue: Future<_i2.Either<_i5.Failure, _i6.CounterEntity>>.value(
              _FakeEither<_i5.Failure, _i6.CounterEntity>())) as _i4
          .Future<_i2.Either<_i5.Failure, _i6.CounterEntity>>);
}