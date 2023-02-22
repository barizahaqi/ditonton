import 'package:tv/presentation/bloc/now_playing/now_playing_tv_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv/presentation/widgets/tv_card_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NowPlayingTVPage extends StatefulWidget {
  static const ROUTE_NAME = '/now-playing-tv';

  @override
  _NowPlayingTVPageState createState() => _NowPlayingTVPageState();
}

class _NowPlayingTVPageState extends State<NowPlayingTVPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<NowPlayingTVBloc>().add(FetchNowPlayingTV());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Now Playing TV'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<NowPlayingTVBloc, NowPlayingTVState>(
            builder: (context, state) {
          if (state is NowPlayingTVLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is NowPlayingTVHasData) {
            return ListView.builder(
              itemBuilder: (context, index) {
                final tv = state.nowPlayingResult[index];
                return TVCard(tv);
              },
              itemCount: state.nowPlayingResult.length,
            );
          } else if (state is NowPlayingTVError) {
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
