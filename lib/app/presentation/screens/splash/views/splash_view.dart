import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../domain/repositories/account.repository.dart';
import '../../../../domain/repositories/authentication_repository.dart';
import '../../../../domain/repositories/connectivity_repository.dart';
import '../../../global/controllers/session_controller.dart';
import '../../../routes/routes.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _init();
    });
  }

  Future<void> _init() async {
    final routeName = await () async {
      final connectivityRepository = context.read<ConnectivityRepository>();
      final authenticationRepository = context.read<AuthenticationRepository>();
      final accountRepository = context.read<AccountRepository>();
      final SessionController sessionController = context.read();
      final hasIternet = await connectivityRepository.hasInternet;
      if (!hasIternet) {
        return Routes.offline;
      }

      final isSignedIn = await authenticationRepository.isSignedIn;
      if (!isSignedIn) {
        return Routes.singIn;
      }
      final user = await accountRepository.getUserData();
      if (user != null) {
        sessionController.setUser(user);
        return Routes.home;
      }
      return Routes.singIn;
    }();
    if (mounted) {
      _goTo(routeName);
    }
  }

  void _goTo(String routeName) {
    Navigator.pushReplacementNamed(
      context,
      routeName,
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: SizedBox(
          width: 80,
          height: 80,
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
