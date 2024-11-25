import 'dart:math';

import 'package:dio/dio.dart';
import 'package:todo_mobile/models/task.dart';

class ApiService {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: 'http://172.20.10.3:8080',
      headers: {
        "content-type": "application/json",
      },
    ),
  );
  // get tasks
  Future<List<TaskModel>> getTask() async {
    try {
      final response = await _dio.get('/todo/task');
      return (response.data as List)
          .map((task) => TaskModel.fromJson(task))
          .toList();
    } catch (e) {
      print(e);
      return [];
    }
  }

  // add task
  Future<TaskModel> addTask(TaskModel task) async {
    try {
      final response = await _dio.post('/todo/task', data: task.toJson());
      return TaskModel.fromJson(response.data);
    } catch (e) {
      print(e);
      return TaskModel(
        id: Random().nextInt(100000),
        task: task.task,
        done: false,
        created_at: DateTime.now().toString(),
      );
    }
  }

  // update task
  Future<void> updateTask(TaskModel task) async {
    try {
      await _dio.put('/todo/task/${task.id}', data: task.toJson());
    } catch (e) {
      print(e);
    }
  }

  // delete task
  Future<void> deleteTask(TaskModel task) async {
    await _dio.delete('/todo/task/${task.id}');
  }
}
