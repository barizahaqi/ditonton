part of 'tv_recommendation_bloc.dart';

abstract class TVRecommendationState extends Equatable {
  const TVRecommendationState();

  @override
  List<Object> get props => [];
}

class RecommendationTVEmpty extends TVRecommendationState {}

class RecommendationTVLoading extends TVRecommendationState {}

class RecommendationTVError extends TVRecommendationState {
  final String message;

  RecommendationTVError(this.message);

  @override
  List<Object> get props => [message];
}

class RecommendationTVHasData extends TVRecommendationState {
  final List<TV> result;

  RecommendationTVHasData(this.result);

  @override
  List<Object> get props => [result];
}
