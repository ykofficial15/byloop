import 'package:flutter/material.dart';
import 'package:practice/Models/authenticate.dart';
import 'package:practice/Views/login.dart';
import 'package:provider/provider.dart';
class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                child:Text('Welcome to HomePage',style: TextStyle(color:Colors.white,fontSize: 25),),
              ),
                Container(
                  margin: EdgeInsets.fromLTRB(15, 10, 15, 30),
                child:Text('Note: This login signup system is persistent (created using provider) means once a user is logged in he did not need to login again until the logout button is pressed. ',style: TextStyle(color:Colors.black,),),
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
                         final authProvider =Provider.of<Authenticate>(context, listen: false);
                        authProvider.logout();
                          Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => Login()),
                        );
                          },
                          child: const Text(
                            "Log Out",
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
    );
  }
}