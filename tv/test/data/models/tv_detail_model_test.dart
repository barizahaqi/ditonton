import 'package:core/core.dart';
import 'package:tv/data/models/tv_detail_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tv/domain/entities/tv_detail.dart';

void main() {
  final tTVDetailModel = TVDetailResponse(
      adult: false,
      backdropPath: 'backdropPath',
      episodeRunTime: [1],
      firstAirDate: 'firstAirDate',
      genres: [GenreModel(id: 1, name: "Action")],
      homepage: "http://www.google.com/",
      id: 1,
      lastAirDate: 'lastAirDate',
      name: "name",
      numberOfEpisodes: 1,
      numberOfSeasons: 1,
      originalLanguage: "en",
      originalName: "originalName",
      overview: "overview",
      popularity: 1,
      posterPath: "posterPath",
      status: "status",
      tagline: "tagline",
      voteAverage: 1,
      voteCount: 1);

  final testTVDetail = TVDetail(
    adult: false,
    backdropPath: 'backdropPath',
    episodeRunTime: [1],
    firstAirDate: 'firstAirDate',
    genres: [Genre(id: 1, name: 'Action')],
    id: 1,
    name: "name",
    originalName: "originalName",
    overview: "overview",
    posterPath: "posterPath",
    voteAverage: 1,
    voteCount: 1,
  );

  test('should be a subclass of TVDetail entity', () async {
    final result = tTVDetailModel.toEntity();
    expect(result, testTVDetail);
  });

  test('should get Json property from class', () async {
    bool adult = false;
    String backdropPath = 'backdropPath';
    List<int> episodeRunTime = [1];
    String firstAirDate = 'firstAirDate';
    List<GenreModel> genres = [GenreModel(id: 1, name: "Action")];
    String homepage = "http =//www.google.com/";
    int id = 1;
    String lastAirDate = 'lastAirDate';
    String name = "name";
    int numberOfEpisodes = 1;
    int numberOfSeasons = 1;
    String originalLanguage = "en";
    String originalName = "originalName";
    String overview = "overview";
    double popularity = 1;
    String posterPath = "posterPath";
    String releaseDate = "releaseDate";
    String status = "status";
    String tagline = "tagline";
    double voteAverage = 1;
    int voteCount = 1;
    final result = TVDetailResponse(
        adult: adult,
        backdropPath: backdropPath,
        episodeRunTime: episodeRunTime,
        firstAirDate: firstAirDate,
        genres: genres,
        homepage: homepage,
        id: 1,
        lastAirDate: lastAirDate,
        name: name,
        numberOfEpisodes: numberOfEpisodes,
        numberOfSeasons: numberOfSeasons,
        originalLanguage: originalLanguage,
        originalName: originalName,
        overview: overview,
        popularity: popularity,
        posterPath: posterPath,
        status: status,
        tagline: tagline,
        voteAverage: voteAverage,
        voteCount: voteCount);
    expect(result.toJson(), {
      "adult": adult,
      "backdrop_path": backdropPath,
      "episodeRunTime": episodeRunTime,
      "first_air_date": firstAirDate,
      "genres": [
        {"id": 1, "name": "Action"}
      ],
      "homepage": homepage,
      "id": id,
      "last_air_date": lastAirDate,
      "name": name,
      "number_of_episodes": numberOfEpisodes,
      "number_of_seasons": numberOfSeasons,
      "original_language": originalLanguage,
      "original_name": originalName,
      "overview": overview,
      "popularity": popularity,
      "poster_path": posterPath,
      "status": status,
      "tagline": tagline,
      "vote_average": voteAverage,
      "vote_count": voteCount,
    });
  });
}
