import 'package:flutter/material.dart';
import 'package:notes/palette.dart';
import 'package:notes/animated_page.dart';
import 'package:notes/task_model.dart';


void main() {
  return runApp(
    MaterialApp(
      home: HomePage(),
      title: 'Notes',
    )
  );
}


class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);
  List<Task> tasks = <Task>[
    Task(title: 'Hello', subtitle: 'Hello'),
    Task(title: 'Hello', subtitle: 'Hi')
  ];

  @override
  State createState() => _HomePageState();
}


class _HomePageState extends State<HomePage>{

  void _createState() {
    setState(() {
      
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Notes', 
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
          ),
          ),
        centerTitle: true,
        backgroundColor: colors['AppBar'],
        foregroundColor: colors['TextColor'],
      ),
      body: PageBody(
        tasks: widget.tasks,
      ),
    );
  }
}


