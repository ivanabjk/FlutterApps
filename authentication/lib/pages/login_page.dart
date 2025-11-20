import 'package:authentication/components/my_textfield.dart';
import 'package:authentication/components/square_tile.dart';
import 'package:flutter/material.dart';

import '../components/my_button.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final userController = TextEditingController();
  final passwordController = TextEditingController();

  void signUserIn() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 50,
              ),
              // logo
              Icon(
                Icons.lock,
                size: 100,
              ),

              SizedBox(
                height: 50,
              ),
              // welcome back, you've been missed!
              Text(
                "Welcome back! You've been missed!",
                style: TextStyle(
                  color: Colors.grey.shade700,
                  fontSize: 16,
                ),
              ),

              SizedBox(
                height: 25,
              ),

              // username textfield

              MyTextfield(
                controller: userController,
                hintText: "Username",
                obscureText: false,
              ),

              SizedBox(
                height: 10,
              ),

              // password textfield

              MyTextfield(
                controller: passwordController,
                hintText: "Password",
                obscureText: true,
              ),

              SizedBox(
                height: 10,
              ),

              // forgot password?
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "Forgot password?",
                      style: TextStyle(color: Colors.grey.shade600),
                    ),
                  ],
                ),
              ),

              SizedBox(
                height: 25,
              ),

              // sign in button

              MyButton(
                onTap: signUserIn,
              ),

              SizedBox(
                height: 50,
              ),

              // or continue with

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Divider(),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Text(
                        "Or continue with",
                        style: TextStyle(color: Colors.grey.shade700),
                      ),
                    ),
                    Expanded(
                      child: Divider(),
                    ),
                  ],
                ),
              ),

              SizedBox(
                height: 50,
              ),

              // google + apple sign in buttons

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // google button
                  SquareTile(imagePath: "images/google_logo.png"),

                  SizedBox(
                    width: 25,
                  ),
                  // apple button
                  SquareTile(imagePath: "images/apple_logo.png"),
                ],
              ),

              SizedBox(
                height: 50,
              ),

              // not a member? register now
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Not a member yet?", style: TextStyle(color: Colors.grey.shade700),),
                  SizedBox(
                    width: 4,
                  ),
                  Text(
                    "Register now",
                    style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
