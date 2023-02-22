import 'package:tv/presentation/bloc/top_rated/top_rated_tv_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv/presentation/widgets/tv_card_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TopRatedTVPage extends StatefulWidget {
  static const ROUTE_NAME = '/top-rated-tv';

  @override
  _TopRatedTVPageState createState() => _TopRatedTVPageState();
}

class _TopRatedTVPageState extends State<TopRatedTVPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<TopRatedTVBloc>().add(FetchTopRatedTV());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Top Rated tv'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<TopRatedTVBloc, TopRatedTVState>(
            builder: (context, state) {
          if (state is TopRatedLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is TopRatedTVHasData) {
            return ListView.builder(
              itemBuilder: (context, index) {
                final tv = state.topRatedResult[index];
                return TVCard(tv);
              },
              itemCount: state.topRatedResult.length,
            );
          } else if (state is TopRatedError) {
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
