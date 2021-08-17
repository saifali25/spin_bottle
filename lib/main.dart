import 'dart:math';
import 'package:hexcolor/hexcolor.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  var lastPosition = 0.0;
  var random = new Random();

  late AnimationController _animationController;
  double getRandomNumber() {
    lastPosition = random.nextDouble();
    return lastPosition;
  }

  @override
  void initState() {
    super.initState();

    spinTheBottle();
  }

  void spinTheBottle() {
    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 2));

    _animationController.forward();
  }

  @override
  dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            child: Image.asset(
              'assets/images/bg.jpg',
              height: MediaQuery.of(context).size.height,
              fit: BoxFit.fitHeight,
            ),
          ),
          Center(
            child: Container(
              child: RotationTransition(
                turns: Tween(begin: lastPosition, end: getRandomNumber())
                    .animate(CurvedAnimation(
                        parent: _animationController, curve: Curves.linear)),
                child: GestureDetector(
                  onTap: () {
                    if (_animationController.isCompleted) {
                      setState(() {
                        spinTheBottle();
                      });
                    }
                    
                  },
                  child: Image.asset(
                    'assets/images/bottle.png',
                    width: 300,
                    height: 300,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(88.0, 560, 78, 0),
            child: Text(
              'Bottle Spin Game',
              style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 25.0,
                  color: HexColor('#F5F5DC'),
                  letterSpacing: 0.4),
            ),
          ),
        ],
      ),
    );
  }
}
