import 'dart:convert';

import 'package:bloc_counter/core/error/exceptions.dart';
import 'package:bloc_counter/counter/data/models/counter_number_model.dart';
import 'package:bloc_counter/counter/domain/entities/counter.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class CounterNumberLocalDataSource {
  Future<CounterNumberModel> getLastNumber();
  Future<void> saveCacheNumber(CounterNumberModel numberToCache);
}

const CACHED_NUMBER = 'CACHED_NUMBER';

class CounterNumberLocalDataSourceImpl implements CounterNumberLocalDataSource {
  final SharedPreferences sharedPreferences;

  CounterNumberLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<void> saveCacheNumber(CounterNumberModel numberToCache) {
    return sharedPreferences.setString(
      CACHED_NUMBER,
      json.encode(numberToCache.toJson()),
    );
  }

  @override
  Future<CounterNumberModel> getLastNumber() {
    final jsonString = sharedPreferences.getString(CACHED_NUMBER);
    if (jsonString != null) {
      return Future.value(CounterNumberModel.fromJson(json.decode(jsonString)));
    } else {
      throw CacheException();
    }
  }
}
