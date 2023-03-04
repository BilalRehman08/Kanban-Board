import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:kanban_board_flutter/app/app.locator.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:kanban_board_flutter/utils/extensions.dart';
import 'package:kanban_board_flutter/viewmodels/add_taks_viewmodel.dart';
import 'package:kanban_board_flutter/views/widgets/custom_dropdown.dart';
import 'package:kanban_board_flutter/views/widgets/custom_form_textfield.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class AddTasksView extends StatelessWidget {
  final String projectId;
  final List users;
  AddTasksView({super.key, required this.projectId, required this.users});

  final formKey = GlobalKey<FormBuilderState>();
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => AddTaksViewModel(),
      onViewModelReady: (viewModel) {
        if (!users.any((element) =>
            element["uid"] == FirebaseAuth.instance.currentUser!.uid)) {
          users.add({
            "uid": FirebaseAuth.instance.currentUser!.uid,
            "name": FirebaseAuth.instance.currentUser!.displayName,
            "email": FirebaseAuth.instance.currentUser!.email,
          });
        }
        viewModel.selectedUser = users.last;
      },
      builder: (context, viewModel, child) {
        return Scaffold(
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: FormBuilder(
                key: formKey,
                child: Column(
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
                        Text(AppLocalizations.of(context)!.addTask,
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.primary,
                                fontSize: 20,
                                fontWeight: FontWeight.bold))
                      ],
                    ),
                    customFormTextField(
                        controller: viewModel.taskNameController,
                        name: AppLocalizations.of(context)!.name,
                        hintText: AppLocalizations.of(context)!.enterTaskName,
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(),
                        ])),
                    customFormTextField(
                        controller: viewModel.taskDescriptionController,
                        name: AppLocalizations.of(context)!.description,
                        hintText:
                            AppLocalizations.of(context)!.enterTaskDescription,
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(),
                        ])),
                    const SizedBox(height: 20),
                    customDropDown(
                        context: context,
                        items: users,
                        selectedItem: viewModel.selectedUser,
                        onChanged: (value) {
                          viewModel.selectedUser = value as Map;
                          viewModel.rebuildUi();
                        }),
                    const SizedBox(height: 20),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              Theme.of(context).colorScheme.primary,
                        ),
                        onPressed: () async {
                          if (formKey.currentState!.saveAndValidate()) {
                            await viewModel.addTask(
                                projectId: projectId, context: context);
                          }
                        },
                        child: Text(AppLocalizations.of(context)!.addTask))
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
