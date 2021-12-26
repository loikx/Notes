import 'package:flutter/material.dart';
import 'package:notes/palette.dart';
import 'package:notes/popup_form.dart';


class PageBody extends StatefulWidget {
  const PageBody(
    {required this.tasks, 
    Key? key}) : super(key: key);

  final List tasks;

  @override
  State<StatefulWidget> createState() => _PageBodyState();
}



class _PageBodyState extends State<PageBody> {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();

  Text _createTitle(int index){
    return Text(
      widget.tasks[index].getTitle(),
        style: TextStyle(
          color: colors['TextColor'],
          fontSize: 26,
        ),
    );
  }

  Text _createSubtitle(int index) {
    return Text(
        widget.tasks[index].getSubtitle(),
        style: TextStyle(
          color: colors['TextColor'],
          fontSize: 20,
        ),
    );
  }

  void _removeItem(int index) {
    widget.tasks.removeAt(index);
    _listKey.currentState!.removeItem(
      index, (context, animation) 
      => _buildItem(context, widget.tasks.length - 1, animation),
      duration: const Duration(milliseconds: 500),
      );
  }


  void _createItem(int index) {
    _listKey.currentState!.insertItem(index, duration: const Duration(milliseconds: 500));
  }


  IconButton _doneButton(int index) {
    return IconButton(
      icon: Icon(
        Icons.check, 
        color: colors['IconCheck'], 
        size: 32,
        ),
        onPressed: () {
          _removeItem(index);
        },
    );
  }

  IconButton _deleteButton(int index) {
    return IconButton(
      icon: const Icon(
        Icons.delete, 
        color: Colors.red, 
        size: 32,
        ),
        onPressed: () {
          _removeItem(index);
        },
    );
  }

  Widget _createCard(int index, double height) {
    return SizedBox(
      height: height,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        color: colors['Tile'],
        child: Center(
          child: ListTile(
            title: _createTitle(index),
            subtitle: _createSubtitle(index),
            leading: _doneButton(index),
            trailing: _deleteButton(index),
          ),
        ),
      ),
    );
  }


  Widget _createTile(int index, Animation<double> animation, double height) {
    return Padding(
      child: SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(-1, 0),
          end: Offset(0, 0),
          ).animate(animation),
          child: _createCard(index, height),
        ),
      padding: const EdgeInsets.all(7.5)
    );
  }

  Widget _buildItem(BuildContext context, int index, Animation<double> animation) {
    double height = MediaQuery.of(context).size.height * 0.15;
    return Container(
      child: (widget.tasks.isNotEmpty) 
      ? _createTile(index, animation, height) 
      : null);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Stack(
      alignment: Alignment.topCenter,
      children: <Widget>[
        AnimatedList(
          key: _listKey,
          itemBuilder: _buildItem,
          padding: const EdgeInsets.all(10),
          initialItemCount: widget.tasks.length,
          shrinkWrap: true,
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: FloatingActionButton(
            child: const Icon(Icons.add, size: 32,),
            backgroundColor: colors['AppBar'],
            onPressed: () {
              showDialog(
                context: context, 
                builder: (BuildContext context) => 
                TaskForm(tasks: widget.tasks, refresh: _createItem,),
              );
            },
          ),
        ),
      ],
    ),
    );
  }
}
