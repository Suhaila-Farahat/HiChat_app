import 'dart:async';
import 'package:chat_app/Constants.dart';
import 'package:chat_app/Views/Login_View.dart';
import 'package:flutter/material.dart';


class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);
  static String id = 'Splash';

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {

  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      Navigator.pushNamed(context, LoginView.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Hero(
              tag: 'logoTag',
              child: AnimatedContainer(
                duration: Duration(seconds: 5),
                curve: Curves.slowMiddle,
                width: 150,
                height: 150,
                child: Image.asset('assets/img.png'),
              ),
            ),
            AnimatedTextWidget(
              text: 'HiChat',
            )
          ],
        ),
      ),
    );
  }
}

class AnimatedTextWidget extends StatefulWidget {
  final String text;

  const AnimatedTextWidget({required this.text, Key? key}) : super(key: key);

  @override
  _AnimatedTextWidgetState createState() => _AnimatedTextWidgetState();
}

class _AnimatedTextWidgetState extends State<AnimatedTextWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );

    _animation = Tween<double>(begin: 0.0, end: 2).animate(_controller);

    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _animation,
      child: Text(
        widget.text,
        style: TextStyle(
          color:textColor,
          fontSize: 35,
          fontWeight: FontWeight.bold,
          fontFamily: appFont,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
