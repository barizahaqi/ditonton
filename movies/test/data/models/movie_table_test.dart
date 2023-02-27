import 'package:movies/data/models/movie_table.dart';
import 'package:movies/domain/entities/movie.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final tMovieTable = MovieTable(
    id: 1,
    title: 'title',
    posterPath: 'posterPath',
    overview: 'overview',
  );

  test('should return a valid model when the JSON is correct', () async {
    final jsonMap = {
      "id": 1,
      "title": "title",
      "posterPath": "posterPath",
      "overview": "overview",
    };

    expect(tMovieTable.toJson(), jsonMap);
  });
}
