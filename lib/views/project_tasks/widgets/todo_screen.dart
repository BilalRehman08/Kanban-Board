import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kanban_board_flutter/model/task_model.dart';
import 'package:kanban_board_flutter/views/project_tasks/widgets/task_container.dart';
import 'package:stacked/stacked.dart';
import "package:flutter_gen/gen_l10n/app_localizations.dart";
import '../../../utils/colors.dart';
import '../../../viewmodels/project_tasks_viewmodel.dart';

class TodoScreen extends StatelessWidget {
  final String projectId;
  final List users;
  final String ownerUid;
  const TodoScreen(
      {super.key,
      required this.projectId,
      required this.users,
      required this.ownerUid});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ProjectTasksViewModel>.reactive(
        viewModelBuilder: () => ProjectTasksViewModel(),
        builder: (context, viewModel, child) {
          return Scaffold(
              body: FutureBuilder(
                  future: viewModel.getToDoTasks(projectId),
                  builder: (context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data.docs.length == 0) {
                        return Center(
                          child: Text(
                            "${AppLocalizations.of(context)!.noTasksIn} ${AppLocalizations.of(context)!.todo}",
                            style: TextStyle(
                                color: Theme.of(context)
                                    .textTheme
                                    .displayLarge!
                                    .color,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                        );
                      }
                      return ListView.separated(
                          separatorBuilder: (context, index) {
                            return const SizedBox(
                              height: 10,
                            );
                          },
                          itemCount: snapshot.data.docs.length,
                          itemBuilder: (context, index) {
                            Map<String, dynamic> data =
                                snapshot.data.docs[index].data();
                            data['id'] = snapshot.data.docs[index].id;
                            TaskModel task = TaskModel.fromJson(data);
                            task.projectId = projectId;
                            return taskContainer(
                              context: context,
                              task: task,
                              buttonLabel: AppLocalizations.of(context)!
                                  .moveToInProgress,
                              isTaskOwner: task.assignedTo["uid"] ==
                                  FirebaseAuth.instance.currentUser!.uid,
                              onMoveTask: () async {
                                await viewModel.goToInprocess(
                                    taskId: task.id,
                                    context: context,
                                    status: "In-process",
                                    projectId: projectId);
                                viewModel.rebuildUi();
                              },
                            );
                          });
                    }
                    return const Center(child: CircularProgressIndicator());
                  }),
              floatingActionButton:
                  ownerUid == FirebaseAuth.instance.currentUser!.uid
                      ? FloatingActionButton(
                          onPressed: () async {
                            await viewModel.navigateToAddTasksView(
                                projectId, users);
                            viewModel.rebuildUi();
                          },
                          backgroundColor: ColorUtils.primaryColor,
                          child: Icon(
                            Icons.add,
                            color: Theme.of(context).colorScheme.primary,
                          ))
                      : null);
        });
  }
}
