// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedRouterGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:flutter/material.dart' as _i11;
import 'package:flutter/material.dart';
import 'package:kanban_board_flutter/model/project_model.dart' as _i13;
import 'package:kanban_board_flutter/model/task_model.dart' as _i12;
import 'package:kanban_board_flutter/views/add_project/add_project_view.dart'
    as _i6;
import 'package:kanban_board_flutter/views/add_tasks/add_tasks_view.dart'
    as _i7;
import 'package:kanban_board_flutter/views/home/home_view.dart' as _i4;
import 'package:kanban_board_flutter/views/login/login_view.dart' as _i3;
import 'package:kanban_board_flutter/views/project_detail/project_detail_view.dart'
    as _i9;
import 'package:kanban_board_flutter/views/project_tasks/project_tasks_view.dart'
    as _i5;
import 'package:kanban_board_flutter/views/register/register_view.dart' as _i2;
import 'package:kanban_board_flutter/views/splash/splash_view.dart' as _i10;
import 'package:kanban_board_flutter/views/task_detail/task_detail_view.dart'
    as _i8;
import 'package:stacked/stacked.dart' as _i1;
import 'package:stacked_services/stacked_services.dart' as _i14;

class Routes {
  static const registerView = '/register-view';

  static const loginView = '/login-view';

  static const homeView = '/home-view';

  static const projectTasksView = '/project-tasks-view';

  static const addProjectView = '/add-project-view';

  static const addTasksView = '/add-tasks-view';

  static const taskDetailView = '/task-detail-view';

  static const projectDetailView = '/project-detail-view';

  static const splashView = '/';

  static const all = <String>{
    registerView,
    loginView,
    homeView,
    projectTasksView,
    addProjectView,
    addTasksView,
    taskDetailView,
    projectDetailView,
    splashView,
  };
}

class StackedRouter extends _i1.RouterBase {
  final _routes = <_i1.RouteDef>[
    _i1.RouteDef(
      Routes.registerView,
      page: _i2.RegisterView,
    ),
    _i1.RouteDef(
      Routes.loginView,
      page: _i3.LoginView,
    ),
    _i1.RouteDef(
      Routes.homeView,
      page: _i4.HomeView,
    ),
    _i1.RouteDef(
      Routes.projectTasksView,
      page: _i5.ProjectTasksView,
    ),
    _i1.RouteDef(
      Routes.addProjectView,
      page: _i6.AddProjectView,
    ),
    _i1.RouteDef(
      Routes.addTasksView,
      page: _i7.AddTasksView,
    ),
    _i1.RouteDef(
      Routes.taskDetailView,
      page: _i8.TaskDetailView,
    ),
    _i1.RouteDef(
      Routes.projectDetailView,
      page: _i9.ProjectDetailView,
    ),
    _i1.RouteDef(
      Routes.splashView,
      page: _i10.SplashView,
    ),
  ];

  final _pagesMap = <Type, _i1.StackedRouteFactory>{
    _i2.RegisterView: (data) {
      final args = data.getArgs<RegisterViewArguments>(
        orElse: () => const RegisterViewArguments(),
      );
      return MaterialPageRoute<dynamic>(
        builder: (context) => _i2.RegisterView(key: args.key),
        settings: data,
      );
    },
    _i3.LoginView: (data) {
      final args = data.getArgs<LoginViewArguments>(
        orElse: () => const LoginViewArguments(),
      );
      return MaterialPageRoute<dynamic>(
        builder: (context) => _i3.LoginView(key: args.key),
        settings: data,
      );
    },
    _i4.HomeView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const _i4.HomeView(),
        settings: data,
      );
    },
    _i5.ProjectTasksView: (data) {
      final args = data.getArgs<ProjectTasksViewArguments>(nullOk: false);
      return MaterialPageRoute<dynamic>(
        builder: (context) => _i5.ProjectTasksView(
            key: args.key,
            projectId: args.projectId,
            users: args.users,
            ownerUid: args.ownerUid),
        settings: data,
      );
    },
    _i6.AddProjectView: (data) {
      final args = data.getArgs<AddProjectViewArguments>(
        orElse: () => const AddProjectViewArguments(),
      );
      return MaterialPageRoute<dynamic>(
        builder: (context) => _i6.AddProjectView(key: args.key),
        settings: data,
      );
    },
    _i7.AddTasksView: (data) {
      final args = data.getArgs<AddTasksViewArguments>(nullOk: false);
      return MaterialPageRoute<dynamic>(
        builder: (context) => _i7.AddTasksView(
            key: args.key, projectId: args.projectId, users: args.users),
        settings: data,
      );
    },
    _i8.TaskDetailView: (data) {
      final args = data.getArgs<TaskDetailViewArguments>(nullOk: false);
      return MaterialPageRoute<dynamic>(
        builder: (context) =>
            _i8.TaskDetailView(key: args.key, task: args.task),
        settings: data,
      );
    },
    _i9.ProjectDetailView: (data) {
      final args = data.getArgs<ProjectDetailViewArguments>(nullOk: false);
      return MaterialPageRoute<dynamic>(
        builder: (context) =>
            _i9.ProjectDetailView(key: args.key, project: args.project),
        settings: data,
      );
    },
    _i10.SplashView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const _i10.SplashView(),
        settings: data,
      );
    },
  };

  @override
  List<_i1.RouteDef> get routes => _routes;
  @override
  Map<Type, _i1.StackedRouteFactory> get pagesMap => _pagesMap;
}

