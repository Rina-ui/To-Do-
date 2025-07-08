import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../pages/task.dart';

class Updatetask extends StatefulWidget {
  final Task task;
  const Updatetask({super.key, required this.task});

  @override
  State<Updatetask> createState() => _UpdatetaskState();
}

class _UpdatetaskState extends State<Updatetask> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  void initState(){
    super.initState();
    titleController.text = widget.task.title;
    descriptionController.text = widget.task.description;
  }

  Future<void> updateTask() async {
    final url = Uri.parse('http://10.0.2.2:3000/api/task/${widget.task.id}');
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('jwt_token');

    final res = await http.put(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({
        'title': titleController.text,
        'description': descriptionController.text,
      }),
    );

    if (res.statusCode == 200 || res.statusCode == 201) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Task updated successfully')),
      );
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Updating task failed')),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar: AppBar(
          title: Text('Add a task'),
        ),
        body: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: titleController,
                decoration: InputDecoration(
                    labelText: 'Title',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    prefixIcon: Icon(Icons.title)
                ),
              ),

              SizedBox(height: 10),

              TextField(
                controller: descriptionController,
                decoration: InputDecoration(
                  labelText: 'Description',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  prefixIcon: Icon(Icons.description),
                ),
                minLines: 3,
                maxLines: 6,
              ),

              SizedBox(height: 5),

              ElevatedButton.icon(
                onPressed: () => updateTask(),
                icon: Icon(Icons.save_as_rounded),
                label: Text('Modify'),
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(20, 45),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              )
            ],
          ),
        )
    );
  }
}
