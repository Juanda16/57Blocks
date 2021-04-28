import 'dart:convert';

import 'package:bloc_counter/core/error/exceptions.dart';
import 'package:bloc_counter/counter/data/models/counter_number_model.dart';
import 'package:http/http.dart' as http;

abstract class CounterNumberRemoteDataSource {
  /// Calls the https://csrng.net/csrng/csrng.php?min=0&max=100 endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<CounterNumberModel> getRemoteRandomNumber();
}

class CounterNumberRemoteDataSourceImpl
    implements CounterNumberRemoteDataSource {
  static const String url = 'https://csrng.net/csrng/csrng.php?min=0&max=100';
  final http.Client client;

  CounterNumberRemoteDataSourceImpl({required this.client});

  @override
  Future<CounterNumberModel> getRemoteRandomNumber() {
    return _getRandomNumberFromUrl(url);
  }

  Future<CounterNumberModel> _getRandomNumberFromUrl(String url) async {
    final uri = Uri.parse(url);
    final response = await client.get(uri
        // headers: {
        //   'Content-Type': 'application/json',
        // },
        );

    print(response.body);

    if (response.statusCode == 200) {
      return CounterNumberModel.fromJson(json.decode(response.body)[0]);
    } else
      throw ServerException();
  }
}

//[{"status":"success","min":0,"max":100,"random":19}]
