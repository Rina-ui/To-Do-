import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class Screentask extends StatefulWidget {
  const Screentask({super.key});

  @override
  State<Screentask> createState() => _ScreentaskState();
}

class _ScreentaskState extends State<Screentask> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

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
          'description': description
        }),
      );

      if(response.statusCode == 200 || response.statusCode == 201){
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Task added successfully'))
        );
        Navigator.pop(context);
      }else{
        print('Failed to add task: ${response.statusCode} ${response.body}');
        showDialog(
            context: context,
            builder: (_) => AlertDialog(
              title: Text('Error'),
              content: Text('Impossible to add task'),
              actions: [
                TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text('OK')
                )
              ],
            )
        );
      }
    }catch(e){
      print('Error adding task: $e');
      showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title: Text('Error'),
            content: Text('Error of server'),
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
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                onPressed: () {
                  final title = titleController.text;
                  final description = descriptionController.text;

                  if (title.isEmpty || description.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Please fill in all fields'))
                    );
                    return;
                  }
                    addTask(title, description, 'token');
                },
                icon: Icon(Icons.save),
                label: Text('Save'),
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
