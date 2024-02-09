import 'package:flutter/material.dart';
import 'package:movie_app/model/user_model.dart';
import 'package:movie_app/view/auth_screen.dart';
import 'package:movie_app/view/home_screen.dart';
import 'package:movie_app/view/utils.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    checkUser();
  }

  checkUser() async {
    await Future.delayed(const Duration(seconds: 2));
    User user = await getUserFromPrefs();

    if (!mounted) return;
    if (user.id.isEmpty) {
      await Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const AuthScreen()),
      );
    } else {
      await Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        color: Colors.white,
        height: double.infinity,
        width: double.infinity,
        child: Center(
          child: Image.asset('assets/splash.gif'),
        ),
      ),
    );
  }
}
