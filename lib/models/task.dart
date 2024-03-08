import 'dart:convert';
import 'dart:io';

class Task {
  String taskId;
  final String taskTitle;
  final String taskDescription;
  final String taskType;
  final String assignedTo;
  final String assignedBy;
  File? file;
  String? remarks;
  final bool taskStatus;

  Task(
      {this.taskId = '',
      required this.taskTitle,
      required this.taskDescription,
      required this.taskType,
      required this.assignedTo,
      required this.assignedBy,
      this.file,
      this.remarks,
      required this.taskStatus});

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'taskId': taskId});
    result.addAll({'taskTitle': taskTitle});
    result.addAll({'taskDescription': taskDescription});
    result.addAll({'taskType': taskType});
    result.addAll({'assignedTo': assignedTo});
    result.addAll({'assignedBy': assignedBy});
    if (file != null) {
      // result.addAll({'file': file!.toMap()});
    }
    if (remarks != null) {
      result.addAll({'remarks': remarks});
    }
    result.addAll({'taskStatus': taskStatus});

    return result;
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      taskId: map['taskId'] ?? '',
      taskTitle: map['taskTitle'] ?? '',
      taskDescription: map['taskDescription'] ?? '',
      taskType: map['taskType'] ?? '',
      assignedTo: map['assignedTo'] ?? '',
      assignedBy: map['assignedBy'] ?? '',
      // file: map['file'] != null ? File.fromMap(map['file']) : null,
      remarks: map['remarks'],
      taskStatus: map['taskStatus'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory Task.fromJson(String source) => Task.fromMap(json.decode(source));
}
