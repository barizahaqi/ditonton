import 'package:movies/domain/repositories/movie_repository.dart';

class GetWatchListStatusMovies {
  final MovieRepository repository;

  GetWatchListStatusMovies(this.repository);

  Future<bool> execute(int id) async {
    return repository.isAddedToWatchlist(id);
  }
}
