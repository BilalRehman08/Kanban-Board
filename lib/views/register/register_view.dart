import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:kanban_board_flutter/viewmodels/register_viewmodel.dart';
import 'package:stacked/stacked.dart';
import '../../utils/colors.dart';
import '../../utils/extensions.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../widgets/custom_form_textfield.dart';

class RegisterView extends StackedView<RegisterViewModel> {
  RegisterView({super.key});
  final formKey = GlobalKey<FormBuilderState>();

  @override
  Widget builder(
    BuildContext context,
    RegisterViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
        body: FormBuilder(
      key: formKey,
      child: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: context.height * 0.1),
                  Text(
                    textAlign: TextAlign.center,
                    AppLocalizations.of(context)!.register,
                    style: const TextStyle(
                        fontSize: 46.1,
                        fontWeight: FontWeight.bold,
                        color: ColorUtils.primaryColor),
                  ),
                  const SizedBox(height: 5.0),
                  Text(
                    textAlign: TextAlign.center,
                    AppLocalizations.of(context)!.signUpContinue,
                    style: const TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                        color: ColorUtils.primaryColor),
                  ),
                  const SizedBox(height: 10.0),
                  customFormTextField(
                      controller: viewModel.nameController,
                      labelText: AppLocalizations.of(context)!.name,
                      name: AppLocalizations.of(context)!.name,
                      hintText: AppLocalizations.of(context)!.enterName,
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(),
                      ])),
                  const SizedBox(height: 10.0),
                  customFormTextField(
                      controller: viewModel.emailController,
                      labelText: AppLocalizations.of(context)!.email,
                      name: AppLocalizations.of(context)!.email,
                      hintText: AppLocalizations.of(context)!.enterEmail,
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(),
                        FormBuilderValidators.email(),
                      ])),
                  const SizedBox(height: 10.0),
                  customFormTextField(
                      controller: viewModel.passwordController,
                      labelText: AppLocalizations.of(context)!.password,
                      name: AppLocalizations.of(context)!.password,
                      hintText: AppLocalizations.of(context)!.enterPass,
                      obscureText: !viewModel.isShowPassword,
                      suffixIcon: IconButton(
                        icon: viewModel.isShowPassword
                            ? const Icon(
                                Icons.remove_red_eye,
                                color: ColorUtils.primaryColor,
                              )
                            : const Icon(
                                Icons.visibility_off,
                                color: ColorUtils.primaryColor,
                              ),
                        onPressed: () {
                          viewModel.isShowPassword = !viewModel.isShowPassword;
                          viewModel.rebuildUi();
                        },
                      ),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(),
                        FormBuilderValidators.minLength(6),
                      ])),
                  const SizedBox(height: 40.0),
                  Container(
                    height: 60,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                      borderRadius: BorderRadius.circular(7.0),
                    ),
                    child: TextButton(
                        onPressed: () async {
                          if (formKey.currentState!.saveAndValidate()) {
                            await viewModel.registerUser();
                          }
                        },
                        child: Text(
                          AppLocalizations.of(context)!.signUp,
                          style: const TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                              color: ColorUtils.blackColor),
                        )),
                  ),
                  const SizedBox(height: 10.0),
                  TextButton(
                    onPressed: () {
                      viewModel.navigateToLoginView();
                    },
                    child: Text(
                      textAlign: TextAlign.center,
                      AppLocalizations.of(context)!.alreadyAccount,
                      style: const TextStyle(
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold,
                          color: ColorUtils.primaryColor),
                    ),
                  )
                ])),
      ),
    ));
  }

  @override
  RegisterViewModel viewModelBuilder(BuildContext context) =>
      RegisterViewModel();
}
