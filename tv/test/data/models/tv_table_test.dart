import 'package:tv/data/models/tv_table.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final tTVTable = TVTable(
    id: 1,
    name: 'name',
    posterPath: 'posterPath',
    overview: 'overview',
  );

  test('should return a valid model when the JSON is correct', () async {
    final jsonMap = {
      "id": 1,
      "name": "name",
      "posterPath": "posterPath",
      "overview": "overview",
    };

    expect(tTVTable.toJson(), jsonMap);
  });
}
