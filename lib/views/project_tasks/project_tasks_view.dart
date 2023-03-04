import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../utils/colors.dart';
import '../../viewmodels/project_tasks_viewmodel.dart';
import 'widgets/completed_screen.dart';
import 'widgets/in_progress_screen.dart';
import 'widgets/todo_screen.dart';

class ProjectTasksView extends StatelessWidget {
  final String projectId;
  final List users;
  final String ownerUid;
  const ProjectTasksView({
    Key? key,
    required this.projectId,
    required this.users,
    required this.ownerUid,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ProjectTasksViewModel>.reactive(
        viewModelBuilder: () => ProjectTasksViewModel(),
        builder: (context, viewModel, child) {
          return DefaultTabController(
            length: 3,
            child: Scaffold(
              appBar: AppBar(
                iconTheme: const IconThemeData(
                  color: ColorUtils.primaryColor,
                ),
                backgroundColor: Theme.of(context).colorScheme.primary,
                elevation: 0,
                centerTitle: true,
                title: Text(
                  AppLocalizations.of(context)!.tasks,
                  style: const TextStyle(color: ColorUtils.primaryColor),
                ),
              ),
              body: Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  children: [
                    TabBar(
                        unselectedLabelColor: ColorUtils.blackColor,
                        labelColor: ColorUtils.blackColor,
                        indicatorColor: ColorUtils.primaryColor,
                        tabs: [
                          Tab(
                            child: Container(
                              height: 30,
                              decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(color: ColorUtils.blueColor),
                              ),
                              child: Center(
                                child: Text(AppLocalizations.of(context)!.todo,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                        color: ColorUtils.blueColor)),
                              ),
                            ),
                          ),
                          Tab(
                            child: Container(
                              height: 30,
                              decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                              ),
                              child: Center(
                                child: Text(
                                    AppLocalizations.of(context)!.inProgress,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                    )),
                              ),
                            ),
                          ),
                          Tab(
                            child: Container(
                              height: 30,
                              decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                borderRadius: BorderRadius.circular(5),
                                border:
                                    Border.all(color: ColorUtils.greenColor),
                              ),
                              child: Center(
                                child: Text(
                                  AppLocalizations.of(context)!.completed,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                      color: ColorUtils.greenColor),
                                ),
                              ),
                            ),
                          ),
                        ]),
                    const SizedBox(height: 10),
                    Expanded(
                        child: TabBarView(children: [
                      TodoScreen(
                          projectId: projectId,
                          users: users,
                          ownerUid: ownerUid),
                      InProgressScreen(projectId: projectId),
                      CompletedScreen(projectId: projectId)
                    ]))
                  ],
                ),
              ),
            ),
          );
        });
  }
}
