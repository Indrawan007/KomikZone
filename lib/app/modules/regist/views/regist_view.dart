import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:komikzone/app/routes/app_pages.dart';
import 'package:sign_in_button/sign_in_button.dart';

import '../controllers/regist_controller.dart';

var Ungu = Color(0xff5B0D80);

class RegistView extends GetView<RegistController> {
  const RegistView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Ungu,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Container(
                height: 200,
                width: 200,
                child: Image.asset("assets/images/logo.png"),
              ),
              TextFormField(
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  hintText: "Email",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                textInputAction: TextInputAction.done,
                keyboardType: TextInputType.visiblePassword,
                decoration: InputDecoration(
                  hintText: "Password",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                textInputAction: TextInputAction.done,
                keyboardType: TextInputType.visiblePassword,
                decoration: InputDecoration(
                  hintText: "Confirm Password",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => Get.offAllNamed(Routes.HOME),
                      child: Text("Login"),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Text("- Or sign in with -"),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SignInButton(Buttons.facebook, mini: true, onPressed: () {}),
                  SignInButton(Buttons.email, mini: true, onPressed: () {}),
                  SignInButton(Buttons.twitter, mini: true, onPressed: () {}),
                ],
              ),
              // SizedBox(
              //   height: 10,
              // ),
              Row(
                children: [
                  Text("If you have account"),
                  GestureDetector(
                    onTap: () => Get.toNamed(Routes.LOGIN),
                    child: Text("Login"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
