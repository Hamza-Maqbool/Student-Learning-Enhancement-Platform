
import 'package:flutter/material.dart';
import 'package:studentlearningenhancement/components/buttton.dart';
import 'package:studentlearningenhancement/components/textField.dart';
import 'package:studentlearningenhancement/pages/signUpPage.dart';

class LoginPage extends StatelessWidget {
   LoginPage({Key? key});
  //controller
  final emailController=TextEditingController();
  final passwordController=TextEditingController();
   bool _isNotValidate = false;
  //sign in user
   void SignUserIn()
   {
     if (emailController.text.isNotEmpty&&passwordController.text.isNotEmpty)
     {}
     else{
       _isNotValidate=true;
     }
   }
   void SignUserUp(BuildContext context) async {
     Navigator.push(
       context,
       MaterialPageRoute(builder: (context) => SignUpPage()),
     );
   }

// ... (rest of the code)

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

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                        'Forget Pasword?',
                      style: TextStyle(color: Colors.grey[600],
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),

              MyButton(
                onTap: SignUserIn,
              ),
              const SizedBox(height: 50),
              Row(
                mainAxisAlignment: MainAxisAlignment.center, // Center the "Sign Up" button
                children: [
                  Text('Don\'t have an account?'),
                  SizedBox(width: 5), // Add some spacing
                  SignUpButton(
                    onTap: () => SignUserUp(context),
                    //onTap: SignUserUp,
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
