import 'package:equatable/equatable.dart';
import 'package:tv/domain/entities/tv.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv/domain/usecases/get_tv_recommendations.dart';

part 'tv_recommendation_event.dart';
part 'tv_recommendation_state.dart';

class TVRecommendationBloc
    extends Bloc<TVRecommendationEvent, TVRecommendationState> {
  final GetTVRecommendations getTVRecommendations;

  TVRecommendationBloc(this.getTVRecommendations)
      : super(RecommendationTVEmpty()) {
    on<FetchTVRecommendation>((event, emit) async {
      emit(RecommendationTVLoading());
      final result = await getTVRecommendations.execute(event.id);
      result.fold(
        (failure) {
          emit(RecommendationTVError(failure.message));
        },
        (data) {
          emit(RecommendationTVHasData(data));
        },
      );
    });
  }
}
