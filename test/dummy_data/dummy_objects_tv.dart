import 'package:core/domain/entities/genre.dart';
import 'package:tv/domain/entities/tv.dart';
import 'package:tv/domain/entities/tv_detail.dart';
import 'package:tv/data/models/tv_table.dart';

final testTV = TV(
  backdropPath: '/jMxwjnzjnTZz3ku6nJWvjg0T2nd.jpg',
  firstAirDate: '2016-03-30',
  genreIds: [18],
  id: 65227,
  name: 'The Path',
  originalName: 'The Path',
  overview:
      'The Path explores the unknown and mysterious world of the cult-like Meyerist Movement in upstate New York. At the center of the movement lies Eddie, a conflicted husband; Sarah, his devoted wife; and Cal, an ambitious leader. We follow each as they contend with deep issues involving relationships, faith, and power.',
  popularity: 11.737,
  posterPath: '/se3MZ1OVfIrZqFJkpm3kVnpkKpO.jpg',
  voteAverage: 6.6,
  voteCount: 115,
);

final testTVList = [testTV];

final testTVDetail = TVDetail(
  adult: false,
  backdropPath: 'backdropPath',
  episodeRunTime: [120],
  firstAirDate: 'firstAirDate',
  genres: [Genre(id: 1, name: 'Action')],
  id: 1,
  name: 'name',
  originalName: 'originalName',
  overview: 'overview',
  posterPath: 'posterPath',
  voteAverage: 1,
  voteCount: 1,
);

final testTVCache = TVTable(
  id: 65227,
  name: 'The Path',
  overview:
      'The Path explores the unknown and mysterious world of the cult-like Meyerist Movement in upstate New York. At the center of the movement lies Eddie, a conflicted husband; Sarah, his devoted wife; and Cal, an ambitious leader. We follow each as they contend with deep issues involving relationships, faith, and power.',
  posterPath: '/se3MZ1OVfIrZqFJkpm3kVnpkKpO.jpg',
);

final testTVCacheMap = {
  'id': 65227,
  'name': 'The Path',
  'overview':
      'The Path explores the unknown and mysterious world of the cult-like Meyerist Movement in upstate New York. At the center of the movement lies Eddie, a conflicted husband; Sarah, his devoted wife; and Cal, an ambitious leader. We follow each as they contend with deep issues involving relationships, faith, and power.',
  'posterPath': '/se3MZ1OVfIrZqFJkpm3kVnpkKpO.jpg',
};

final testTVFromCache = TV.watchlist(
  id: 65227,
  name: 'The Path',
  overview:
      'The Path explores the unknown and mysterious world of the cult-like Meyerist Movement in upstate New York. At the center of the movement lies Eddie, a conflicted husband; Sarah, his devoted wife; and Cal, an ambitious leader. We follow each as they contend with deep issues involving relationships, faith, and power.',
  posterPath: '/se3MZ1OVfIrZqFJkpm3kVnpkKpO.jpg',
);

final testWatchlistTV = TV.watchlist(
  id: 1,
  name: 'name',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testTVTable = TVTable(
  id: 1,
  name: 'name',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testTVMap = {
  'id': 1,
  'name': 'name',
  'overview': 'overview',
  'posterPath': 'posterPath',
};
