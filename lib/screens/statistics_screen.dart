import 'package:flutter/material.dart';
import '../models/task.dart';

class StatisticsScreen extends StatelessWidget {
  final List<Task> tasks;

  const StatisticsScreen({super.key, required this.tasks});

  @override
  Widget build(BuildContext context) {
    final completedTasks = tasks.where((task) => task.isCompleted).length;
    final totalTasks = tasks.length;
    final completionRate = totalTasks > 0 ? completedTasks / totalTasks : 0.0;

    return Scaffold(
      body: _buildListLayout(
        context,
        completedTasks,
        totalTasks,
        completionRate,
      ),
    );
  }

  Widget _buildListLayout(
      BuildContext context,
      int completedTasks,
      int totalTasks,
      double completionRate,
      ) {
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        _buildStatCard(
          context,
          'Total Tasks',
          totalTasks.toString(),
          Icons.task,
          Colors.blue,
        ),
        const SizedBox(height: 16),
        _buildStatCard(
          context,
          'Completed',
          completedTasks.toString(),
          Icons.check_circle,
          Colors.green,
        ),
        const SizedBox(height: 16),
        _buildStatCard(
          context,
          'Pending',
          (totalTasks - completedTasks).toString(),
          Icons.pending,
          Colors.orange,
        ),
        const SizedBox(height: 16),
        _buildStatCard(
          context,
          'Completion Rate',
          '${(completionRate * 100).toStringAsFixed(1)}%',
          Icons.pie_chart,
          Colors.purple,
        ),
      ],
    );
  }

  Widget _buildStatCard(
      BuildContext context,
      String title,
      String value,
      IconData icon,
      Color color,
      ) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40, color: color),
            const SizedBox(height: 8),
            Text(title, style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 4),
            Text(
              value,
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                color: color,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}