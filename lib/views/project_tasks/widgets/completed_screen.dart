import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kanban_board_flutter/model/task_model.dart';
import 'package:kanban_board_flutter/views/project_tasks/widgets/task_container.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../viewmodels/project_tasks_viewmodel.dart';

class CompletedScreen extends StatelessWidget {
  final String projectId;
  const CompletedScreen({super.key, required this.projectId});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ProjectTasksViewModel>.reactive(
        viewModelBuilder: () => ProjectTasksViewModel(),
        builder: (context, viewModel, child) {
          return Scaffold(
            body: FutureBuilder(
                future: viewModel.getCompletedTasks(projectId),
                builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data.docs.length == 0) {
                      return Center(
                        child: Text(
                          "${AppLocalizations.of(context)!.noTasksIn} ${AppLocalizations.of(context)!.done}",
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
                            isTaskOwner: task.assignedTo["uid"] ==
                                FirebaseAuth.instance.currentUser!.uid,
                          );
                        });
                  }
                  return const Center(child: CircularProgressIndicator());
                }),
          );
        });
  }
}
