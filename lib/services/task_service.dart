import '../models/task.dart';

class TaskService {
  static List<Task> getInitialTasks() {
    return [
      Task(
        title: "Learn Flutter Basics",
        isCompleted: true,
        category: "Learning",
        description:
        "Complete the Flutter basics tutorial and understand widgets, state management, and navigation.",
      ),
      Task(
        title: "Build a Simple App",
        isCompleted: true,
        category: "Development",
        description:
        "Create a simple to-do app to practice Flutter development skills.",
      ),
      Task(
        title: "Publish to GitHub",
        isCompleted: true,
        category: "Development",
        description:
        "Upload the completed project to GitHub repository with proper documentation.",
      ),
      Task(
        title: "Share with friends",
        isCompleted: false,
        category: "Social",
        description: "Show the completed app to friends and get their feedback.",
      ),
    ];
  }
}