import 'package:movies/presentation/bloc/popular/popular_movie_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/presentation/widgets/movie_card_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PopularMoviesPage extends StatefulWidget {
  static const ROUTE_NAME = '/popular-movie';

  @override
  _PopularMoviesPageState createState() => _PopularMoviesPageState();
}

class _PopularMoviesPageState extends State<PopularMoviesPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<PopularMovieBloc>().add(FetchPopularMovie());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Popular Movies'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<PopularMovieBloc, PopularMovieState>(
            builder: (context, state) {
          if (state is PopularLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is PopularMoviesHasData) {
            return ListView.builder(
              itemBuilder: (context, index) {
                final movie = state.popularResult[index];
                return MovieCard(movie);
              },
              itemCount: state.popularResult.length,
            );
          } else if (state is PopularError) {
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
