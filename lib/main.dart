import 'package:core/core.dart';
import 'package:about/about.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/movies.dart';
import 'package:tv/tv.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ditonton/injection.dart' as di;

void main() {
  di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        BlocProvider(
          create: (_) => di.locator<MovieListBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<MovieDetailBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<MovieSearchBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TopRatedMovieBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<PopularMovieBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<MovieWatchlistBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TVListBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TVDetailBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TVSearchBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TopRatedTVBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<NowPlayingTVBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<PopularTVBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TVWatchlistBloc>(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData.dark().copyWith(
          colorScheme: kColorScheme,
          primaryColor: kRichBlack,
          scaffoldBackgroundColor: kRichBlack,
          textTheme: kTextTheme,
        ),
        initialRoute: HomeMoviePage.ROUTE_NAME,
        navigatorObservers: [routeObserver],
        onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {
            case HomeMoviePage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => HomeMoviePage());
            case PopularMoviesPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => PopularMoviesPage());
            case TopRatedMoviesPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => TopRatedMoviesPage());
            case MovieDetailPage.ROUTE_NAME:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => MovieDetailPage(id: id),
                settings: settings,
              );

            case SearchMoviesPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => SearchMoviesPage());
            case WatchlistMoviesPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => WatchlistMoviesPage());

            case PopularTVPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => PopularTVPage());
            case TopRatedTVPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => TopRatedTVPage());
            case NowPlayingTVPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => NowPlayingTVPage());
            case TVDetailPage.ROUTE_NAME:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => TVDetailPage(id: id),
                settings: settings,
              );
            case WatchlistTVPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => WatchlistTVPage());
            case TVPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => TVPage());
            case SearchTVPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => SearchTVPage());
            case AboutPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => AboutPage());
            default:
              return MaterialPageRoute(builder: (_) {
                return Scaffold(
                  body: Center(
                    child: Text('Page not found :('),
                  ),
                );
              });
          }
        },
      ),
    );
  }
}
