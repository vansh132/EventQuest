import 'dart:io';

class Task {
  final String taskTitle;
  final String taskDescription;
  final String taskType;
  final String assignedTo;
  final String assignedBy;
  File? file;
  String? remarks;
  final bool taskStatus;

  Task({required this.taskTitle, required this.taskDescription,  this.remarks, required this.taskType, required this.assignedTo, required this.assignedBy, required this.taskStatus});



}
