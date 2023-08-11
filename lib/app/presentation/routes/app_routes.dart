import 'package:flutter/material.dart';

import '../screens/home/views/home_view.dart';
import '../screens/offline/views/offline_view.dart';
import '../screens/sign_in/views/sign_in_view.dart';
import '../screens/splash/views/splash_view.dart';
import 'routes.dart';

Map<String, Widget Function(BuildContext)> get appRoutes {
  return {
    Routes.splash: (context) => const SplashView(),
    Routes.singIn: (context) => const SignInView(),
    Routes.home: (context) => const HomeView(),
    Routes.offline: (context) => const OfflineView(),
  };
}
