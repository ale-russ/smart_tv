
// ignore_for_file: unused_import

import 'package:smart_tv/features/movie_list/widgets/tv.dart';

import '../features/authentication/view/login_page.dart';
import '../features/movie_detail/view/movie_detail.dart';
import 'package:auto_route/auto_route.dart';
import '../features/movie_list/view/Movies.dart';
import '../features/movie_list/widgets/Movie_card.dart';
import '../features/movie_list/widgets/description.dart';
import '../features/movie_list/widgets/movies_tile.dart';
import '../features/movie_list/widgets/toprated.dart';
import '../features/movie_list/widgets/trending.dart';
import '../features/profile/screen/profile_page.dart';
import '../features/search/search.dart';


@MaterialAutoRouter(
  replaceInRouteName: 'Page, Route',
  routes: <AutoRoute>[
    AutoRoute(path: '/', page: LoginPage, initial: true),
    AutoRoute(path: '/homescreen', page: MoviesPage),
    AutoRoute(path: '/home', page: MovieDetail),
    AutoRoute(path: '/search', page: SearchPage),
    //AutoRoute(path: '/library', page: LibraryPage),
    AutoRoute(path: '/comingsoon', page: ComingSoon),
    AutoRoute(path: '/Profile', page: ProfilePage),
    AutoRoute(path: '/movies', page: MoviesPage),
    AutoRoute(path: '/toprated', page: TopRated),
    AutoRoute(path: '/trending', page: TrendingMovies),
    AutoRoute(path: '/moviecard', page: Movie_card),
    AutoRoute(path: '/description', page: Description),
  ],
)
class $AppRouter{} 
