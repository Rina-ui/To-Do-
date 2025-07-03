import 'package:flutter/material.dart';
import 'package:todo_flutter_app/screen/connexion.dart';

class Inscription extends StatefulWidget {
  const Inscription({super.key});

  @override
  State<Inscription> createState() => _InscriptionState();
}

class _InscriptionState extends State<Inscription> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

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
                            MaterialPageRoute(builder: (context) => Inscription())
                        )
                      },
                      child: Text("Register")
                  ),

                  SizedBox(height: 10,),

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
