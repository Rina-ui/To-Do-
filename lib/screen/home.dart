import 'dart:io';

import 'package:flutter/material.dart';
import 'package:todo_flutter_app/screen/screenTask.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

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
                      MaterialPageRoute(builder: (context) => Screentask())
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
