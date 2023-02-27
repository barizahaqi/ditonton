part of 'movie_detail_bloc.dart';

class MovieDetailState extends Equatable {
  final MovieDetail? movieDetail;
  final RequestState movieDetailState;
  final String message;
  final String watchlistMessage;
  final bool isAddedToWatchlist;

  const MovieDetailState({
    required this.movieDetail,
    required this.movieDetailState,
    required this.message,
    required this.watchlistMessage,
    required this.isAddedToWatchlist,
  });

  @override
  List<Object?> get props {
    return [
      movieDetail,
      movieDetailState,
      message,
      watchlistMessage,
      isAddedToWatchlist,
    ];
  }

  MovieDetailState insert({
    MovieDetail? movieDetail,
    RequestState? movieDetailState,
    String? message,
    String? watchlistMessage,
    bool? isAddedToWatchlist,
  }) {
    return MovieDetailState(
      movieDetail: movieDetail ?? this.movieDetail,
      movieDetailState: movieDetailState ?? this.movieDetailState,
      message: message ?? this.message,
      watchlistMessage: watchlistMessage ?? this.watchlistMessage,
      isAddedToWatchlist: isAddedToWatchlist ?? this.isAddedToWatchlist,
    );
  }

  factory MovieDetailState.initial() {
    return const MovieDetailState(
      movieDetail: null,
      movieDetailState: RequestState.Empty,
      message: '',
      watchlistMessage: '',
      isAddedToWatchlist: false,
    );
  }
}
