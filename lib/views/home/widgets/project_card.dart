import 'package:flutter/material.dart';
import 'package:kanban_board_flutter/model/project_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../utils/colors.dart';

class ProjectCard extends StatelessWidget {
  final ProjectModel project;
  final VoidCallback onViewTasks;
  final VoidCallback onViewDetail;
  final bool showOwnerName;
  const ProjectCard(
      {super.key,
      required this.project,
      required this.showOwnerName,
      required this.onViewTasks,
      required this.onViewDetail});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onViewTasks,
      child: Container(
        width: 250,
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildProjectTitle(context),
            _buildProjectDetail(
                AppLocalizations.of(context)!.description, project.description),
            _buildProjectDetail(AppLocalizations.of(context)!.todo,
                project.todoTasksCount.toString()),
            _buildProjectDetail(AppLocalizations.of(context)!.inProgress,
                project.inProgressTasksCount.toString()),
            _buildProjectDetail(AppLocalizations.of(context)!.done,
                project.completedTasksCount.toString()),
            if (showOwnerName)
              _buildProjectDetail(
                  AppLocalizations.of(context)!.createdBy, project.ownerName),
            Row(
              children: [
                Expanded(
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ColorUtils.moveButtonColor,
                        ),
                        onPressed: onViewDetail,
                        child: Text(AppLocalizations.of(context)!.viewDetail,
                            style: const TextStyle(
                                color: ColorUtils.whiteColor)))),
                const SizedBox(width: 10),
                Expanded(
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ColorUtils.moveButtonColor,
                        ),
                        onPressed: onViewTasks,
                        child: Text(
                          AppLocalizations.of(context)!.viewTasks,
                          style: const TextStyle(color: ColorUtils.whiteColor),
                        ))),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildProjectTitle(context) {
    return Row(
      children: [
        Container(
          height: 40,
          width: 60,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: ColorUtils.primaryColor,
          ),
          child: Icon(
            Icons.person,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        const SizedBox(width: 10),
        Text(
          project.name.toUpperCase(),
          style: const TextStyle(
            color: ColorUtils.primaryColor,
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildProjectDetail(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10),
        Text(
          "$label: $value",
          style: const TextStyle(
            color: ColorUtils.primaryColor,
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
