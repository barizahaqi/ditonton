part of 'movie_recommendation_bloc.dart';

abstract class MovieRecommendationEvent extends Equatable {}

class FetchMovieRecommendation extends MovieRecommendationEvent {
  final int id;

  FetchMovieRecommendation(this.id);

  @override
  List<Object> get props => [id];
}
