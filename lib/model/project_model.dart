import 'package:cloud_firestore/cloud_firestore.dart';

class ProjectModel {
   String? id;
  final String ownerUid;
  final String ownerName;
  final String name;
  final String description;
  final List users;
  final int todoTasksCount;
  final int completedTasksCount;
  final int inProgressTasksCount;
  final DateTime? createdAt;

  ProjectModel({
    required this.ownerName,
    this.id,
    required this.ownerUid,
    required this.name,
    required this.users,
    required this.description,
    this.todoTasksCount = 0,
    this.completedTasksCount = 0,
    this.inProgressTasksCount = 0,
     this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'users': users,
      'description': description,
      'createdAt': FieldValue.serverTimestamp(),
      'ownerUid': ownerUid,
      'ownerName': ownerName,
      'todoTasksCount': todoTasksCount,
      'completedTasksCount': completedTasksCount,
      'inProgressTasksCount': inProgressTasksCount,
    };
  }

  static fromMap(Map<String, dynamic> map) {
    return ProjectModel(
      id: map['id'],
      name: map['name'],
      createdAt: map['createdAt'].toDate(),
      users: map['users'],
      description: map['description'],
      ownerUid: map['ownerUid'],
      ownerName: map['ownerName'],
      todoTasksCount: map['todoTasksCount'],
      completedTasksCount: map['completedTasksCount'],
      inProgressTasksCount: map['inProgressTasksCount'],
    );
  }
}
