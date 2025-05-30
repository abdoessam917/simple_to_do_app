import 'package:flutter/material.dart';
import 'package:simple_to_do_app/theme/app_theme.dart';

import '../models/task.dart';

class TaskListScreen extends StatefulWidget {
  final VoidCallback onThemeChanged;

  const TaskListScreen({super.key, required this.onThemeChanged});

  @override
  State<TaskListScreen> createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  TextEditingController textController = TextEditingController();
  List<Task> tasks = [
    Task(title: "Learn Flutter Basics", isCompleted: true),
    Task(title: "Build a Simple App", isCompleted: true),
    Task(title: "Publish to GitHub", isCompleted: true),
    Task(title: "Share with friends"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            color: AppTheme.isDarkMode ? Colors.grey : Colors.yellow,
            icon: Icon(
              AppTheme.isDarkMode ? Icons.dark_mode : Icons.light_mode,
            ),
            onPressed: () {
              widget.onThemeChanged();
            },
          ),
        ],
        title: const Text('My Tasks'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: textController,
                    decoration: InputDecoration(
                      hintText: 'Add a new task',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      if (textController.text.isNotEmpty) {
                        tasks.add(Task(title: textController.text));
                        textController.clear();
                      }
                    });
                  },
                  child: const Icon(Icons.add),
                ),
              ],
            ),
          ),
          Expanded(
            child:
                tasks.isEmpty
                    ? Center(child: Text("No tasks available"))
                    : ListView.builder(
                      itemBuilder: (context, index) {
                        return ListTile(
                          onTap: () {
                            setState(() {
                              tasks[index].isCompleted =
                                  !tasks[index].isCompleted;
                            });
                          },
                          leading: GestureDetector(
                            onTap: () {
                              setState(() {
                                tasks[index].isCompleted =
                                    !tasks[index].isCompleted;
                              });
                            },
                            child: Icon(
                              tasks[index].isCompleted
                                  ? Icons.check_box
                                  : Icons.check_box_outline_blank,
                              color:
                                  tasks[index].isCompleted
                                      ? Colors.green
                                      : Colors.grey,
                            ),
                          ),
                          title:
                              tasks[index].isCompleted
                                  ? Text(
                                    tasks[index].title,
                                    style: const TextStyle(
                                      decoration: TextDecoration.lineThrough,
                                    ),
                                  )
                                  : Text(tasks[index].title),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                                onPressed: () {
                                  setState(() {
                                    tasks.removeAt(index);
                                  });
                                },
                              ),
                            ],
                          ),
                        );
                      },
                      itemCount: tasks.length,
                    ),
          ),
        ],
      ),
    );
  }
}
