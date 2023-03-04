import 'package:flutter/material.dart';
import 'package:kanban_board_flutter/app/app.locator.dart';
import 'package:kanban_board_flutter/services/timer_services.dart';
import 'package:kanban_board_flutter/views/project_tasks/widgets/timer/timer_viewmodel.dart';
import 'package:stacked/stacked.dart';

class TimerView extends StatelessWidget {
  final String taskId;
  final String projectId;
  TimerView({
    super.key,
    required this.taskId,
    required this.projectId,
  });

  TimerService timerService = locator<TimerService>();

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
        viewModelBuilder: () => TimerViewModel(),
        onModelReady: (model) {
          if (timerService.timers.containsKey(taskId)) {
            model.start = timerService.timers[taskId]!.start!;
          }
        },
        builder: (context, viewModel, child) {
          return Row(
            children: [
              IconButton(
                onPressed: timerService.timers.containsKey(taskId)
                    ? null
                    : () {
                        timerService.addTimer(taskId);
                        viewModel.start = timerService.timers[taskId]!.start!;
                        viewModel.rebuildUi();
                      },
                icon: const Icon(
                  Icons.play_arrow,
                  size: 30,
                ),
              ),
              Text(((timerService.timers.containsKey(taskId)) &&
                      (viewModel.data != null))
                  ? Duration(seconds: viewModel.data).toString().split(".")[0]
                  : "00:00:00"),
              IconButton(
                  onPressed: timerService.timers.containsKey(taskId)
                      ? () async {
                          await timerService.stopTimer(projectId, taskId);
                          viewModel.start = null;

                          viewModel.rebuildUi();
                        }
                      : null,
                  icon: const Icon(
                    Icons.stop,
                    size: 30,
                  )),
            ],
          );
        });
  }
}
