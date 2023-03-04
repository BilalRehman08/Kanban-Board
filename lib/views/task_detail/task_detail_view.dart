import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kanban_board_flutter/app/app.locator.dart';
import 'package:kanban_board_flutter/model/task_model.dart';
import 'package:kanban_board_flutter/viewmodels/task_detail_viewmodel.dart';
import 'package:kanban_board_flutter/utils/colors.dart';
import 'package:kanban_board_flutter/utils/extensions.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:intl/intl.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TaskDetailView extends StatelessWidget {
  final TaskModel task;
  const TaskDetailView({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    print(task.status);
    print(task.projectId);
    print(task.id);
    return ViewModelBuilder.nonReactive(
        viewModelBuilder: () => TaskDetailViewModel(),
        builder: (context, viewModel, child) {
          return Scaffold(
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
                        Text(AppLocalizations.of(context)!.taskDetail,
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.primary,
                                fontSize: 20,
                                fontWeight: FontWeight.bold))
                      ],
                    ),
                    const SizedBox(height: 20),
                    Text(AppLocalizations.of(context)!.taskDetail,
                        style: TextStyle(
                            color:
                                Theme.of(context).textTheme.displayLarge!.color,
                            fontSize: 20,
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
                                  "${AppLocalizations.of(context)!.taskName} : ${task.title.toUpperCase()}"),
                          textWidget(
                              text:
                                  "${AppLocalizations.of(context)!.taskStatus} : ${task.status}"),
                          textWidget(
                              text:
                                  "${AppLocalizations.of(context)!.taskDescription} : ${task.description}"),
                          if (task.status != "toDo")
                            textWidget(
                                text:
                                    "${AppLocalizations.of(context)!.duration}: ${Duration(seconds: task.duration).toString().split(".")[0]}"),
                          textWidget(
                              text:
                                  "${AppLocalizations.of(context)!.date}: ${DateFormat("dd MMMM yyyy | H:m").format(task.createdAt)}  "),
                          textWidget(
                              text:
                                  "${AppLocalizations.of(context)!.assignedTo}: ${task.assignedTo["name"]}"),
                        ],
                      ),
                    ),
                    if (task.status != "toDo")
                      FutureBuilder(
                        future: viewModel.getTimerHistory(
                            projectId: task.projectId!,
                            taskId: task.id,
                            status: task.status),
                        builder:
                            (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (snapshot.hasData) {
                            if (snapshot.data!.docs.isEmpty) {
                              return const SizedBox();
                            }
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 20),
                                Text(AppLocalizations.of(context)!.timerHistory,
                                    style: TextStyle(
                                        color: Theme.of(context)
                                            .textTheme
                                            .displayLarge!
                                            .color,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold)),
                                const SizedBox(height: 10),
                                ListView.separated(
                                  itemCount: snapshot.data!.docs.length,
                                  shrinkWrap: true,
                                  primary: false,
                                  separatorBuilder: (context, index) {
                                    return const SizedBox();
                                  },
                                  itemBuilder: (context, index) {
                                    Map<String, dynamic> data =
                                        snapshot.data!.docs[index].data()
                                            as Map<String, dynamic>;
                                    data['id'] = snapshot.data!.docs[index].id;
                                    return Card(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "${AppLocalizations.of(context)!.startTime}: ${DateFormat("dd MMMM yyyy | H:m").format(data["start"].toDate())}",
                                            ),
                                            const SizedBox(height: 10),
                                            Text(
                                                "${AppLocalizations.of(context)!.endTime}: ${DateFormat("dd MMMM yyyy | H:m").format(data["end"].toDate())}"),
                                            const SizedBox(height: 10),
                                            Text(
                                                "${AppLocalizations.of(context)!.duration}: ${Duration(seconds: data["duration"]).toString().split(".")[0]}"),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                )
                              ],
                            );
                          }
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        },
                      )
                  ],
                ),
              ),
            ),
          ));
        });
  }

  textWidget({required String text}) {
    return Column(
      children: [
        Text(text,
            style: const TextStyle(
                color: ColorUtils.bgColor,
                fontSize: 17,
                fontWeight: FontWeight.bold)),
        const SizedBox(height: 10),
      ],
    );
  }
}
