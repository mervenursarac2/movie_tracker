import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:movie_tracker/colors.dart';
import 'package:movie_tracker/home_page.dart';
import 'package:movie_tracker/service/auth.dart';
import 'package:movie_tracker/signup_page.dart';
//merve@deneme.com deneme123
//enhar@deneme.com merve

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final email = TextEditingController();
  final password = TextEditingController();

  String? errormessage;

  Future<void> signIn() async {
    try {
      await Auth().signIn(email: email.text, password: password.text);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
    } on FirebaseAuthException catch (e) {
      setState(() {
        errormessage = e.message;
        print('Hata: ${e.message}');
      });
    }
  }

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
        body: SingleChildScrollView(
          child: Container(
              /* width: double.infinity,
              height: double.infinity,*/
              width: 500,
              height: 750,
              decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/mainBG.png"),
                    fit: BoxFit.cover),
              ),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 175),
                  child: Form(
                    child: SizedBox(
                      width: 350,
                      height: 600,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Padding(
                            padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                            child: Text(
                              "log in",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'PlaywriteGBS',
                                  fontSize: 35,
                                  fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(10, 20, 10, 7),
                            child: SizedBox(
                              width: 300,
                              child: TextFormField(
                                controller: email,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "email is required!";
                                  }
                                  return null;
                                },
                                cursorColor: Colors.black,
                                style: TextStyle(color: darkColor),
                                decoration: InputDecoration(
                                  hintStyle: TextStyle(
                                      color: darkColor.withOpacity(0.5),
                                      fontSize: 17),
                                  hintText: "email",
                                  filled: true,
                                  fillColor: butter,
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius: BorderRadius.circular(50)),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(10, 10, 10, 8),
                            child: SizedBox(
                              width: 300,
                              child: TextFormField(
                                controller: password,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "password is required!";
                                  }
                                  return null;
                                },
                                cursorColor: Colors.black,
                                style: TextStyle(color: darkColor),
                                decoration: InputDecoration(
                                  hintStyle: TextStyle(
                                      color: darkColor.withOpacity(0.5),
                                      fontSize: 17),
                                  hintText: "password",
                                  filled: true,
                                  fillColor: butter,
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius: BorderRadius.circular(50)),
                                ),
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  "dont you have an account?",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(5, 15, 10, 25),
                                child: SizedBox(
                                  width: 100,
                                  height: 30,
                                  child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: darkColor,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                        ),
                                        shadowColor: mainColor,
                                      ),
                                      onPressed: () {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const SignupPage()));
                                      },
                                      child: const Text(
                                        'sign up',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 13,
                                            fontFamily: 'PlaywriteGBS',
                                            fontWeight: FontWeight.bold),
                                        textAlign: TextAlign.center,
                                      )),
                                ),
                              )
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(10, 15, 10, 25),
                            child: Container(
                              width: 225,
                              height: 45,
                              decoration: BoxDecoration(
                                color: darkColor,
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: TextButton(
                                onPressed: () {
                                  signIn();
                                },
                                child: const Text(
                                  'Log In',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontFamily: 'PlaywriteGBS',
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ),
                          errormessage != null
                              ? Text(errormessage!,style: TextStyle(color: Colors.white,fontSize: 20),)
                              : SizedBox.shrink(),
                        ],
                      ),
                    ),
                  ),
                ),
              )),
        ));
  }
}
