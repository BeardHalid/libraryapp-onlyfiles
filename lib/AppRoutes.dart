import 'package:flutter/material.dart';
import 'package:libraryapp/pages/home/categories/Categories.dart';
import 'package:libraryapp/pages/home/home/Home.dart';
import 'package:libraryapp/pages/home/myLibrary/MyLibrary.dart';
import 'package:libraryapp/pages/home/settings/petition/CreatePetition.dart';
import 'package:libraryapp/pages/home/settings/petition/Petition.dart';
import 'package:libraryapp/pages/home/settings/whoAreUs/WhoAreUs.dart';
import 'package:libraryapp/pages/profile/ProfileMain.dart';
import 'package:libraryapp/pages/register/Register.dart';
import 'package:libraryapp/pages/renewPassword/RenewPassword.dart';
import 'package:libraryapp/pages/home/settings/Settings.dart';
import 'package:libraryapp/pages/shoppingBox/ShoppingBox.dart';
import 'package:libraryapp/pages/home/transition/Transition.dart';
import 'package:libraryapp/pages/splashScreen/SplashScreen.dart';

class AppRoutes {
  static const String homePage = '/HomePage';
  static const String categories = '/Categories';
  static const String myLibrary = '/MyLibrary';
  static const String profile = '/Profile';
  static const String register = '/Register';
  static const String renewPassword = '/RenewPassword';
  static const String settings = '/Settings';
  static const String shoppingBox = '/ShoppingBox';
  static const String transition = '/Transition';
  static const String whoAreUs = '/WhoAreUs';
  static const String splashScreen = '/SplashScreen';
  static const String petition = '/Petition';
  static const String createPetition = '/CreatePetition';
}

class Routes {
  static var homePage = AppRoutes.homePage;
  static var categories = AppRoutes.categories;
  static var settings = AppRoutes.settings;
  static var profile = AppRoutes.profile;
  static var register = AppRoutes.register;
  static var shoppingBox = AppRoutes.shoppingBox;
  static var renewPassword = AppRoutes.renewPassword;
  static var myLibrary = AppRoutes.myLibrary;
  static var transition = AppRoutes.transition;
  static var whoAreUs = AppRoutes.whoAreUs;
  static var splashScreen = AppRoutes.splashScreen;
  static var petition = AppRoutes.petition;
  static var createPetition = AppRoutes.createPetition;

  static Map<String, WidgetBuilder> routes() => {
        homePage: (context) => Home(),
        categories: (context) => Categories(),
        settings: (context) => SettingsPage(),
        profile: (context) => ProfileMain(),
        register: (context) => Register(),
        shoppingBox: (context) => ShoppingBox(),
        renewPassword: (context) => RenewPassword(),
        myLibrary: (context) => MyLibrary(),
        transition: (context) => Transition(),
        whoAreUs: (context) => WhoAreUs(),
        splashScreen: (context) => SplashScreen(),
        petition: (context) => const Petition(),
        createPetition: (context) => const CreatePetition()
      };
}
