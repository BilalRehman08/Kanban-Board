import 'package:flutter/material.dart';
import 'package:kanban_board_flutter/app/app.locator.dart';
import 'package:kanban_board_flutter/app/app.router.dart';
import 'package:kanban_board_flutter/model/task_model.dart';
import 'package:kanban_board_flutter/views/project_tasks/widgets/timer/timer_view.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:intl/intl.dart';
import '../../../utils/colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

Container taskContainer({
  required BuildContext context,
  required TaskModel task,
  required isTaskOwner,
  void Function()? onMoveTask,
  String? buttonLabel,
}) {
  return Container(
    padding: const EdgeInsets.all(15),
    decoration: BoxDecoration(
      color: Theme.of(context).colorScheme.primary,
      borderRadius: BorderRadius.circular(10),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              task.title.toUpperCase(),
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              task.status,
              style: const TextStyle(
                fontSize: 15,
                color: ColorUtils.primaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          "${AppLocalizations.of(context)!.description} : ${task.description}",
          style: const TextStyle(
            fontSize: 15,
            color: ColorUtils.primaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          "${AppLocalizations.of(context)!.createdAt} : ${DateFormat("dd MMMM yyyy | H:m").format(task.createdAt)}",
          style: const TextStyle(
            fontSize: 15,
            color: ColorUtils.primaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          "${AppLocalizations.of(context)!.assignedTo} : ${task.assignedTo["name"]}",
          style: const TextStyle(
            fontSize: 15,
            color: ColorUtils.primaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        if (task.status == "In-process")
          TimerView(
            taskId: task.id,
            projectId: task.projectId!,
          ),
        if (task.status != "Completed")
          Row(
            children: [
              if (isTaskOwner) ...[
                Expanded(
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ColorUtils.moveButtonColor,
                      ),
                      onPressed: onMoveTask,
                      child: Text(buttonLabel!)),
                ),
                const SizedBox(
                  width: 10,
                ),
              ],
              Expanded(
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ColorUtils.moveButtonColor,
                    ),
                    onPressed: () {
                      locator<NavigationService>().navigateTo(
                        Routes.taskDetailView,
                        arguments: TaskDetailViewArguments(task: task),
                      );
                    },
                    child: Text(AppLocalizations.of(context)!.viewDetail,
                        style: const TextStyle(color: ColorUtils.whiteColor))),
              ),
            ],
          ),
        if (task.status == "Completed")
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${AppLocalizations.of(context)!.duration}: ${Duration(seconds: task.duration).toString().split(".")[0]}",
                style: const TextStyle(
                  fontSize: 15,
                  color: ColorUtils.primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorUtils.moveButtonColor,
                  ),
                  onPressed: () {
                    locator<NavigationService>().navigateTo(
                      Routes.taskDetailView,
                      arguments: TaskDetailViewArguments(task: task),
                    );
                  },
                  child: Text(AppLocalizations.of(context)!.viewDetail,
                      style: const TextStyle(color: ColorUtils.whiteColor)))
            ],
          ),
      ],
    ),
  );
}
