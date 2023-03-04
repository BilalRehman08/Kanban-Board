import 'package:cloud_firestore/cloud_firestore.dart';

class TaskModel {
  final String id;
 String? projectId;
  final String title;
  final String description;
  final Map assignedTo;
  final DateTime createdAt;
  final String status;
  final int duration;

  TaskModel({
    required this.id,
    required this.title,
    required this.duration,
    required this.description,
    required this.createdAt,
    required this.assignedTo,
    required this.status,
     this.projectId,
  });

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      id: json['id'],
      status: json['status'],
      duration: json['duration'],
      title: json['title'],
      description: json['description'],
      createdAt: json['createdAt'].toDate(),
      assignedTo: json['assignedTo'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'duration': duration,
      'description': description,
      'createdAt': FieldValue.serverTimestamp(),
      'assignedTo': assignedTo,
      'status': status,
    };
  }
}
