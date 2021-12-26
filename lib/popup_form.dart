import 'package:flutter/material.dart';
import 'package:notes/palette.dart';
import 'package:notes/task_model.dart';


class TaskForm extends StatefulWidget {
  const TaskForm({
    required this.refresh, 
    required this.tasks, 
    Key? key}) : super(key: key);

  final Function refresh;
  final List tasks;

  @override
  State createState() => _TaskFormState();
}


class _TaskFormState extends State<TaskForm> {
  final titleController = TextEditingController();
  final subtitleController = TextEditingController();
  static const sizedBox = SizedBox(height: 5);


  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    titleController.dispose();
    subtitleController.dispose();
    super.dispose();
  }


  Widget _createTextField(TextEditingController controller, String labelText) {
    return Padding(
      padding: const EdgeInsets.all(6.5),
      child:  TextField(
        controller: controller,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: colors['TextColor']!, width: 2.0),
            borderRadius: BorderRadius.circular(25.0),
          ),
          focusedBorder:OutlineInputBorder(
            borderSide: BorderSide(color: colors['TextColor']!, width: 2.0),
            borderRadius: BorderRadius.circular(25.0),
          ),
          labelText: labelText,
          labelStyle: TextStyle(
            color: colors['TextColor'],
            fontSize: 24,
            ),
          ),
        style: TextStyle(
          color: colors['TextColor'],
          fontSize: 24,
        ),
      ),
    );
  }

  void _creation(double width) {
    setState(() {
      String title = titleController.text;
      String subtitle = subtitleController.text;
      debugPrint(width.toString());
      debugPrint(title.length.toString());
      debugPrint(subtitle.length.toString());
      if (title.length * 19 <= width
      && subtitle.length  * 14 <= width) {
        Task task = Task(title: title, subtitle: subtitle);
        widget.tasks.add(task);
        widget.refresh(widget.tasks.length - 1);
      }
      titleController.clear();
      subtitleController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return AlertDialog(
      shape: const RoundedRectangleBorder(
        borderRadius:BorderRadius.all(Radius.circular(18.0))),
      title: Text(
        'Add new task',
        style: TextStyle(
          color: colors['TextColor'],
          fontSize: 32,
          ),
      ),
      content: Container(
        color: colors['Background'],
        height: height * 0.4,
        width: width * .7,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            sizedBox,
            _createTextField(titleController, 'Title'),
            sizedBox,
            _createTextField(subtitleController, 'Subtitle'),
            sizedBox,
            // TODO: переписать в elevated button
            RaisedButton(
              onPressed: () => _creation(width),
              color: Colors.white,
              child: Text(
                'Create',
                style: TextStyle(
                  color: colors['TextColor'],
                  fontSize: 26,
                ),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
                side: BorderSide(
                  color: colors['TextColor']!,
                  width: 2.0
                  ),
              ),
              ),
            ],
          ),
        )
      );
    }
} 
