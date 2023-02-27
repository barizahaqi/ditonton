import 'package:movies/presentation/bloc/top_rated/top_rated_movie_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/presentation/widgets/movie_card_list.dart';
import 'package:flutter/material.dart';

class TopRatedMoviesPage extends StatefulWidget {
  static const ROUTE_NAME = '/top-rated-movie';

  @override
  _TopRatedMoviesPageState createState() => _TopRatedMoviesPageState();
}

class _TopRatedMoviesPageState extends State<TopRatedMoviesPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<TopRatedMovieBloc>().add(FetchTopRatedMovie());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Top Rated Movies'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<TopRatedMovieBloc, TopRatedMovieState>(
            builder: (context, state) {
          if (state is TopRatedMovieLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is TopRatedMoviesHasData) {
            return ListView.builder(
              itemBuilder: (context, index) {
                final movie = state.topRatedResult[index];
                return MovieCard(movie);
              },
              itemCount: state.topRatedResult.length,
            );
          } else if (state is TopRatedMovieError) {
            return Center(
              child: Text(state.message),
            );
          } else {
            return Container();
          }
        }),
      ),
    );
  }
}
