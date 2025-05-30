import 'package:flutter/material.dart';
import '../models/task.dart';
import '../widgets/task_list_item.dart';
import '../widgets/task_grid_item.dart';
import '../widgets/task_input.dart';
import '../widgets/task_stats.dart';
import '../widgets/custom_drawer.dart';
import '../widgets/add_task_dialog.dart';
import 'task_detail_screen.dart';

class TaskListScreen extends StatefulWidget {
  const TaskListScreen({super.key});

  @override
  State<TaskListScreen> createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  TextEditingController textController = TextEditingController();
  List<Task> tasks = [
    Task(title: "Learn Flutter Basics", isCompleted: true, category: "Work"),
    Task(title: "Build a Simple App", isCompleted: true, category: "Work"),
    Task(title: "Publish to GitHub", isCompleted: true, category: "Work"),
    Task(title: "Share with friends", category: "Personal"),
  ];

  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    // Use MediaQuery to make UI responsive
    final screenWidth = MediaQuery.of(context).size.width;
    final isLargeScreen = screenWidth > 600;

    return Scaffold(
      appBar: AppBar(title: const Text('My Tasks')),
      drawer: const CustomDrawer(),
      body: Column(
        children: [
          // Task input
          TaskInput(
            controller: textController,
            onSubmit: () {
              if (textController.text.isNotEmpty) {
                setState(() {
                  tasks.add(Task(title: textController.text));
                  textController.clear();
                });
              }
            },
          ),

          // Task Stats
          TaskStats(
            total: tasks.length,
            completed: tasks.where((t) => t.isCompleted).length,
            pending: tasks.where((t) => !t.isCompleted).length,
          ),

          // Task list or grid based on screen size
          Expanded(
            child: isLargeScreen ? _buildGridView() : _buildListView(),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => AddTaskDialog(
              onTaskAdded: (task) {
                setState(() {
                  tasks.add(task);
                });
              },
            ),
          );
        },
        child: const Icon(Icons.add_task),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'List',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.grid_view),
            label: 'Grid',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }

  Widget _buildListView() {
    return ListView.builder(
      itemCount: tasks.length,
      itemBuilder: (context, index) {
        return TaskListItem(
          task: tasks[index],
          onTap: () {
            _navigateToTaskDetail(tasks[index]);
          },
          onStatusChanged: (value) {
            setState(() {
              tasks[index].isCompleted = value ?? false;
            });
          },
          onDelete: () {
            setState(() {
              tasks.removeAt(index);
            });
          },
        );
      },
    );
  }

  Widget _buildGridView() {
    return GridView.builder(
      padding: const EdgeInsets.all(8.0),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1.5,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: tasks.length,
      itemBuilder: (context, index) {
        return TaskGridItem(
          task: tasks[index],
          onTap: () {
            _navigateToTaskDetail(tasks[index]);
          },
          onStatusChanged: (value) {
            setState(() {
              tasks[index].isCompleted = value ?? false;
            });
          },
          onDelete: () {
            setState(() {
              tasks.removeAt(index);
            });
          },
        );
      },
    );
  }

  void _navigateToTaskDetail(Task task) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TaskDetailScreen(task: task),
      ),
    );

    if (result != null) {
      setState(() {
        // Task updated in the detail screen
      });
    }
  }
}