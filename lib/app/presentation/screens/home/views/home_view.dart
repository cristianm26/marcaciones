import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../global/controllers/session_controller.dart';
import '../../../routes/routes.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    final SessionController sessionController = Provider.of(context);
    final user = sessionController.state!;
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (user.usuarioFoto != null)
              Image.network(
                user.usuarioFoto!,
                width: 100,
                height: 100,
              ),
            Text(
              user.username,
              style: const TextStyle(fontSize: 20),
            ),
            TextButton(
              onPressed: () async {
                await sessionController.signOut();
                if (mounted) {
                  Navigator.pushReplacementNamed(
                    context,
                    Routes.singIn,
                  );
                }
              },
              child: const Text('Cerrar sesión'),
            ),
          ],
        ),
      ),
    );
  }
}