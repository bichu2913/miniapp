import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/auth_controller.dart';

class LoginPage extends StatelessWidget {
  final AuthController controller = Get.find();
  final TextEditingController emailC =
      TextEditingController();
  final TextEditingController passC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Card(
          margin: const EdgeInsets.all(24),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 420),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Login',
                      style: Theme.of(context).textTheme.headlineMedium),
                  const SizedBox(height: 12),
                  TextField(
                      controller: emailC,
                      decoration: const InputDecoration(labelText: 'Email')),
                  const SizedBox(height: 8),
                  TextField(
                      controller: passC,
                      decoration: const InputDecoration(labelText: 'Password'),
                      obscureText: true),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () async {
                      try {
                        await controller.login(
                            emailC.text.trim(), passC.text.trim());
                        Get.offAllNamed('/home');
                      } catch (e) {
                        Get.snackbar('Error', e.toString(),
                            snackPosition: SnackPosition.BOTTOM);
                      }
                    },
                    child: const Text('Login'),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
