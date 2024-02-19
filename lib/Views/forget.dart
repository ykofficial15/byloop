import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:practice/Models/authenticate.dart';
import 'package:practice/Views/home.dart';
import 'package:practice/Views/signup.dart';
import 'package:provider/provider.dart';

class Forget extends StatefulWidget {
  @override
  State<Forget> createState() => _ForgetState();
}

class _ForgetState extends State<Forget> {
   TextEditingController _emailController = TextEditingController();

  void sendPasswordResetEmail(String email) async {
    if (email.isEmpty) {
      Fluttertoast.showToast(
          msg: "Please enter email",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          backgroundColor: Colors.red,
          timeInSecForIosWeb: 1,
          textColor: Colors.white,
          fontSize: 16.0);
    } else {
      try {
        await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
        print('Password reset email sent');
        Fluttertoast.showToast(
            msg: "Check Your Mail",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            backgroundColor: Colors.blue,
            timeInSecForIosWeb: 1,
            textColor: Colors.white,
            fontSize: 16.0);
      } catch (e) {
        print('Failed to send password reset email: $e');
        if (e is FirebaseAuthException) {
          if (e.code == 'user-not-found') {
            Fluttertoast.showToast(
              msg: 'Email does not exist',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              backgroundColor:Colors.red,
              textColor: Colors.white,
            );
          } else {
            Fluttertoast.showToast(
              msg: 'Failed to send password reset email',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              backgroundColor:Colors.red,
              textColor: Colors.white,
            );
          }
        } else {
          Fluttertoast.showToast(
            msg: 'Failed to send password reset email',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            backgroundColor:Colors.red,
            textColor: Colors.white,
          );
        }
      }
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Positioned(
              child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                color: Colors.orange,
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height * 0.1, // Adjust the spacing from the top
              left: 0,
              right: 0,
              child: Container(
                height: MediaQuery.sizeOf(context).height,
                padding: EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40.0),
                    topRight: Radius.circular(40.0),
                  ),
                ),
                child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              
              SizedBox(height: 150),
              Container(
                margin: EdgeInsetsDirectional.symmetric(horizontal: 20),
                width: MediaQuery.of(context).size.width,
                child: const Text(
                  'Reset Your Password',
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsetsDirectional.symmetric(horizontal: 20),
                width: MediaQuery.of(context).size.width,
                child: const Text(
                  'Here',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 25.0),
              Container(
                margin: EdgeInsetsDirectional.symmetric(horizontal: 20),
                width: MediaQuery.of(context).size.width,
                child: TextField(
                  cursorColor: Colors.black,
                  controller: _emailController,
                  decoration: const InputDecoration(
                    hintText: "Enter your email",
                    hintStyle: TextStyle(color: Colors.black),
                    labelText: "Email",
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color:Colors.black), // Set your desired Outline color here
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.black), // Set your desired unfocused border color here
                    ),
                    labelStyle: TextStyle(color: Colors.black),
                    prefixIcon: Icon(Icons.mail, color: Colors.blue),
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              Container(
                margin: EdgeInsetsDirectional.symmetric(horizontal: 20),
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                  style: ButtonStyle(
                      padding: MaterialStatePropertyAll(EdgeInsets.all(15)),
                      backgroundColor:
                          MaterialStatePropertyAll(Colors.blue)),
                  onPressed: () =>
                      sendPasswordResetEmail(_emailController.text),
                  child: Text('Send Reset Email',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 15)),
                ),
              )
            ],
          ),
              ),
            ),
            Positioned(
             left: MediaQuery.of(context).size.width / 4,
              top:MediaQuery.of(context).size.height * 0.0, 
              child: Image.asset('assets/logo.png', height: 200, width: 200),
            ),
          ],
        ),
      ),
    );
  }
}
