import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:kanban_board_flutter/utils/extensions.dart';
import 'package:stacked/stacked.dart';
import '../../utils/colors.dart';
import '../../viewmodels/login_viewmodel.dart';
import '../register/register_view.dart';
import '../widgets/custom_form_textfield.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LoginView extends StackedView<LoginViewModel> {
  LoginView({super.key});

  final formKey = GlobalKey<FormBuilderState>();

  @override
  Widget builder(
    BuildContext context,
    LoginViewModel viewModel,
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
                  SizedBox(height: context.height * 0.15),
                  Text(
                    AppLocalizations.of(context)!.login,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 46.1,
                        fontWeight: FontWeight.bold,
                        color: ColorUtils.primaryColor),
                  ),
                  const SizedBox(height: 5.0),
                  Text(
                    textAlign: TextAlign.center,
                    AppLocalizations.of(context)!.signIn,
                    style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                        color: ColorUtils.primaryColor),
                  ),
                  const SizedBox(height: 10.0),
                  customFormTextField(
                      controller: viewModel.emailController,
                      labelText: AppLocalizations.of(context)!.email,
                      name: "email",
                      hintText: "abc@gmail.com",
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(),
                        FormBuilderValidators.email(),
                      ])),
                  const SizedBox(height: 10.0),
                  customFormTextField(
                      controller: viewModel.passwordController,
                      labelText: AppLocalizations.of(context)!.password,
                      name: "password",
                      hintText: "********",
                      obscureText: !viewModel.isShowPassword,
                      suffixIcon: IconButton(
                        icon: viewModel.isShowPassword
                            ? Icon(
                                Icons.remove_red_eye,
                                color: ColorUtils.primaryColor,
                              )
                            : Icon(
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
                  const SizedBox(height: 10),
                  const SizedBox(height: 20),
                  Container(
                    height: 60,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                      borderRadius: BorderRadius.circular(7.0),
                    ),
                    child: TextButton(
                        onPressed: () {
                          // if (kDebugMode) {
                          //   viewModel.emailController.text = "bilal@gmail.com";
                          //   viewModel.passwordController.text = "bilal123";
                          // }
                          if (formKey.currentState!.saveAndValidate()) {
                            viewModel.loginUser(
                              context: context,
                            );
                          }
                        },
                        child: Text(
                          AppLocalizations.of(context)!.login,
                          style: const TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                              color: ColorUtils.blackColor),
                        )),
                  ),
                  const SizedBox(height: 10.0),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RegisterView()));
                    },
                    child: Text(
                      textAlign: TextAlign.center,
                      AppLocalizations.of(context)!.noAccount,
                      style: TextStyle(
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
  LoginViewModel viewModelBuilder(BuildContext context) => LoginViewModel();
}
