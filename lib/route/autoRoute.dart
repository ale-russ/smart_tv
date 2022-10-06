// import 'package:flutter/cupertino.dart';
// import 'package:smart_tv/features/profile/screen/profile_page.dart';
// import 'package:smart_tv/features/search/search.dart';

// @MaterialAutoRouter(
//   replaceInRouteName: 'Page,Route',
//   routes: <AutoRoute>[
//     AutoRoute(page: Page, initial: true),
//     AutoRoute(path: '/login', page: Login),
//     AutoRoute(path: '/home', page: Home),
//     AutoRoute(path: '/comingsoon', page: Comingsoon),
//     AutoRoute(path: '/search', page: Search),
//     AutoRoute(path: '/library', page: Library),
//     AutoRoute(path: '/Profile', page: Profile,
    
//   ]
// ),
// class $AppRouter {}

// class AppRouter extends AutoRouters {
//   AppRouter([GlobalKey<NavigatorState>? navigatorKey])
//       : super(navigatorKey);

//   @override
//   final Map<String, PageFactory> pagesMap = {
//     Splash.name: (routeData) {
//       final args =
//           routeData.argsAs<SplashArgs>(orElse: () => const SplashArgs());
//       return MaterialPageX<dynamic>(
//           routeData: routeData, child: Splash(key: args.key));
//     },
//     LoginRoute.name: (routeData) {
//       return MaterialPageX<dynamic>(
//           routeData: routeData, child: LoginPage());
//     },
//     OneSignupRoute.name: (routeData) {
//       final args = routeData.argsAs<OneSignupRouteArgs>(
//           orElse: () => const OneSignupRouteArgs());
//       return MaterialPageX<dynamic>(
//           routeData: routeData, child:HomePage(key: args.key));
//     },
//     CategoryRoute.name: (routeData) {
//       final args = routeData.argsAs<CategoryRouteArgs>(
//           orElse: () => const CategoryRouteArgs());
//       return MaterialPageX<dynamic>(
//           routeData: routeData, child: SearchPage(key: args.key));
//     },
//     LanguageChoices.name: (routeData) {
//       final args = routeData.argsAs<LanguageChoicesArgs>();
//       return _i17.MaterialPageX<dynamic>(
//           routeData: routeData,
//           child: _i5.LanguageChoices(key: args.key, courses: args.courses));
//     },
//     ChooseTypeRoute.name: (routeData) {
//       final args = routeData.argsAs<ChooseTypeRouteArgs>();
//       return _i17.MaterialPageX<dynamic>(
//           routeData: routeData,
//           child: _i6.ChooseTypePage(
//               key: args.key,
//               icon: args.icon,
//               path: args.path,
//               ptype: args.ptype,
//               ftype: args.ftype));
//     },
//     QuestionsScreen.name: (routeData) {
//       final args = routeData.argsAs<QuestionsScreenArgs>();
//       return _i17.MaterialPageX<dynamic>(
//           routeData: routeData,
//           child: _i7.QuestionsScreen(
//               key: args.key,
//               icon: args.icon,
//               path: args.path,
//               isFinal: args.isFinal,
//               ptype: args.ptype,
//               ftype: args.ftype));
//     },
//     FinalScore.name: (routeData) {
//       final args = routeData.argsAs<FinalScoreArgs>();
//       return _i17.MaterialPageX<dynamic>(
//           routeData: routeData,
//           child: _i8.FinalScore(
//               key: args.key,
//               outOf: args.outOf,
//               score: args.score,
//               optionList: args.optionList));
//     },
//     ReviewScreen.name: (routeData) {
//       final args = routeData.argsAs<ReviewScreenArgs>(
//           orElse: () => const ReviewScreenArgs());
//       return _i17.MaterialPageX<dynamic>(
//           routeData: routeData, child: _i9.ReviewScreen(key: args.key));
//     },
//     ProfileScreen.name: (routeData) {
//       final args = routeData.argsAs<ProfileScreenArgs>(
//           orElse: () => const ProfileScreenArgs());
//       return _i17.MaterialPageX<dynamic>(
//           routeData: routeData, child: _i10.ProfileScreen(key: args.key));
//     },
//     UserDetailsScreen.name: (routeData) {
//       return _i17.MaterialPageX<dynamic>(
//           routeData: routeData, child: const _i11.UserDetailsScreen());
//     },
//     EditProfileScreen.name: (routeData) {
//       final args = routeData.argsAs<EditProfileScreenArgs>(
//           orElse: () => const EditProfileScreenArgs());
//       return _i17.MaterialPageX<dynamic>(
//           routeData: routeData, child: _i12.EditProfileScreen(key: args.key));
//     },
//     MyScoresScreen.name: (routeData) {
//       final args = routeData.argsAs<MyScoresScreenArgs>(
//           orElse: () => const MyScoresScreenArgs());
//       return _i17.MaterialPageX<dynamic>(
//           routeData: routeData, child: _i13.MyScoresScreen(key: args.key));
//     },
//     UsersListRoute.name: (routeData) {
//       return _i17.MaterialPageX<dynamic>(
//           routeData: routeData, child: const _i14.UsersListPage());
//     },
//     DashboardRoute.name: (routeData) {
//       return _i17.MaterialPageX<dynamic>(
//           routeData: routeData, child: const _i15.DashboardPage());
//     },
//     AdminLanguage.name: (routeData) {
//       return _i17.MaterialPageX<dynamic>(
//           routeData: routeData, child: const _i16.AdminLanguage());
//     }
//   };

