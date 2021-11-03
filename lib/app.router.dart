// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedRouterGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';

import 'models/event_model.dart';
import 'screens/customer_UI_screens/bookings/book_pass.dart';
import 'screens/customer_UI_screens/details/details_screen.dart';
import 'screens/customer_UI_screens/home/home_screen.dart';
import 'screens/customer_UI_screens/profile/components/edit_profile.dart';
import 'screens/customer_UI_screens/profile/profile_screen.dart';
import 'screens/landing_view/landing_view.dart';
import 'screens/sign_in/sign_in_screen.dart';
import 'screens/sign_up/sign_up_screen.dart';
import 'screens/splash/splash_screen.dart';
import 'screens/startup/startup_view.dart';

class Routes {
  static const String startUpView = '/';
  static const String splashScreen = '/splash_screen';
  static const String landingView = '/landing-page';
  static const String signInScreen = '/sign_in';
  static const String signUpScreen = '/sign_up';
  static const String homeScreen = '/home';
  static const String detailsScreen = '/event-details';
  static const String bookPass = '/book-pass';
  static const String profileScreen = '/my-profile';
  static const String editProfile = '/edit-profile';
  static const all = <String>{
    startUpView,
    splashScreen,
    landingView,
    signInScreen,
    signUpScreen,
    homeScreen,
    detailsScreen,
    bookPass,
    profileScreen,
    editProfile,
  };
}

class StackedRouter extends RouterBase {
  @override
  List<RouteDef> get routes => _routes;
  final _routes = <RouteDef>[
    RouteDef(Routes.startUpView, page: StartUpView),
    RouteDef(Routes.splashScreen, page: SplashScreen),
    RouteDef(Routes.landingView, page: LandingView),
    RouteDef(Routes.signInScreen, page: SignInScreen),
    RouteDef(Routes.signUpScreen, page: SignUpScreen),
    RouteDef(Routes.homeScreen, page: HomeScreen),
    RouteDef(Routes.detailsScreen, page: DetailsScreen),
    RouteDef(Routes.bookPass, page: BookPass),
    RouteDef(Routes.profileScreen, page: ProfileScreen),
    RouteDef(Routes.editProfile, page: EditProfile),
  ];
  @override
  Map<Type, StackedRouteFactory> get pagesMap => _pagesMap;
  final _pagesMap = <Type, StackedRouteFactory>{
    StartUpView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => StartUpView(),
        settings: data,
      );
    },
    SplashScreen: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => SplashScreen(),
        settings: data,
      );
    },
    LandingView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => LandingView(),
        settings: data,
      );
    },
    SignInScreen: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => SignInScreen(),
        settings: data,
      );
    },
    SignUpScreen: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => SignUpScreen(),
        settings: data,
      );
    },
    HomeScreen: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => HomeScreen(),
        settings: data,
      );
    },
    DetailsScreen: (data) {
      var args = data.getArgs<DetailsScreenArguments>(nullOk: false);
      return MaterialPageRoute<dynamic>(
        builder: (context) => DetailsScreen(
          key: args.key,
          event: args.event,
        ),
        settings: data,
      );
    },
    BookPass: (data) {
      var args = data.getArgs<BookPassArguments>(nullOk: false);
      return MaterialPageRoute<dynamic>(
        builder: (context) => BookPass(
          key: args.key,
          event: args.event,
        ),
        settings: data,
      );
    },
    ProfileScreen: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => ProfileScreen(),
        settings: data,
      );
    },
    EditProfile: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => EditProfile(),
        settings: data,
      );
    },
  };
}

/// ************************************************************************
/// Arguments holder classes
/// *************************************************************************

/// DetailsScreen arguments holder class
class DetailsScreenArguments {
  final Key? key;
  final Event event;
  DetailsScreenArguments({this.key, required this.event});
}

/// BookPass arguments holder class
class BookPassArguments {
  final Key? key;
  final Event event;
  BookPassArguments({this.key, required this.event});
}
