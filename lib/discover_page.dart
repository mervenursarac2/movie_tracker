import 'package:flutter/material.dart';
import 'package:movie_tracker/colors.dart';
import 'package:movie_tracker/login_page.dart';

class DiscoverPage extends StatefulWidget {
  const DiscoverPage({super.key});

  @override
  State<DiscoverPage> createState() => _DiscoverPageState();
}

class _DiscoverPageState extends State<DiscoverPage> {
  bool isHovered = false;
  @override
  Widget build(BuildContext context) {
    return buildPage();
  }

  Widget buildPage() {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
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
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 175, 0, 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: 'Pop ',
                        style: TextStyle(
                            color: mainColor, // İlk kelimenin rengi
                            fontSize: 45,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Anton'),
                      ),
                      TextSpan(
                        text: 'the corn,\nrate the ',
                        style: TextStyle(
                            color: butter, // Diğer kelimelerin rengi
                            fontSize: 45,
                            fontFamily: 'Anton'),
                      ),
                      TextSpan(
                        text: 'views!',
                        style: TextStyle(
                            color: mainColor, // Son kelime varsayılan renk
                            fontSize: 45,
                            fontFamily: 'Anton'),
                      ),
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 25, 10, 25),
                  child: Text(
                    "Discover new films and shows, share your ratings,\n"
                    "and explore recommendations based on your taste.\n"
                    "PopView makes entertainment simple and fun!",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: butter,
                      fontSize: 16,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 25, 10, 25),
                    child: SizedBox(
                      width: 225,
                      height: 45,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: darkColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                              //border radius equal to or more than 50% of width
                            ),
                            shadowColor: mainColor,
                          ),
                          onPressed: () {
                           Navigator.of(context).push(MaterialPageRoute(builder: (context) =>const LoginPage()));
                          },
                          child: const Text(
                            'Get Started',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontFamily: 'PlaywriteGBS',
                                fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          )),
                    ),
                )
              ],
            ),
          ),
        ));
  }
}