//   @override
//   List<_i17.RouteConfig> get routes => [
//         _i17.RouteConfig(Splash.name, path: '/'),
//         _i17.RouteConfig(LoginRoute.name, path: '/login'),
//         _i17.RouteConfig(HomeRoute.name, path: '/Home'),
//         _i17.RouteConfig(CategoryRoute.name, path: '/category'),
//         _i17.RouteConfig(LanguageChoices.name, path: '/language-choices'),
//         _i17.RouteConfig(ChooseTypeRoute.name, path: '/choose-type'),
//         _i17.RouteConfig(QuestionsScreen.name, path: '/questions'),
//         _i17.RouteConfig(FinalScore.name, path: '/finalScore'),
//         _i17.RouteConfig(ReviewScreen.name, path: '/review_screen'),
//         _i17.RouteConfig(ProfileScreen.name, path: '/profile'),
//         _i17.RouteConfig(UserDetailsScreen.name, path: '/personal_details'),
//         _i17.RouteConfig(EditProfileScreen.name, path: '/edit_profile'),
//         _i17.RouteConfig(MyScoresScreen.name, path: '/my_scores'),
//         _i17.RouteConfig(UsersListRoute.name, path: '/users'),
//         _i17.RouteConfig(DashboardRoute.name, path: '/dahboard'),
//         _i17.RouteConfig(AdminLanguage.name, path: '/adminLanguages')
//       ];
// }

// /// generated route for
// /// [_i1.Splash]
// class Splash extends _i17.PageRouteInfo<SplashArgs> {
//   Splash({_i18.Key? key})
//       : super(Splash.name, path: '/', args: SplashArgs(key: key));

//   static const String name = 'Splash';
// }

// class SplashArgs {
//   const SplashArgs({this.key});

//   final _i18.Key? key;

//   @override
//   String toString() {
//     return 'SplashArgs{key: $key}';
//   }
// }

// /// generated route for
// /// [_i2.LoginPage]
// class LoginRoute extends _i17.PageRouteInfo<void> {
//   const LoginRoute() : super(LoginRoute.name, path: '/login');

//   static const String name = 'LoginRoute';
// }

// /// generated route for
// /// [_i3.OneSignupPage]
// class OneSignupRoute extends _i17.PageRouteInfo<OneSignupRouteArgs> {
//   OneSignupRoute({_i18.Key? key})
//       : super(OneSignupRoute.name,
//             path: '/signup', args: OneSignupRouteArgs(key: key));

//   static const String name = 'OneSignupRoute';
// }

// class OneSignupRouteArgs {
//   const OneSignupRouteArgs({this.key});

//   final _i18.Key? key;

