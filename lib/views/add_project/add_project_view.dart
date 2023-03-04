import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:kanban_board_flutter/app/app.locator.dart';
import 'package:kanban_board_flutter/model/user_model.dart';
import 'package:kanban_board_flutter/utils/colors.dart';
import 'package:kanban_board_flutter/utils/extensions.dart';
import 'package:kanban_board_flutter/viewmodels/add_project_viewmodel.dart';
import 'package:kanban_board_flutter/views/widgets/custom_form_textfield.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AddProjectView extends StatelessWidget {
  AddProjectView({super.key});

  final formKey = GlobalKey<FormBuilderState>();
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
        viewModelBuilder: () => AddProjectViewModel(),
        onViewModelReady: (viewModel) {
          viewModel.getUsers();
        },
        builder: (context, viewModel, child) {
          if (viewModel.users == null) {
            return const Scaffold(
                body: Center(
              child: CircularProgressIndicator(),
            ));
          }
          return Scaffold(
            body: SafeArea(
              child: SingleChildScrollView(
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
                            Text(AppLocalizations.of(context)!.addProject,
                                style: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold))
                          ],
                        ),
                        customFormTextField(
                            controller: viewModel.nameController,
                            hintText:
                                AppLocalizations.of(context)!.enterProjectName,
                            name: AppLocalizations.of(context)!.name,
                            padding: 0,
                            validator: FormBuilderValidators.compose([
                              FormBuilderValidators.required(),
                            ])),
                        customFormTextField(
                            controller: viewModel.descriptionController,
                            hintText: AppLocalizations.of(context)!
                                .enterProjectDescription,
                            name: AppLocalizations.of(context)!.description,
                            padding: 0,
                            validator: FormBuilderValidators.compose([
                              FormBuilderValidators.required(),
                            ])),
                        Autocomplete<UserModel>(
                          displayStringForOption: (UserModel user) {
                            return user.name;
                          },
                          fieldViewBuilder: (context, textEditingController,
                              focusNode, onFieldSubmitted) {
                            viewModel.temp = textEditingController;
                            return customFormTextField(
                                hintText: AppLocalizations.of(context)!
                                    .enterProjectMember,
                                controller: textEditingController,
                                focusNode: focusNode,
                                name: AppLocalizations.of(context)!.users,
                                padding: 0,
                                validator: FormBuilderValidators.compose([]));
                          },
                          optionsBuilder: (TextEditingValue textEditingValue) {
                            if (textEditingValue.text == '') {
                              return const Iterable<UserModel>.empty();
                            }
                            return viewModel.users!.where((UserModel option) {
                              return option.name
                                  .toString()
                                  .toLowerCase()
                                  .contains(
                                      textEditingValue.text.toLowerCase());
                            });
                          },
                          onSelected: (UserModel selection) {
                            viewModel.addUserToSelectedUsers(selection);
                          },
                        ),
                        if (viewModel.selectedUsers.isNotEmpty) ...[
                          const SizedBox(height: 15),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Text(
                                  AppLocalizations.of(context)!.teamMembers,
                                  style: const TextStyle(
                                      color: ColorUtils.cardColor,
                                      fontSize: 20)),
                            ),
                          ),
                        ],
                        const SizedBox(height: 15),
                        ListView.separated(
                          shrinkWrap: true,
                          primary: false,
                          itemCount: viewModel.selectedUsers.length,
                          separatorBuilder: (context, index) {
                            return const SizedBox(height: 10);
                          },
                          itemBuilder: (context, index) {
                            return ListTile(
                              shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15))),
                              tileColor: ColorUtils.cardColor,
                              title: Text(viewModel.selectedUsers[index].name),
                              trailing: IconButton(
                                onPressed: () {
                                  viewModel.removeUserFromSelectedUsers(index);
                                },
                                icon: const Icon(Icons.close),
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: 25),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                Theme.of(context).colorScheme.primary,
                          ),
                          onPressed: () async {
                            if (formKey.currentState!.saveAndValidate()) {
                              await viewModel.addProject(context: context);
                            }
                          },
                          child: Text(AppLocalizations.of(context)!.addProject,
                              style:
                                  const TextStyle(color: ColorUtils.bgColor)),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        });
  }
}
