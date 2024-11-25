import 'package:flutter/material.dart';
import 'package:todo_mobile/models/task.dart';
import 'package:todo_mobile/service/api.dart';

class TaskProvider with ChangeNotifier {
  final ApiService _apiService = ApiService();

  List<TaskModel> _tasks = [];

  List<TaskModel> get tasks => _tasks;

  Future<void> fetchTasks() async {
    _tasks = await _apiService.getTask();
    notifyListeners();
  }

  Future<void> addTask(TaskModel task) async {
    await _apiService.addTask(task);
    notifyListeners();
  }

  Future<void> updateTask(TaskModel task) async {
    await _apiService.updateTask(task);
    notifyListeners();
  }

  Future<void> deleteTask(TaskModel task) async {
    await _apiService.deleteTask(task);
    notifyListeners();
  }
}