//   @override
//   String toString() {
//     return 'OneSignupRouteArgs{key: $key}';
//   }
// }

// /// generated route for
// /// [_i4.CategoryPage]
// class CategoryRoute extends _i17.PageRouteInfo<CategoryRouteArgs> {
//   CategoryRoute({_i18.Key? key})
//       : super(CategoryRoute.name,
//             path: '/category', args: CategoryRouteArgs(key: key));

//   static const String name = 'CategoryRoute';
// }

// class CategoryRouteArgs {
//   const CategoryRouteArgs({this.key});

//   final _i18.Key? key;

//   @override
//   String toString() {
//     return 'CategoryRouteArgs{key: $key}';
//   }
// }

// /// generated route for
// /// [_i5.LanguageChoices]
// class LanguageChoices extends _i17.PageRouteInfo<LanguageChoicesArgs> {
//   LanguageChoices({_i18.Key? key, required dynamic courses})
//       : super(LanguageChoices.name,
//             path: '/language-choices',
//             args: LanguageChoicesArgs(key: key, courses: courses));

//   static const String name = 'LanguageChoices';
// }

// class LanguageChoicesArgs {
//   const LanguageChoicesArgs({this.key, required this.courses});

//   final _i18.Key? key;

//   final dynamic courses;

//   @override
//   String toString() {
//     return 'LanguageChoicesArgs{key: $key, courses: $courses}';
//   }
// }

// /// generated route for
// /// [_i6.ChooseTypePage]
// class ChooseTypeRoute extends _i17.PageRouteInfo<ChooseTypeRouteArgs> {
//   ChooseTypeRoute(
//       {_i18.Key? key,
//       required dynamic icon,
//       required String path,
//       String? ptype,
//       String? ftype})
//       : super(ChooseTypeRoute.name,
//             path: '/choose-type',
//             args: ChooseTypeRouteArgs(
//                 key: key, icon: icon, path: path, ptype: ptype, ftype: ftype));

//   static const String name = 'ChooseTypeRoute';
// }

// class ChooseTypeRouteArgs {
//   const ChooseTypeRouteArgs(
//       {this.key,
//       required this.icon,
//       required this.path,
//       this.ptype,
//       this.ftype});

//   final _i18.Key? key;

//   final dynamic icon;

//   final String path;

//   final String? ptype;

//   final String? ftype;

//   @override
//   String toString() {
//     return 'ChooseTypeRouteArgs{key: $key, icon: $icon, path: $path, ptype: $ptype, ftype: $ftype}';
//   }
// }

// /// generated route for
// /// [_i7.QuestionsScreen]
// class QuestionsScreen extends _i17.PageRouteInfo<QuestionsScreenArgs> {
//   QuestionsScreen(
//       {_i18.Key? key,
//       required dynamic icon,
//       required String path,
//       required bool isFinal,
//       String? ptype,
//       String? ftype})
//       : super(QuestionsScreen.name,
//             path: '/questions',
//             args: QuestionsScreenArgs(
//                 key: key,
//                 icon: icon,
//                 path: path,
//                 isFinal: isFinal,
//                 ptype: ptype,
//                 ftype: ftype));

//   static const String name = 'QuestionsScreen';
// }

// class QuestionsScreenArgs {
//   const QuestionsScreenArgs(
//       {this.key,
//       required this.icon,
//       required this.path,
//       required this.isFinal,
//       this.ptype,
//       this.ftype});

//   final _i18.Key? key;

//   final dynamic icon;

//   final String path;

//   final bool isFinal;

//   final String? ptype;

//   final String? ftype;

//   @override
//   String toString() {
//     return 'QuestionsScreenArgs{key: $key, icon: $icon, path: $path, isFinal: $isFinal, ptype: $ptype, ftype: $ftype}';
//   }
// }

// /// generated route for
// /// [_i8.FinalScore]
// class FinalScore extends _i17.PageRouteInfo<FinalScoreArgs> {
//   FinalScore(
//       {_i18.Key? key, required int outOf, required int score, int? optionList})
//       : super(FinalScore.name,
//             path: '/finalScore',
//             args: FinalScoreArgs(
//                 key: key, outOf: outOf, score: score, optionList: optionList));

