import 'package:core/core.dart';
import 'package:movies/data/models/movie_detail_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movies/domain/entities/movie_detail.dart';

void main() {
  final tMovieDetailModel = MovieDetailResponse(
      adult: false,
      backdropPath: 'backdropPath',
      budget: 1000,
      genres: [GenreModel(id: 1, name: "Action")],
      homepage: "http://www.google.com/",
      id: 1,
      imdbId: "111",
      originalLanguage: "en",
      originalTitle: "originalTitle",
      overview: "overview",
      popularity: 1,
      posterPath: "posterPath",
      releaseDate: "releaseDate",
      revenue: 1000,
      runtime: 120,
      status: "status",
      tagline: "tagline",
      title: "title",
      video: false,
      voteAverage: 1,
      voteCount: 1);

  final testMovieDetail = MovieDetail(
    adult: false,
    backdropPath: 'backdropPath',
    genres: [Genre(id: 1, name: 'Action')],
    id: 1,
    originalTitle: 'originalTitle',
    overview: 'overview',
    posterPath: 'posterPath',
    releaseDate: 'releaseDate',
    runtime: 120,
    title: 'title',
    voteAverage: 1,
    voteCount: 1,
  );

  test('should be a subclass of MovieDetail entity', () async {
    final result = tMovieDetailModel.toEntity();
    expect(result, testMovieDetail);
  });

  test('should get Json property from class', () async {
    bool adult = false;
    String backdropPath = 'backdropPath';
    int budget = 1000;
    List<GenreModel> genres = [GenreModel(id: 1, name: "Action")];
    String homepage = "http =//www.google.com/";
    int id = 1;
    String imdbId = "111";
    String originalLanguage = "en";
    String originalTitle = "originalTitle";
    String overview = "overview";
    double popularity = 1;
    String posterPath = "posterPath";
    String releaseDate = "releaseDate";
    int revenue = 1000;
    int runtime = 120;
    String status = "status";
    String tagline = "tagline";
    String title = "title";
    bool video = false;
    double voteAverage = 1;
    int voteCount = 1;
    final result = MovieDetailResponse(
        adult: adult,
        backdropPath: backdropPath,
        budget: budget,
        genres: genres,
        homepage: homepage,
        id: id,
        imdbId: imdbId,
        originalLanguage: originalLanguage,
        originalTitle: originalTitle,
        overview: overview,
        popularity: popularity,
        posterPath: posterPath,
        releaseDate: releaseDate,
        revenue: revenue,
        runtime: runtime,
        status: status,
        tagline: tagline,
        title: title,
        video: video,
        voteAverage: voteAverage,
        voteCount: voteCount);
    expect(result.toJson(), {
      "adult": adult,
      "backdrop_path": backdropPath,
      "budget": 1000,
      "genres": [
        {"id": 1, "name": "Action"}
      ],
      "homepage": homepage,
      "id": id,
      "imdb_id": imdbId,
      "original_language": originalLanguage,
      "original_title": originalTitle,
      "overview": overview,
      "popularity": popularity,
      "poster_path": posterPath,
      "release_date": releaseDate,
      "revenue": revenue,
      "runtime": runtime,
      "status": status,
      "tagline": tagline,
      "title": title,
      "video": video,
      "vote_average": voteAverage,
      "vote_count": voteCount
    });
  });
}
