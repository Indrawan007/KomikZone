import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:komikzone/app/controllers/auth_controller.dart';
import 'package:sign_in_button/sign_in_button.dart';

import '../controllers/login_controller.dart';

var Ungu = Color(0xff5B0D80);
var Putih = Color.fromARGB(255, 255, 255, 255);
final authC = Get.find<AuthController>();

class LoginView extends GetView<LoginController> {
  const LoginView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Ungu,
      body: SafeArea(
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Container(
                    height: 250,
                    width: 250,
                    child: Image.asset("assets/images/logo.png"),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Login with your Account",
                    style: TextStyle(
                        color: Putih,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 196, 22, 10),
                        minimumSize: Size(double.infinity, 46),
                      ),
                      onPressed: () => authC.login(),
                      child: Row(
                        children: [
                          Container(
                            height: 30,
                            child: Image.asset(
                              "assets/images/google-plus.png",
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Text(
                            "Masuk dengan Akun Google",
                            style: TextStyle(color: Putih),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    "- Atau Masuk dengan akun lain -",
                    style: TextStyle(color: Putih),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SignInButton(Buttons.email, mini: true, onPressed: () {}),
                      SizedBox(
                        width: 10,
                      ),
                      SignInButton(Buttons.gitHub,
                          mini: true, onPressed: () {}),
                      SizedBox(
                        width: 10,
                      ),
                      SignInButton(Buttons.twitter,
                          mini: true, onPressed: () {}),
                    ],
                  ),
                ],
              ),
            ),
            //       Align(
            //         alignment: Alignment.centerLeft,
            //         child: Text(
            //           "Login with your Account",
            //           style:
            //               TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            //           textAlign: TextAlign.start,
            //         ),
            //       ),

            //     ],
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
