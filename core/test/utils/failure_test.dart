import 'package:core/domain/entities/genre.dart';
import 'package:dartz/dartz.dart';
import 'package:tv/domain/entities/tv.dart';
import 'package:tv/domain/usecases/get_now_playing_tv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:core/utils/failure.dart';

void main() {
  late SSLFailure sslFailure;
  late ServerFailure serverFailure;
  late DatabaseFailure databaseFailure;
  late CacheFailure cacheFailure;
  late ConnectionFailure connectionFailure;

  setUp(() {
    sslFailure = SSLFailure("Error");
    serverFailure = ServerFailure("Error");
    databaseFailure = DatabaseFailure("Error");
    cacheFailure = CacheFailure("Error");
    connectionFailure = ConnectionFailure("Error");
  });

  test('should get property message from SSLFailure', () {
    String message = 'Error';

    expect(sslFailure.props, [message]);
  });
  test('should get property message from ServerFailure', () {
    String message = 'Error';

    expect(serverFailure.props, [message]);
  });
  test('should get property message from DatabaseFailure', () {
    String message = 'Error';

    expect(databaseFailure.props, [message]);
  });
  test('should get property message from CacheFailure', () {
    String message = 'Error';

    expect(cacheFailure.props, [message]);
  });
  test('should get property message from ConnectionFailure', () {
    String message = 'Error';

    expect(connectionFailure.props, [message]);
  });
}
