import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:practice/Models/authenticate.dart';
import 'package:practice/Views/forget.dart';
import 'package:practice/Views/home.dart';
import 'package:practice/Views/signup.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  int? _selectedIndex = 0;
  late String semail, spassword;
final FirebaseAuth _auth = FirebaseAuth.instance;

void _checkUserExist() async {
  final form = _formKey.currentState;
  if (form!.validate()) {
    form.save();
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: semail,
        password: spassword,
      );
      Fluttertoast.showToast(
        msg: 'Login successful!',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        backgroundColor: Colors.green,
        textColor: Colors.white,
      );
      final authProvider = Provider.of<Authenticate>(context, listen: false);
      authProvider.login();
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => Home()),
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Fluttertoast.showToast(
          msg: "User not found for that email",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      } else if (e.code == 'wrong-password') {
        Fluttertoast.showToast(
          msg: "Entered wrong password",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      } else {
        Fluttertoast.showToast(
          msg: "Error: ${e.message}",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      }
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Error in logging in",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              top: MediaQuery.of(context).size.height * 0.2, // Adjust the spacing from the top
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
                child: Form(
                  key: _formKey,
                  child: Column(
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Container(
                          margin: EdgeInsets.fromLTRB(15, 90, 15, 0),
                          child: Column(
                            children: [
                              const Text(
                                'Log in',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 25.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 10,),
                              const Text(
                                'Enjoy different',
                                style: TextStyle(
                                  color: Colors.blue,
                                ),
                              ),
                                  const Text(
                                'delicious Indian street foods online',
                                style: TextStyle(
                                  color: Colors.blue,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 44.0,
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(15, 0, 15, 0),
                        child: Column(
                          children: [
                            TextFormField(
                              style: TextStyle(color: Colors.black),
                              cursorColor: Colors.black,
                              keyboardType: TextInputType.emailAddress,
                              decoration: const InputDecoration(
                                hintText: "Enter your email",
                                hintStyle: TextStyle(color: Colors.black),
                                labelText: "Email",
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.black,
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.black,
                                  ),
                                ),
                                labelStyle: TextStyle(color: Colors.black),
                                prefixIcon: Icon(Icons.mail, color: Colors.blue),
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter your email';
                                }
                                return null;
                              },
                              onSaved: (value) => semail = value!,
                            ),
                            const SizedBox(
                              height: 26.0,
                            ),
                            TextFormField(
                              style: TextStyle(color: Colors.black),
                              obscureText: true,
                              cursorColor: Colors.black,
                              keyboardType: TextInputType.text,
                              decoration: const InputDecoration(
                                hintText: "Enter your password",
                                hintStyle: TextStyle(color: Colors.black),
                                labelText: "Password",
                                labelStyle: TextStyle(color: Colors.black),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.black,
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.black,
                                  ),
                                ),
                                prefixIcon: Icon(Icons.lock_person_rounded,
                                    color: Colors.blue),
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter your password';
                                }
                                return null;
                              },
                              onSaved: (value) => spassword = value!,
                            ),
                            const SizedBox(
                              height: 8.0,
                            ),
                            FittedBox(
                              child: Row(
                                children: [
                                  const Text(
                                    'Dont have an account?  ',
                                    style: TextStyle(color: Colors.black),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                       Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => Signup(),
            ));
                                    },
                                    child: Text(
                                      'Register Now',
                                      style: TextStyle(
                                          color: Colors.blue,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  const Text(
                                    '  or  ',
                                    style: TextStyle(color: Colors.black),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                       Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => Forget(),
            ));
                                    },
                                    child: Text(
                                      'Forgot Password',
                                      style: TextStyle(
                                          color: Colors.blue,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 70.0,
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(15, 0, 15, 0),
                        width: double.infinity,
                        child: RawMaterialButton(
                          fillColor: Colors.blue,
                          elevation: 0.0,
                          padding: const EdgeInsets.symmetric(vertical: 20.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          onPressed: () {
                            _checkUserExist();
                          },
                          child: const Text(
                            "Login",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              left: MediaQuery.of(context).size.width / 4,
              top:MediaQuery.of(context).size.height * 0.1, 
              child: Image.asset('assets/logo.png', height: 200, width: 200),
            ),
          ],
        ),
      ),
    );
  }
}
