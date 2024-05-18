import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:taskly/models/Task.dart';

class HomePage extends StatefulWidget {
  HomePage();

  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  late double _deviceHeight, _deviceWidth;
  String? _newTaskContent;
  Box? _box;

  _HomePageState();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: _deviceHeight * 0.15,
        backgroundColor: Colors.red,
        title: const Text(
          "Taskly",
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.w700),
        ),
      ),
      body: _taskView(),
      floatingActionButton: _addTask(),
    );
  }

  Widget _taskView() {
    Hive.openBox('tasks');
    return FutureBuilder(
        future: Hive.openBox('tasks'),
        builder: (BuildContext _context, AsyncSnapshot _snapshot) {
          if (_snapshot.hasData) {
            _box = _snapshot.data;
            return _taskList();
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }

  Widget _taskList() {
    // Task _newTask =
    //     Task(content: "Aller à la salle", timeStamp: DateTime.now(), done: false);
    // _box?.add(_newTask.toMap());
    List tasks = _box!.values.toList();
    return ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (BuildContext _context, int _index) {
          var task = Task.fromMap(tasks[_index]);
          return ListTile(
            title: Text(
              task.content,
              style: TextStyle(
                  decoration: task.done ? TextDecoration.lineThrough : null),
            ),
            subtitle: Text(task.timeStamp.toString()),
            trailing: Icon(
              task.done
                  ? Icons.check_box_outlined
                  : Icons.check_box_outline_blank_outlined,
              color: task.done ? Colors.green : Colors.red,
            ),
            onTap: () {
              task.done = !task.done;
              _box!.putAt(_index, task.toMap());
              setState(() {});
            },
            onLongPress: () {
              _box!.deleteAt(_index);
              setState(() {});
            },
          );
        });
  }

  Widget _addTask() {
    return FloatingActionButton(
      onPressed: _displayTaskPopup,
      backgroundColor: Colors.green,
      child: const Icon(Icons.add),
    );
  }

  void _displayTaskPopup() {
    showDialog(
        context: context,
        builder: (BuildContext _context) {
          return AlertDialog(
            title: const Text("Ajouter une nouvelle tâche"),
            content: TextField(
              onSubmitted: (value) {
                if (_newTaskContent != null) {
                  var task = Task(
                      content: _newTaskContent!,
                      timeStamp: DateTime.now(),
                      done: false);
                  _box!.add(task.toMap());
                  setState(() {
                    _newTaskContent = null;
                    Navigator.pop(context);
                  });
                }
              },
              onChanged: (inputValue) {
                setState(() {
                  _newTaskContent = inputValue;
                });
              },
            ),
          );
        });
  }
}
