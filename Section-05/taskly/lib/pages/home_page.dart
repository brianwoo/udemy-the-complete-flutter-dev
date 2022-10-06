import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:taskly/models/task.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late double _deviceHeight, _deviceWidth;

  String? _newTaskContent;
  // Box? _box;
  Future<Box>? _boxFuture;
  Box? _box;

  @override
  void initState() {
    super.initState();
    _openbox();
  }

  void _openbox() {
    if (!Hive.isBoxOpen("tasks")) {
      _boxFuture = Hive.openBox("tasks");
      _boxFuture!.then((box) => _box = box);
    }
  }

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: _deviceHeight * 0.15,
        title: const Text(
          "Taskly",
          style: TextStyle(fontSize: 25.0),
        ),
      ),
      body: _tasksView(),
      floatingActionButton: _addTaskButton(),
    );
  }

  Widget _addTaskButton() {
    return FloatingActionButton(
      onPressed: () => _displayTaskPopup(),
      child: const Icon(Icons.add),
    );
  }

  void _displayTaskPopup() {
    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: const Text("Add New Task!"),
          content: TextField(
            onSubmitted: (value) {
              if (_newTaskContent != null) {
                var task = Task(
                  content: _newTaskContent!,
                  timestamp: DateTime.now(),
                  done: false,
                );
                setState(() {
                  _box!.add(task.toMap());
                  Navigator.pop(context);
                  _newTaskContent = null;
                });
              }
            },
            onChanged: (value) {
              _newTaskContent = value;
            },
          ),
        );
      },
    );
  }

  Widget _tasksView() {
    return FutureBuilder(
      future: _boxFuture,
      builder: (ctx, snapshot) {
        if (snapshot.hasData) {
          Box? box = snapshot.data;
          return _tasksList(box);
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget _tasksList(Box? box) {
    // Task newTask =
    //     Task(content: 'Go to Gym', done: false, timestamp: DateTime.now());
    // _box?.add(newTask.toMap());
    List tasks = box!.values.toList();
    return ListView.builder(
      itemCount: tasks.length,
      itemBuilder: (BuildContext context, int index) {
        var task = Task.fromMap(tasks[index]);
        return ListTile(
          title: Text(
            task.content,
            style: TextStyle(
              decoration:
                  task.done ? TextDecoration.lineThrough : TextDecoration.none,
            ),
          ),
          subtitle: Text(task.timestamp.toString()),
          trailing: Icon(
            task.done
                ? Icons.check_box_outlined
                : Icons.check_box_outline_blank_outlined,
            color: Colors.red,
          ),
          onTap: () {
            setState(() {
              task.done = !task.done;
              box.putAt(index, task.toMap());
            });
          },
          onLongPress: () {
            setState(() {
              box.deleteAt(index);
            });
          },
        );
      },
    );
  }
}