class RegisterViewArguments {
  const RegisterViewArguments({this.key});

  final _i11.Key? key;

  @override
  String toString() {
    return '{"key": "$key"}';
  }
}

class LoginViewArguments {
  const LoginViewArguments({this.key});

  final _i11.Key? key;

  @override
  String toString() {
    return '{"key": "$key"}';
  }
}

class ProjectTasksViewArguments {
  const ProjectTasksViewArguments({
    this.key,
    required this.projectId,
    required this.users,
    required this.ownerUid,
  });

  final _i11.Key? key;

  final String projectId;

  final List<dynamic> users;

  final String ownerUid;

  @override
  String toString() {
    return '{"key": "$key", "projectId": "$projectId", "users": "$users", "ownerUid": "$ownerUid"}';
  }
}

class AddProjectViewArguments {
  const AddProjectViewArguments({this.key});

  final _i11.Key? key;

  @override
  String toString() {
    return '{"key": "$key"}';
  }
}

class AddTasksViewArguments {
  const AddTasksViewArguments({
    this.key,
    required this.projectId,
    required this.users,
  });

  final _i11.Key? key;

  final String projectId;

  final List<dynamic> users;

  @override
  String toString() {
    return '{"key": "$key", "projectId": "$projectId", "users": "$users"}';
  }
}

class TaskDetailViewArguments {
  const TaskDetailViewArguments({
    this.key,
    required this.task,
  });

  final _i11.Key? key;

  final _i12.TaskModel task;

  @override
  String toString() {
    return '{"key": "$key", "task": "$task"}';
  }
}

class ProjectDetailViewArguments {
  const ProjectDetailViewArguments({
    this.key,
    required this.project,
  });

  final _i11.Key? key;

  final _i13.ProjectModel project;

  @override
  String toString() {
    return '{"key": "$key", "project": "$project"}';
  }
}

extension NavigatorStateExtension on _i14.NavigationService {
  Future<dynamic> navigateToRegisterView({
    _i11.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.registerView,
        arguments: RegisterViewArguments(key: key),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToLoginView({
    _i11.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.loginView,
        arguments: LoginViewArguments(key: key),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToHomeView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.homeView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToProjectTasksView({
    _i11.Key? key,
    required String projectId,
    required List<dynamic> users,
    required String ownerUid,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.projectTasksView,
        arguments: ProjectTasksViewArguments(
            key: key, projectId: projectId, users: users, ownerUid: ownerUid),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToAddProjectView({
    _i11.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.addProjectView,
        arguments: AddProjectViewArguments(key: key),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToAddTasksView({
    _i11.Key? key,
    required String projectId,
    required List<dynamic> users,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.addTasksView,
        arguments:
            AddTasksViewArguments(key: key, projectId: projectId, users: users),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToTaskDetailView({
    _i11.Key? key,
    required _i12.TaskModel task,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.taskDetailView,
        arguments: TaskDetailViewArguments(key: key, task: task),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToProjectDetailView({
    _i11.Key? key,
    required _i13.ProjectModel project,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.projectDetailView,
        arguments: ProjectDetailViewArguments(key: key, project: project),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToSplashView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.splashView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithRegisterView({
    _i11.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.registerView,
        arguments: RegisterViewArguments(key: key),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithLoginView({
    _i11.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.loginView,
        arguments: LoginViewArguments(key: key),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithHomeView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.homeView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithProjectTasksView({
    _i11.Key? key,
    required String projectId,
    required List<dynamic> users,
    required String ownerUid,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.projectTasksView,
        arguments: ProjectTasksViewArguments(
            key: key, projectId: projectId, users: users, ownerUid: ownerUid),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithAddProjectView({
    _i11.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.addProjectView,
        arguments: AddProjectViewArguments(key: key),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithAddTasksView({
    _i11.Key? key,
    required String projectId,
    required List<dynamic> users,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.addTasksView,
        arguments:
            AddTasksViewArguments(key: key, projectId: projectId, users: users),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithTaskDetailView({
    _i11.Key? key,
    required _i12.TaskModel task,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.taskDetailView,
        arguments: TaskDetailViewArguments(key: key, task: task),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithProjectDetailView({
    _i11.Key? key,
    required _i13.ProjectModel project,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.projectDetailView,
        arguments: ProjectDetailViewArguments(key: key, project: project),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithSplashView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.splashView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }
}
