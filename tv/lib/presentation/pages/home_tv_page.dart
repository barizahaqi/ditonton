import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/utils/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv/domain/entities/tv.dart';
import 'package:about/presentation/pages/about_page.dart';
import 'package:movies/presentation/pages/home_movie_page.dart';
import 'package:tv/presentation/pages/now_playing_tv_page.dart';
import 'package:tv/presentation/pages/tv_detail_page.dart';
import 'package:tv/presentation/pages/popular_tv_page.dart';
import 'package:movies/presentation/pages/watchlist_movie_page.dart';
import 'package:tv/presentation/pages/watchlist_tv_page.dart';
import 'package:tv/presentation/pages/search_tv_page.dart';
import 'package:tv/presentation/pages/top_rated_tv_page.dart';
import 'package:tv/presentation/bloc/list/tv_list_bloc.dart';
import 'package:flutter/material.dart';

class TVPage extends StatefulWidget {
  static const ROUTE_NAME = '/tv-page';

  @override
  _TVPageState createState() => _TVPageState();
}

class _TVPageState extends State<TVPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<TVListBloc>().add(FetchTVNowPlaying());
      context.read<TVListBloc>().add(FetchTVTopRated());
      context.read<TVListBloc>().add(FetchTVPopular());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: [
            const UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage('assets/circle-g.png'),
              ),
              accountName: Text('Ditonton'),
              accountEmail: Text('ditonton@dicoding.com'),
            ),
            ListTile(
              leading: const Icon(Icons.movie),
              title: const Text('Movies'),
              onTap: () {
                Navigator.pushReplacementNamed(
                    context, HomeMoviePage.ROUTE_NAME);
              },
            ),
            ListTile(
              leading: const Icon(Icons.movie_filter),
              title: const Text('Watchlist Movies'),
              onTap: () {
                Navigator.pushNamed(context, WatchlistMoviesPage.ROUTE_NAME);
              },
            ),
            ListTile(
              leading: const Icon(Icons.tv),
              title: const Text('TV'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.live_tv_rounded),
              title: const Text('Watchlist TV'),
              onTap: () {
                Navigator.pushNamed(context, WatchlistTVPage.ROUTE_NAME);
              },
            ),
            ListTile(
              onTap: () {
                Navigator.pushNamed(context, AboutPage.ROUTE_NAME);
              },
              leading: const Icon(Icons.info_outline),
              title: const Text('About'),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: const Text('TV Series'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, SearchTVPage.ROUTE_NAME);
            },
            icon: const Icon(Icons.search),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSubHeading(
                title: 'Now Playing',
                onTap: () =>
                    Navigator.pushNamed(context, NowPlayingTVPage.ROUTE_NAME),
              ),
              BlocBuilder<TVListBloc, TVListState>(builder: (context, state) {
                if (state is ListLoading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is ListNowPlayingTVHasData) {
                  return TVList(state.nowPlayingResult);
                } else if (state is ListError) {
                  return Center(
                    child: Text(state.message),
                  );
                } else {
                  return Container();
                }
              }),
              _buildSubHeading(
                title: 'Popular',
                onTap: () =>
                    Navigator.pushNamed(context, PopularTVPage.ROUTE_NAME),
              ),
              BlocBuilder<TVListBloc, TVListState>(builder: (context, state) {
                if (state is ListLoading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is ListPopularTVHasData) {
                  return TVList(state.popularResult);
                } else if (state is ListError) {
                  return Center(
                    child: Text(state.message),
                  );
                } else {
                  return Container();
                }
              }),
              _buildSubHeading(
                title: 'Top Rated',
                onTap: () =>
                    Navigator.pushNamed(context, TopRatedTVPage.ROUTE_NAME),
              ),
              BlocBuilder<TVListBloc, TVListState>(builder: (context, state) {
                if (state is ListLoading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is ListTopRatedTVHasData) {
                  return TVList(state.topRatedResult);
                } else if (state is ListError) {
                  return Center(
                    child: Text(state.message),
                  );
                } else {
                  return Container();
                }
              }),
            ],
          ),
        ),
      ),
    );
  }

  Row _buildSubHeading({required String title, required Function() onTap}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: kHeading6,
        ),
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [Text('See More'), Icon(Icons.arrow_forward_ios)],
            ),
          ),
        ),
      ],
    );
  }
}

class TVList extends StatelessWidget {
  final List<TV> tvs;

  TVList(this.tvs);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final tv = tvs[index];
          return Container(
            padding: const EdgeInsets.all(8),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  TVDetailPage.ROUTE_NAME,
                  arguments: tv.id,
                );
              },
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(16)),
                child: CachedNetworkImage(
                  imageUrl: '$BASE_IMAGE_URL${tv.posterPath}',
                  placeholder: (context, url) => Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
            ),
          );
        },
        itemCount: tvs.length,
      ),
    );
  }
}
