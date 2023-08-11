import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../domain/repositories/authentication_repository.dart';
import '../controller/sign_in_controller.dart';
import '../controller/sign_in_state.dart';
import 'widgets/submit_button.dart';

class SignInView extends StatelessWidget {
  const SignInView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SignInController>(
      create: (_) => SignInController(
        SignInState(),
        authenticationRepository: context.read<AuthenticationRepository>(),
      ),
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Form(
              child: Builder(
                builder: (context) {
                  final controller = Provider.of<SignInController>(
                    context,
                    listen: true,
                  );

                  return AbsorbPointer(
                    absorbing: controller.state.fetching,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          onChanged: (text) {
                            controller.onUsernameChanged(text);
                          },
                          decoration: const InputDecoration(
                            hintText: 'Username',
                          ),
                          validator: (text) {
                            text = text?.trim().toLowerCase() ?? '';
                            if (text.isEmpty) {
                              return 'Username is required';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          onChanged: (text) {
                            controller.onPasswordChanged(text);
                          },
                          decoration: const InputDecoration(
                            hintText: 'Password',
                          ),
                          validator: (text) {
                            text = text?.replaceAll(' ', '') ?? '';
                            if (text.length < 4) {
                              return 'Password is required';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),
                        const SubmitButton(),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
