import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/auth_controller.dart';
import '../controllers/category_controller.dart';
import '../controllers/product_controller.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _initApp();
  }

  Future<void> _initApp() async {
    try {
      final catC = Get.find<CategoryController>();
      final prodC = Get.find<ProductController>();
      final auth = Get.find<AuthController>();

      // Wait until controllers finish loading
      while (catC.loading.value || prodC.loading.value) {
        await Future.delayed(const Duration(milliseconds: 100));
      }

      // Navigate to appropriate screen
      if (auth.isLoggedIn) {
        Get.offAllNamed('/home');
      } else {
        Get.offAllNamed('/login');
      }
    } catch (e) {
      
      
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 16),
            Text('Loading Mini Shop...'),
          ],
        ),
      ),
    );
  }
}
