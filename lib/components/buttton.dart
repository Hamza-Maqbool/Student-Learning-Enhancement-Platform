import 'package:flutter/material.dart';
class MyButton extends StatelessWidget {
  final VoidCallback onTap;

  MyButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          primary: Colors.black, // Set the background color to black
          padding: EdgeInsets.all(25),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          elevation: 5,
          shadowColor: Colors.grey,
          minimumSize: Size(double.infinity, 40),
         // minimumSize: Size(150, 40),
          textStyle: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        child: Text("Sign In",
              style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,),
      )),
    );
  }
}


class SignUpButton extends StatelessWidget {
  final VoidCallback onTap;
  SignUpButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        primary: Colors.white, // Set the background color to white
        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24), // Add padding
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8), // Add rounded corners
        ),
        side: BorderSide(color: Colors.white, width: 2), // Add a border
        elevation: 5, // Add elevation
        shadowColor: Colors.grey, // Set shadow color
        minimumSize: Size(150, 40), // Set a minimum button size
        textStyle: TextStyle(fontSize: 16), // Set text style
        // You can also add margin here if needed:
        // margin: EdgeInsets.all(10),
      ),
      child: Text('Sign Up',
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 14,
        ),
      ),
    );
  }
}
class MySignUpButton extends StatelessWidget {
  final VoidCallback onTap;
  const MySignUpButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: ElevatedButton(
          onPressed: onTap,
          style: ElevatedButton.styleFrom(
            primary: Colors.black, // Set the background color to black
            padding: EdgeInsets.all(25),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            elevation: 5,
            shadowColor: Colors.grey,
            minimumSize: Size(double.infinity, 40),
            // minimumSize: Size(150, 40),
            textStyle: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          child: Text("Sign Up",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,),
          )),
    );
  }
}

