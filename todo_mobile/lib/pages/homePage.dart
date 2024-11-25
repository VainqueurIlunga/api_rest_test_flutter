// ignore_for_file: empty_statements

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_mobile/models/task.dart';
import 'package:todo_mobile/provider/task.dart';
//import 'package:todo_mobile/provider/task.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    final taskProvider = Provider.of<TaskProvider>(context, listen: false);
    taskProvider.fetchTasks(); //recuperation initiale de données
  }

  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<TaskProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Consumer<TaskProvider>(builder: (context, provider, child) {
        if (provider.tasks.isEmpty) {
          return const Center(
            child: CircularProgressIndicator.adaptive(),
          );
        } else {
          return ListView.builder(
            itemCount: provider.tasks.length,
            itemBuilder: (context, index) {
              final task = provider.tasks[index];
              return ListTile(
                title: Text(task.task),
              );
            },
          );
        }
      }),
    );
  }
}
