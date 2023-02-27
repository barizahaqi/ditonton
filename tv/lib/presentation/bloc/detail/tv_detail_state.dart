part of 'tv_detail_bloc.dart';

class TVDetailState extends Equatable {
  final TVDetail? tvDetail;
  final RequestState tvDetailState;
  final String message;
  final String watchlistMessage;
  final bool isAddedToWatchlist;

  const TVDetailState({
    required this.tvDetail,
    required this.tvDetailState,
    required this.message,
    required this.watchlistMessage,
    required this.isAddedToWatchlist,
  });

  @override
  List<Object?> get props {
    return [
      tvDetail,
      tvDetailState,
      message,
      watchlistMessage,
      isAddedToWatchlist,
    ];
  }

  TVDetailState insert({
    TVDetail? tvDetail,
    RequestState? tvDetailState,
    String? message,
    String? watchlistMessage,
    bool? isAddedToWatchlist,
  }) {
    return TVDetailState(
      tvDetail: tvDetail ?? this.tvDetail,
      tvDetailState: tvDetailState ?? this.tvDetailState,
      message: message ?? this.message,
      watchlistMessage: watchlistMessage ?? this.watchlistMessage,
      isAddedToWatchlist: isAddedToWatchlist ?? this.isAddedToWatchlist,
    );
  }

  factory TVDetailState.initial() {
    return const TVDetailState(
      tvDetail: null,
      tvDetailState: RequestState.Empty,
      message: '',
      watchlistMessage: '',
      isAddedToWatchlist: false,
    );
  }
}
