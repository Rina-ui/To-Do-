import 'package:flutter/material.dart';

class Updatetask extends StatefulWidget {
  const Updatetask({super.key});

  @override
  State<Updatetask> createState() => _UpdatetaskState();
}

class _UpdatetaskState extends State<Updatetask> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

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
                onPressed: () {

                },
                icon: Icon(Icons.save),
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
    );;
  }
}
