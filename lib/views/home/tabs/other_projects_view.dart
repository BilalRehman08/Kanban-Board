import 'package:flutter/material.dart';
import 'package:kanban_board_flutter/app/app.locator.dart';
import 'package:kanban_board_flutter/app/app.router.dart';
import 'package:kanban_board_flutter/model/project_model.dart';
import 'package:kanban_board_flutter/utils/colors.dart';
import 'package:kanban_board_flutter/viewmodels/home_view_model.dart';
import 'package:kanban_board_flutter/views/home/widgets/project_card.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class OtherProjectsView extends StatelessWidget {
  const OtherProjectsView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => HomeViewModel(),
      builder: (context, viewModel, child) {
        return Scaffold(
          body: FutureBuilder(
              future: viewModel.getOtherProjects(context: context),
              builder: (context, AsyncSnapshot snapshot) {
                var projects = snapshot.data;
                if (snapshot.hasData) {
                  if (projects.length == 0) {
                    return Center(
                      child: Text(
                        AppLocalizations.of(context)!.noProjects,
                        style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: ColorUtils.whiteColor),
                      ),
                    );
                  }
                  return Padding(
                    padding: const EdgeInsets.all(15),
                    child: ListView.separated(
                        itemCount: projects.length,
                        separatorBuilder: (context, index) {
                          return const SizedBox(
                            height: 15,
                          );
                        },
                        itemBuilder: (context, index) {
                          ProjectModel project = projects[index];
                          return ProjectCard(
                            project: project,
                            showOwnerName: true,
                            onViewTasks: () {
                              viewModel.navigateToProjectView(
                                  project.id!, project.users, project.ownerUid);
                            },
                            onViewDetail: () {
                              locator<NavigationService>().navigateTo(
                                  Routes.projectDetailView,
                                  arguments: ProjectDetailViewArguments(
                                      project: project));
                            },
                          );
                        }),
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              }),
        );
      },
    );
  }
}
