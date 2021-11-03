import 'package:bookario/screens/customer_UI_screens/details/details_screen.dart';
import 'package:bookario/screens/customer_UI_screens/history/booking_history.dart';
import 'package:bookario/screens/customer_UI_screens/premium_clubs/premium_club_list.dart';
import 'package:bookario/screens/forgot_password/forgot_password_screen.dart';
import 'package:bookario/screens/sign_in/sign_in_screen.dart';
import 'package:bookario/screens/sign_up/sign_up_screen.dart';
import 'package:bookario/screens/splash/splash_screen.dart';

// We use name route
final routes = {
  SplashScreen.routeName: (context) => SplashScreen(),
  SignInScreen.routeName: (context) => SignInScreen(),
  ForgotPasswordScreen.routeName: (context) => ForgotPasswordScreen(),
  SignUpScreen.routeName: (context) => SignUpScreen(),
  // DetailsScreen.routeName: (context) => DetailsScreen(),
  BookingHistory.routeName: (context) => BookingHistory(),
  // BottomCustomNavBar.routeName: (context) => BottomCustomNavBar(),
  PremiumClubsList.routeName: (context) => PremiumClubsList(),
  // ClubHomeScreen.routeName: (context) => ClubHomeScreen(),
  // OwnClubDetailsScreen.routeName: (context) => OwnClubDetailsScreen(),
};
