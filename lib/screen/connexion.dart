import 'package:flutter/material.dart';
import 'package:todo_flutter_app/screen/home.dart';
import 'inscription.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class Connexion extends StatefulWidget {
  const Connexion({super.key});

  @override
  State<Connexion> createState() => _ConnexionState();
}

class _ConnexionState extends State<Connexion> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isLoading = false;

  //function to login
  Future<void> login() async{
    final username = usernameController.text.trim();
    final password = passwordController.text.trim();

    if (username.isEmpty || password.isEmpty){
      _showError('Please enter a username and password');
      return;
    }
    setState( () => isLoading = true);
    try {
      final url = Uri.parse('http://10.0.2.2:3000/api/user/login');
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'username': username,
          'password': password,
        }),
      );

      if (response.statusCode == 200 || response.statusCode == 201){
        final data = jsonDecode(response.body);
        final token = data['token'] as String?;

        if (token == null){
          _showError('Login successful but not receive token');
        }else{
          //stocker le token
          final prefs = await SharedPreferences.getInstance();
          await prefs.setString('jwt_token', token);

          // Navigate to Home
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => Home()),
          );
        }
      }else if (response.statusCode == 401 || response.statusCode == 404) {
        _showLoginNotFoundDialog();
      } else {
        _showError('Erreur serveur (${response.statusCode})');
      }
    }catch (e, stack) {
    print('Login exception: $e');
    print(stack);
    _showError('Erreur : $e');
    } finally {
    setState(() => isLoading = false);
    }
    }

  void _showError(String message) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Erreur'),
        content: Text(message),
        actions: [TextButton(onPressed: () => Navigator.pop(context), child: Text('OK'))],
      ),
    );
  }

  void _showLoginNotFoundDialog() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('User not found'),
        content: Text("Account don't correspond to any user."),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: Text('Cancel')),
          TextButton(
            onPressed: () {
              Navigator.pop(context); // ferme le dialog
              Navigator.push(context, MaterialPageRoute(builder: (_) => Inscription()));
            },
            child: Text('Register'),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
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
                  SizedBox(height: 10),
                  TextField(
                    controller: usernameController,
                    decoration: InputDecoration(
                      hintText: "Username",
                      prefixIcon: Icon(Icons.person),
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
                      prefixIcon: Icon(Icons.lock),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),

                  SizedBox(height: 10,),

                  isLoading
                      ? CircularProgressIndicator()
                      : ElevatedButton.icon(
                      onPressed: login,
                      icon: Icon(Icons.login),
                      label: Text('Login'),
                  ),

                  SizedBox(height: 5,),

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
