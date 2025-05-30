import 'package:flutter/material.dart';
import '../main.dart';
import '../models/task.dart';
import '../services/task_service.dart';
import '../widgets/task_list_item.dart';
import '../widgets/add_task_dialog.dart';
import '../widgets/app_drawer.dart';
import 'statistics_screen.dart';

class TaskListScreen extends StatefulWidget {
  final VoidCallback onThemeChanged;

  const TaskListScreen({super.key, required this.onThemeChanged});

  @override
  State<TaskListScreen> createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  int _selectedIndex = 0;
  TextEditingController textController = TextEditingController();
  List<Task> tasks = TaskService.getInitialTasks();

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(
        selectedIndex: _selectedIndex,
        onItemSelected: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        taskCount: tasks.length,
      ),
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(
              MyApp.isDarkModeEnabled ? Icons.light_mode : Icons.dark_mode,
            ),
            onPressed: widget.onThemeChanged,
          ),
        ],
        centerTitle: true,
        title: const Text('My Tasks'),
      ),
      body: _selectedIndex == 0
          ? _buildTasksList()
          : StatisticsScreen(tasks: tasks),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.list), label: 'Tasks'),
          BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: 'Statistics'),
        ],
      ),
    );
  }

  Widget _buildTasksList() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: textController,
                  decoration: const InputDecoration(
                    hintText: 'Add a new task',
                    prefixIcon: Icon(Icons.add_task),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              ElevatedButton(
                onPressed: _showAddTaskDialog,
                child: const Icon(Icons.add, color: Colors.white),
              ),
            ],
          ),
        ),
        Expanded(
          child: tasks.isEmpty
              ? const Center(child: Text("No tasks available"))
              : ListView.builder(
            itemCount: tasks.length,
            itemBuilder: (context, index) {
              return TaskListItem(
                task: tasks[index],
                onToggle: () {
                  setState(() {
                    tasks[index].isCompleted = !tasks[index].isCompleted;
                  });
                },
                onDelete: () {
                  setState(() {
                    tasks.removeAt(index);
                  });
                },
              );
            },
          ),
        ),
      ],
    );
  }

  void _showAddTaskDialog() {
    if (textController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a task title')),
      );
      return;
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AddTaskDialog(
          initialTitle: textController.text,
          onTaskAdded: (Task newTask) {
            setState(() {
              tasks.add(newTask);
              textController.clear();
            });
          },
        );
      },
    );
  }
}