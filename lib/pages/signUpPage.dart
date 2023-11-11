import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:studentlearningenhancement/pages/home.dart';
import '../components/buttton.dart';
import 'package:http/http.dart' as http;
import 'package:studentlearningenhancement/config.dart';

class SignUpPage extends StatelessWidget {
   SignUpPage({super.key});

   final emailController=TextEditingController();
   final passwordController=TextEditingController();
    bool _isNotValidate = false;
   Future<void>  SignUserUp ()
   async {
     try {
       if (emailController.text.isNotEmpty &&
           passwordController.text.isNotEmpty) {
         var registrationBody = {
           "email": emailController.text,
           "password": passwordController.text
         };
         var response = await http.post(
             Uri.parse('http://192.168.100.16:3007/registration'),
             headers: {"Content-Type": "application/json"},
             body: jsonEncode(registrationBody)

         );
         print(response);
       }
       else {
         _isNotValidate = true;
       }
     }
     catch (e) {
       print("Error during HTTP request: $e");
     }

   }
   void NavigateToHomePage(BuildContext context) async {
     Navigator.push(
       context,
       MaterialPageRoute(builder: (context) => HomePage()),
     );
   }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 50),
              Image.asset(
                'assets/images/logo.png',                 width: 100, // Set the width
                height: 100, // Set the height
              ),
              const SizedBox(height: 50),
              Text(
                'Welcome back!',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 25),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal:20.0),
                child: TextField(
                  controller: emailController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    enabledBorder:const  OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey.shade400),
                    ),
                    fillColor: Colors.grey.shade200,
                    filled: true,
                    hintText: "Email",
                    hintStyle: TextStyle(color: Colors.grey[500]),
                    errorText: _isNotValidate ? "Enter Proper Info" : null,
                  ),
                ),
              ),
              const SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal:20.0),
                child: TextField(
                  controller: passwordController,
                  keyboardType: TextInputType.text,
                  obscureText: true,
                  decoration: InputDecoration(
                    enabledBorder:const  OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey.shade400),
                    ),
                    fillColor: Colors.grey.shade200,
                    filled: true,
                    hintText: "Password",
                    hintStyle: TextStyle(color: Colors.grey[500]),
                    errorText: _isNotValidate ? "Enter Proper Info" : null,
                  ),
                ),
              ),

              // MyTextField(
              //   controller: useranmeController,
              //   hintText: 'Username',
              //   obscureText: false,
              //
              // ),
              // MyTextField(
              //   controller: passwordController,
              //   hintText: 'Password',
              //   obscureText: true,
              // ),
              const SizedBox(height: 10),

              MySignUpButton(
                onTap:()=>{
                  SignUserUp(),
                  NavigateToHomePage(context) ,
                },

              ),
              const SizedBox(height: 50),

            ],
          ),
        ),
      ),
    );
  }
}

