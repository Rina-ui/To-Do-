import 'package:flutter/material.dart';
import 'package:todo_flutter_app/screen/connexion.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'home.dart';

class Inscription extends StatefulWidget {
  const Inscription({super.key});

  @override
  State<Inscription> createState() => _InscriptionState();
}

class _InscriptionState extends State<Inscription> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  //function to register
  Future<void> register() async {
    final url = Uri.parse('http://10.0.2.2:3000/api/user/register');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'username': usernameController.text,
        'password': passwordController.text,
      })
    );

    if (response.statusCode == 200 || response.statusCode == 201){
      final data = jsonDecode(response.body);
      print ('Registration successful: $data');

      Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Home())
      );
    }else{
      print('Registration failded: ${response.statusCode}');
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Resgistration failed'),
            content: Text('Registration failed. Please try again'),
            actions: [
              TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text('OK')
              )
            ],
          )
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [
                    Color(0xFFcaf0f8),
                    Color(0xFFFFFFFF),
                    Color(0xFFcaf0f8),
                  ],
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft
              )
            ),
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Register',
                    style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0,
                        color: Colors.black,
                        fontFamily: 'Poppins',
                        fontStyle: FontStyle.italic
                    ),
                  ),

                  SizedBox(height: 10),

                  TextField(
                    controller: usernameController,
                    decoration: InputDecoration(
                      hintText: "Username",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),

                  SizedBox(height: 10),

                  TextField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: "Password",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),

                  SizedBox(height: 10,),

                  ElevatedButton(
                      onPressed: register,
                      child: Text("Register")
                  ),

                  SizedBox(height: 5,),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("You have an account?"),
                      SizedBox(width: 5,),
                      GestureDetector(
                          onTap: () =>
                          {
                            Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => Connexion())
                            )
                          },
                          child: Text("Login",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.blueAccent,
                            ),
                          )
                      )
                    ],
                  )
                ],
              ),
            ),
          )
      ),
    );
  }
}