//   static const String name = 'FinalScore';
// }

// class FinalScoreArgs {
//   const FinalScoreArgs(
//       {this.key, required this.outOf, required this.score, this.optionList});

//   final _i18.Key? key;

//   final int outOf;

//   final int score;

//   final int? optionList;

//   @override
//   String toString() {
//     return 'FinalScoreArgs{key: $key, outOf: $outOf, score: $score, optionList: $optionList}';
//   }
// }

// /// generated route for
// /// [_i9.ReviewScreen]
// class ReviewScreen extends _i17.PageRouteInfo<ReviewScreenArgs> {
//   ReviewScreen({_i18.Key? key})
//       : super(ReviewScreen.name,
//             path: '/review_screen', args: ReviewScreenArgs(key: key));

//   static const String name = 'ReviewScreen';
// }

// class ReviewScreenArgs {
//   const ReviewScreenArgs({this.key});

//   final _i18.Key? key;

//   @override
//   String toString() {
//     return 'ReviewScreenArgs{key: $key}';
//   }
// }

// /// generated route for
// /// [_i10.ProfileScreen]
// class ProfileScreen extends _i17.PageRouteInfo<ProfileScreenArgs> {
//   ProfileScreen({_i18.Key? key})
//       : super(ProfileScreen.name,
//             path: '/profile', args: ProfileScreenArgs(key: key));

//   static const String name = 'ProfileScreen';
// }

// class ProfileScreenArgs {
//   const ProfileScreenArgs({this.key});

//   final _i18.Key? key;

//   @override
//   String toString() {
//     return 'ProfileScreenArgs{key: $key}';
//   }
// }

// /// generated route for
// /// [_i11.UserDetailsScreen]
// class UserDetailsScreen extends _i17.PageRouteInfo<void> {
//   const UserDetailsScreen()
//       : super(UserDetailsScreen.name, path: '/personal_details');

//   static const String name = 'UserDetailsScreen';
// }

// /// generated route for
// /// [_i12.EditProfileScreen]
// class EditProfileScreen extends _i17.PageRouteInfo<EditProfileScreenArgs> {
//   EditProfileScreen({_i18.Key? key})
//       : super(EditProfileScreen.name,
//             path: '/edit_profile', args: EditProfileScreenArgs(key: key));

//   static const String name = 'EditProfileScreen';
// }

// class EditProfileScreenArgs {
//   const EditProfileScreenArgs({this.key});

//   final _i18.Key? key;

//   @override
//   String toString() {
//     return 'EditProfileScreenArgs{key: $key}';
//   }
// }

// /// generated route for
// /// [_i13.MyScoresScreen]
// class MyScoresScreen extends _i17.PageRouteInfo<MyScoresScreenArgs> {
//   MyScoresScreen({_i18.Key? key})
//       : super(MyScoresScreen.name,
//             path: '/my_scores', args: MyScoresScreenArgs(key: key));

//   static const String name = 'MyScoresScreen';
// }

// class MyScoresScreenArgs {
//   const MyScoresScreenArgs({this.key});

//   final _i18.Key? key;

//   @override
//   String toString() {
//     return 'MyScoresScreenArgs{key: $key}';
//   }
// }

// /// generated route for
// /// [_i14.UsersListPage]
// class UsersListRoute extends _i17.PageRouteInfo<void> {
//   const UsersListRoute() : super(UsersListRoute.name, path: '/users');

//   static const String name = 'UsersListRoute';
// }

// /// generated route for
// /// [_i15.DashboardPage]
// class DashboardRoute extends _i17.PageRouteInfo<void> {
//   const DashboardRoute() : super(DashboardRoute.name, path: '/dahboard');

//   static const String name = 'DashboardRoute';
// }

// /// generated route for
// /// [_i16.AdminLanguage]
// class AdminLanguage extends _i17.PageRouteInfo<void> {
//   const AdminLanguage() : super(AdminLanguage.name, path: '/adminLanguages');

//   static const String name = 'AdminLanguage';
// }
