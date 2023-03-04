import 'package:flutter/material.dart';
import 'package:kanban_board_flutter/app/app.locator.dart';
import 'package:kanban_board_flutter/model/user_model.dart';
import 'package:kanban_board_flutter/services/profile_services.dart';
import 'package:kanban_board_flutter/services/project_services.dart';
import 'package:stacked/stacked.dart';

class AddProjectViewModel extends BaseViewModel {
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController temp = TextEditingController();
  List<UserModel>? users;
  UserModel? selectedUser;
  List<UserModel> selectedUsers = [];
  ProjectService projectService = ProjectService();
  Future<void> addProject({
    required BuildContext context,
  }) async {
    await projectService.addProject(
      name: nameController.text,
      description: descriptionController.text,
      users: selectedUsers,
      context: context,
    );
    if (context.mounted) {
      Navigator.pop(context);
    }
  }

  Future<void> getUsers() async {
    await ProfileServices.getAllProfiles().then((value) {
      users = value;
      rebuildUi();
    });
  }

  removeUserFromSelectedUsers(index) {
    users!.add(selectedUsers[index]);
    selectedUsers.removeAt(index);
    rebuildUi();
  }

  addUserToSelectedUsers(UserModel user) {
    selectedUsers.add(user);
    users!.remove(user);
    temp.clear();
    rebuildUi();
  }
}
