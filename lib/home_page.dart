import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return buildPage();
  }

  Widget buildPage() {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar:  AppBar(
          title: Container(
              padding: const EdgeInsets.all(3.0),
              alignment: Alignment.center,
              child: Image.asset(
                'assets/images/logo.png',
                height: 50,
                width: 180,
                fit: BoxFit.contain,
              )),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/mainBG.png"),
                fit: BoxFit.cover),
          ),
          child: Center(
              child: Text(
                "homepage",
                style: TextStyle(color: Colors.white, fontSize: 35),
              )),
          //  child: CustomText()),
        ));
  }
}
