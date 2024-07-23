import 'dart:convert';

class Task {
  final String taskId;
  final String taskTitle;
  final String taskDescription;
  final String taskType;
  final String assignedTo;
  final String assignedBy;
  String? taskFile;
  String? remarks;
  final bool taskSubmission;
  final bool taskStatus;
  Task({
    this.taskId = '',
    required this.taskTitle,
    required this.taskDescription,
    required this.taskType,
    required this.assignedTo,
    required this.assignedBy,
    this.taskFile,
    this.remarks,
    required this.taskSubmission,
    required this.taskStatus,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'taskId': taskId});
    result.addAll({'taskTitle': taskTitle});
    result.addAll({'taskDescription': taskDescription});
    result.addAll({'taskType': taskType});
    result.addAll({'assignedTo': assignedTo});
    result.addAll({'assignedBy': assignedBy});
    if (taskFile != null) {
      result.addAll({'taskFile': taskFile});
    }
    if (remarks != null) {
      result.addAll({'remarks': remarks});
    }
    result.addAll({'taskSubmission': taskSubmission});
    result.addAll({'taskStatus': taskStatus});

    return result;
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      taskId: map['_id'] ?? '',
      taskTitle: map['taskTitle'] ?? '',
      taskDescription: map['taskDescription'] ?? '',
      taskType: map['taskType'] ?? '',
      assignedTo: map['assignedTo'] ?? '',
      assignedBy: map['assignedBy'] ?? '',
      taskFile: map['taskFile'],
      remarks: map['remarks'],
      taskSubmission: map['taskSubmission'] ?? false,
      taskStatus: map['taskStatus'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory Task.fromJson(String source) =>
      Task.fromMap(json.decode(source) as Map<String, dynamic>);
}
