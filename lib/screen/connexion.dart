import 'package:flutter/material.dart';
import 'package:todo_flutter_app/screen/home.dart';
import 'inscription.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Connexion extends StatefulWidget {
  const Connexion({super.key});

  @override
  State<Connexion> createState() => _ConnexionState();
}

class _ConnexionState extends State<Connexion> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  //function to login
  Future<void> login() async{
    final url = Uri.parse('http://10.0.2.2:3000/api/user/login');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'username': usernameController.text,
        'password': passwordController.text,
      }),
    );

    if(response.statusCode == 200){
      final data = jsonDecode(response.body);
      print('Login successful: $data');

      Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Home())
      );
    }else if (response.statusCode == 404) {
      //if user not create his account
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('User not found'),
            content: Text('User not found. Please create your account'),
            actions: [
              TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text('Cancel')
              ),

              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Inscription()),
                  );
                },
                child: Text('Register'),
              )

            ]
          )
      );
    }
    else{
      print('Login failed: ${response.statusCode}');
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Login failed'),
            content: Text('Login failed. Please check your username and password and verified yours informations'),
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
                  Text("Login",
                    style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0,
                        color: Colors.black,
                        fontFamily: 'Poppins',
                        fontStyle: FontStyle.italic
                    ),
                  ),
                  SizedBox(height: 20),
                  TextField(
                    controller: usernameController,
                    decoration: InputDecoration(
                      hintText: "Username",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
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

                  SizedBox(height: 20,),

                  ElevatedButton(
                      onPressed: () => {
                        Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Home())
                        )
                      },
                      child: Text("Login")
                  ),

                  SizedBox(height: 10,),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Don't have an account?"),
                      SizedBox(width: 5,),
                      GestureDetector(
                          onTap: () =>
                          {
                            Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => Inscription())
                            )
                          },
                          child: Text("Register",
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
