import 'package:tv/presentation/bloc/popular/popular_tv_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv/presentation/widgets/tv_card_list.dart';
import 'package:flutter/material.dart';

class PopularTVPage extends StatefulWidget {
  static const ROUTE_NAME = '/popular-tv';

  @override
  _PopulartvsPageState createState() => _PopulartvsPageState();
}

class _PopulartvsPageState extends State<PopularTVPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<PopularTVBloc>().add(FetchPopularTV());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Popular TV'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<PopularTVBloc, PopularTVState>(
            builder: (context, state) {
          if (state is PopularLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is PopularTVHasData) {
            return ListView.builder(
              itemBuilder: (context, index) {
                final tv = state.popularResult[index];
                return TVCard(tv);
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
