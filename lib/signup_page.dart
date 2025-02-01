import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:movie_tracker/colors.dart';
import 'package:movie_tracker/HomePage/home_page.dart';
import 'package:movie_tracker/login_page.dart';
import 'package:movie_tracker/service/auth.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final email = TextEditingController();
  final password = TextEditingController();
  final confirmPassword = TextEditingController();

  bool isPasswordVisible = false;

  String? errormessage;
  Future<void> createUser() async {
    if (password.text != confirmPassword.text) {
      setState(() {
        errormessage = "Şifreler uyuşmuyor!";
      });
      return;
    }
    try {
      await Auth().createUser(email: email.text, password: password.text);
      //LoginPage'e yönlendirme
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginPage()),
      );
    } on FirebaseAuthException catch (e) {
      setState(() {
        errormessage = e.message;
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
            padding: EdgeInsets.all(3.0),
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
              padding: const EdgeInsets.only(top: 75),
              child: Container(
                width: 430,
                height: 600,
                child: Form(

                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Padding(
                        padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                        child: Text(
                          "Sign Up",
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'PlaywriteGBS',
                              fontSize: 35,
                              fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 10, 10, 8),
                        child: SizedBox(
                          width: 300,
                          child: TextFormField(
                            controller: email,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "username is required!";
                              } else
                                return null;
                            },
                            cursorColor: Colors.black,
                            style: TextStyle(color: darkColor),
                            decoration: InputDecoration(
                              hintStyle: TextStyle(
                                  color: darkColor.withOpacity(0.5),
                                  fontSize: 17),
                              hintText: "username",
                              filled: true,
                              fillColor: butter,
                              border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(50)),
                            ),
                          ),
                        ),
                      ),
                      Center(
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Padding(
                                padding: const EdgeInsets.fromLTRB(10, 10, 5, 8),
                                child: SizedBox(
                                  width: 200,
                                  child: TextFormField(
                                    controller: password,
                                    obscureText: !isPasswordVisible, // Şifreyi gizlemek için
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
                                      suffixIcon: IconButton(
                                        icon: Icon(
                                          isPasswordVisible
                                              ? Icons.visibility
                                              : Icons.visibility_off,
                                          color: darkColor,
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            isPasswordVisible = !isPasswordVisible;
                                          });
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(5, 10, 10, 8),
                                child: SizedBox(
                                  width: 200,
                                  child: TextFormField(
                                    controller: confirmPassword,
                                    obscureText: !isPasswordVisible,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return "password is required!";
                                      } else if (password.text != confirmPassword.text) {
                                        return "password dont match!";
                                      }
                                      return null;
                                    },
                                    cursorColor: Colors.black,
                                    style: TextStyle(color: darkColor),
                                    decoration: InputDecoration(
                                      hintStyle: TextStyle(
                                          color: darkColor.withOpacity(0.5),
                                          fontSize: 17),
                                      hintText: "confirm password",
                                      filled: true,
                                      fillColor: butter,
                                      border: OutlineInputBorder(
                                          borderSide: BorderSide.none,
                                          borderRadius: BorderRadius.circular(50)),
                                      suffixIcon: IconButton(
                                        icon: Icon(
                                          isPasswordVisible
                                              ? Icons.visibility
                                              : Icons.visibility_off,
                                          color: darkColor,
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            isPasswordVisible = !isPasswordVisible;
                                          });
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              ),

                            ]),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 25, 10, 25),
                        child: Container(
                          width: 225,
                          height: 45,
                          decoration: BoxDecoration(
                            color: darkColor,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: TextButton(
                            onPressed: () {
                             createUser();
                            },

                            child: const Text(
                              'Sign Up',
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
          ),
        ),
      ),
    );
  }
}
