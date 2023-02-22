part of 'movie_recommendation_bloc.dart';

abstract class MovieRecommendationState extends Equatable {
  const MovieRecommendationState();

  @override
  List<Object> get props => [];
}

class RecommendationMovieEmpty extends MovieRecommendationState {}

class RecommendationMovieLoading extends MovieRecommendationState {}

class RecommendationMovieError extends MovieRecommendationState {
  final String message;

  RecommendationMovieError(this.message);

  @override
  List<Object> get props => [message];
}

class RecommendationMovieHasData extends MovieRecommendationState {
  final List<Movie> result;

  RecommendationMovieHasData(this.result);

  @override
  List<Object> get props => [result];
}
