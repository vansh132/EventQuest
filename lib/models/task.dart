import 'dart:io';

class Task {
  final String taskTitle;
  final String taskDescription;
  final String taskType;
  final String assignedTo;
  final String assignedBy;
  File? file;
  String? remarks;
  final String taskStatus;
  Task({
    required this.taskTitle,
    required this.taskDescription,
    required this.taskType,
    required this.assignedTo,
    required this.assignedBy,
    this.file,
    this.remarks,
    required this.taskStatus,
  });
}
