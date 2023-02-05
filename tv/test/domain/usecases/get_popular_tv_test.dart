import 'package:dartz/dartz.dart';
import 'package:tv/domain/entities/tv.dart';
import 'package:tv/domain/usecases/get_popular_tv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper_tv.mocks.dart';

void main() {
  late GetPopularTV usecase;
  late MockTVRepository mockTVRpository;

  setUp(() {
    mockTVRpository = MockTVRepository();
    usecase = GetPopularTV(mockTVRpository);
  });

  final tTV = <TV>[];

  group('GetPopularTV Tests', () {
    group('execute', () {
      test(
          'should get list of TV from the repository when execute function is called',
          () async {
        // arrange
        when(mockTVRpository.getPopularTV())
            .thenAnswer((_) async => Right(tTV));
        // act
        final result = await usecase.execute();
        // assert
        expect(result, Right(tTV));
      });
    });
  });
}
