import 'package:flutter/material.dart';
import 'package:kanban_board_flutter/app/app.locator.dart';
import 'package:kanban_board_flutter/model/project_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:kanban_board_flutter/utils/colors.dart';
import 'package:kanban_board_flutter/utils/extensions.dart';
import 'package:kanban_board_flutter/viewmodels/project_detail_viewmodel.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class ProjectDetailView extends StatelessWidget {
  final ProjectModel project;
  const ProjectDetailView({super.key, required this.project});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.nonReactive(
      viewModelBuilder: () => ProjectDetailViewModel(),
      builder: (context, viewModel, child) {
        return Scaffold(
          floatingActionButton: FloatingActionButton(
            backgroundColor: Theme.of(context).colorScheme.primary,
            onPressed: () async {
              await viewModel.downloadProjectAsCSV(
                  context: context,
                  fileName: project.name,
                  projectId: project.id!);
            },
            child: const Icon(Icons.download),
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        IconButton(
                            onPressed: () {
                              locator<NavigationService>().back();
                            },
                            icon: Icon(
                              Icons.arrow_back_ios,
                              color: Theme.of(context).colorScheme.primary,
                            )),
                        SizedBox(width: context.width * 0.25),
                        Text(AppLocalizations.of(context)!.projectDetail,
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.primary,
                                fontSize: 20,
                                fontWeight: FontWeight.bold))
                      ],
                    ),
                    const SizedBox(height: 20),
                    Text("${AppLocalizations.of(context)!.projectDetails}:",
                        style: TextStyle(
                            color:
                                Theme.of(context).textTheme.displayLarge!.color,
                            fontSize: 18,
                            fontWeight: FontWeight.bold)),
                    const SizedBox(height: 10),
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primary,
                          borderRadius: BorderRadius.circular(10)),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 10),
                          textWidget(
                              text:
                                  "${AppLocalizations.of(context)!.name}: ${project.name}"),
                          textWidget(
                              text:
                                  "${AppLocalizations.of(context)!.description}: ${project.description}"),
                          textWidget(
                              text:
                                  "${AppLocalizations.of(context)!.ownerName}: ${project.ownerName}"),
                          textWidget(
                              text:
                                  "${AppLocalizations.of(context)!.numCompletedTasks}: ${project.completedTasksCount}"),
                          textWidget(
                              text:
                                  "${AppLocalizations.of(context)!.numToDoTasks}: ${project.todoTasksCount}"),
                          textWidget(
                              text:
                                  "${AppLocalizations.of(context)!.numInProgress}: ${project.inProgressTasksCount}"),
                        ],
                      ),
                    ),
                    if (project.users.isNotEmpty)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 20),
                          Text("${AppLocalizations.of(context)!.users}:",
                              style: TextStyle(
                                  color: Theme.of(context)
                                      .textTheme
                                      .displayLarge!
                                      .color,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold)),
                          const SizedBox(height: 10),
                          ListView.builder(
                            shrinkWrap: true,
                            primary: false,
                            itemCount: project.users.length,
                            itemBuilder: (context, index) {
                              return Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                color: Theme.of(context).colorScheme.primary,
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${AppLocalizations.of(context)!.name}: ${project.users[index]["name"]}",
                                        style: const TextStyle(
                                            color: ColorUtils.whiteColor,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const SizedBox(height: 10),
                                      Row(
                                        children: [
                                          Image.asset(
                                            "assets/email.png",
                                            height: 30,
                                          ),
                                          const SizedBox(width: 5),
                                          Text(
                                              "${AppLocalizations.of(context)!.email}: ${project.users[index]["email"]}",
                                              style: const TextStyle(
                                                  color: ColorUtils.whiteColor,
                                                  fontSize: 17)),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  textWidget({
    required String text,
  }) {
    return Column(
      children: [
        Text(text,
            style: const TextStyle(
                color: ColorUtils.blackColor,
                fontSize: 20,
                fontWeight: FontWeight.bold)),
        const SizedBox(height: 10),
      ],
    );
  }
}
