import 'package:flutter/material.dart';
import 'package:movie_app/home_page.dart';
class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

 
  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 3),(){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomePage()));

    });
    return Scaffold(
      backgroundColor: Colors.deepOrangeAccent,
body: Center(
  child: Image.asset('images/splash.webp'),
),
    );
  }
}
