import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_flutter_app/screen/screenTask.dart';

import '../pages/task.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  //function to get tasks
  Future<List<Task>> getTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('jwt_token') ?? '';
    final url = Uri.parse('http://10.0.2.2:3000/api/task');

    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      }
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      final List jsonList = jsonDecode(response.body) as List;
      // Convert the JSON list to a list of Task objects
      return jsonList.map((e) => Task.fromJson(e)).toList();
    }else {
      throw Exception('Failed to load tasks');
    }
  }

  // function to delete task
  Future<void> deleteTask(String taskId) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('jwt_token');
    final url = Uri.parse('http://10.0.2.2:3000/api/task/:id');

    final res = await http.delete(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      }
    );

    if (res.statusCode == 200 || res.statusCode == 201){
      //refresh the list
      setState(() {});
    }else{
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Deleting error'))
      );
    }
  }

  // function to edit task


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
            ),

            SizedBox(height: 20),

            Expanded(
                child: FutureBuilder<List<Task>>(
                  future: getTasks(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    if (snapshot.hasError) {
                      return Center(
                        child: Text('Error: ${snapshot.error}'),
                      );
                    }
                    final tasks = snapshot.data!;
                    if (tasks.isEmpty) {
                      return Center(
                        child: Text('Nothing task'),
                      );
                    }
                    return ListView.builder(
                        itemCount: tasks.length,
                        itemBuilder: (context, index) {
                          final task = tasks[index];
                          return ListTile(
                            title: Text(task.title),
                            subtitle: Text(task.description),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                    onPressed: () => {},
                                    icon: Icon(Icons.edit)
                                ),
                                IconButton(
                                    onPressed: () => {},
                                    icon: Icon(Icons.delete)
                                )
                              ],
                            )
                          );
                        }
                    );
                  },
                )
            )
          ],
        ),
      )
    );
  }
}
