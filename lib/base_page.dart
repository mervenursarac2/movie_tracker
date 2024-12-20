import 'package:flutter/material.dart';

class DiscoverPage extends StatefulWidget {
  const DiscoverPage({super.key});

  @override
  State<DiscoverPage> createState() => _DiscoverPageState();
}

class _DiscoverPageState extends State<DiscoverPage> {
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
                image: AssetImage("assets/images/secondBG.png"),
                fit: BoxFit.cover),
          ),
          child: Center(
              child: Text(
                "merve",
                style: TextStyle(color: Colors.white, fontSize: 35),
              )),
          //  child: CustomText()),
        ));
  }
}
