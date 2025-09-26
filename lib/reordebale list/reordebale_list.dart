import 'package:flutter/material.dart';

import 'model/task_model.dart';

class ReordebaleList extends StatefulWidget {
  const ReordebaleList({super.key});

  @override
  State<ReordebaleList> createState() => _ReordebaleListState();
}

class _ReordebaleListState extends State<ReordebaleList> {
  Task? deletedTask;
  int? deletedIndex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Task Manager'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Task.tasks.isEmpty
          ? const Center(child: Text('No tasks available'))
          : ReorderableListView.builder(
              itemCount: Task.tasks.length,
              onReorder: (oldIndex, newIndex) {
                setState(() {
                  if (oldIndex < newIndex) newIndex--;
                  final task = Task.tasks.removeAt(oldIndex);
                  Task.tasks.insert(newIndex, task);
                });
              },
              itemBuilder: (context, index) {
                final task = Task.tasks[index];
                return Dismissible(
                  key: Key(task.id),
                  direction: DismissDirection.endToStart,
                  confirmDismiss: (direction) => _showDeleteDialog(),
                  onDismissed: (direction) => _deleteTask(index),
                  background: Container(
                    alignment: Alignment.centerRight,
                    color: Colors.red,
                    padding: const EdgeInsets.only(right: 20),
                    child: const Icon(Icons.delete, color: Colors.white),
                  ),
                  child: Card(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    child: ListTile(
                      leading: Checkbox(
                        value: task.isCompleted,
                        onChanged: (value) {
                          setState(() {
                            task.isCompleted = value ?? false;
                          });
                        },
                      ),
                      title: Text(
                        task.title,
                        style: TextStyle(
                          decoration: task.isCompleted
                              ? TextDecoration.lineThrough
                              : null,
                        ),
                      ),
                      trailing: const Icon(Icons.drag_handle),
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addTask,
        child: const Icon(Icons.add),
      ),
    );
  }

  Future<bool?> _showDeleteDialog() {
    return showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Task'),
        content: const Text('Are you sure you want to delete this task?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  void _deleteTask(int index) {
    setState(() {
      deletedTask = Task.tasks[index];
      deletedIndex = index;
      Task.tasks.removeAt(index);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Task "${deletedTask!.title}" deleted'),
        action: SnackBarAction(label: 'Undo', onPressed: _undoDelete),
      ),
    );
  }

  void _undoDelete() {
    if (deletedTask != null && deletedIndex != null) {
      setState(() {
        Task.tasks.insert(deletedIndex!, deletedTask!);
        deletedTask = null;
        deletedIndex = null;
      });
    }
  }

  void _addTask() {
    setState(() {
      Task.tasks.add(
        Task(
          id: DateTime.now().toString(),
          title: 'New Task ${Task.tasks.length + 1}',
        ),
      );
    });
  }
}
