import 'package:core/domain/entities/genre.dart';
import 'package:dartz/dartz.dart';
import 'package:tv/domain/entities/tv.dart';
import 'package:tv/domain/usecases/get_now_playing_tv.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late Genre genre;

  setUp(() {
    genre = Genre(id: 1, name: 'film');
  });

  test('should get property id and name from the genre', () {
    int id = 1;
    String name = 'film';

    expect(genre.props, [id, name]);
  });
}
