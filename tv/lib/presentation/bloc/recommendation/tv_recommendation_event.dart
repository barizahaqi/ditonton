part of 'tv_recommendation_bloc.dart';

abstract class TVRecommendationEvent extends Equatable {}

class FetchTVRecommendation extends TVRecommendationEvent {
  final int id;

  FetchTVRecommendation(this.id);

  @override
  List<Object> get props => [id];
}
