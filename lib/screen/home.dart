import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  Future<void> addTask(String title, String description, String token) async{
    final url = Uri.parse('http://10.0.2.2:3000/api/task');

    try{
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token'
        },
        body: jsonEncode({
          'title': title,
          'descritption': description
        }),
      );

      if(response.statusCode == 200 || response.statusCode == 201){
        print('Task added successfully');
      }else{
        print('Failed to add task: ${response.body}');
      }
    }catch(e){
      print('Error adding task: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('DoNote',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
            letterSpacing: 0,
            color: Colors.black,
            fontFamily: 'Poppins',
          ),
          ),
      ),
      body: Padding(
          padding: EdgeInsets.all(20),
        child: Column(
          children: [
            ElevatedButton(
                onPressed: () => {
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Home())
                  )
                },
                child: Text('Add a task')
            )
          ],
        ),
      )
    );
  }
}
