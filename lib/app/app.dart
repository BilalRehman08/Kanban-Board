import 'package:kanban_board_flutter/services/project_csv_export_services.dart';
import 'package:kanban_board_flutter/services/project_services.dart';
import 'package:kanban_board_flutter/services/timer_services.dart';
import 'package:kanban_board_flutter/views/add_project/add_project_view.dart';
import 'package:kanban_board_flutter/views/add_tasks/add_tasks_view.dart';
import 'package:kanban_board_flutter/views/project_detail/project_detail_view.dart';
import 'package:kanban_board_flutter/views/task_detail/task_detail_view.dart';
import 'package:kanban_board_flutter/views/splash/splash_view.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';

import '../views/home/home_view.dart';
import '../views/login/login_view.dart';
import '../views/project_tasks/project_tasks_view.dart';
import '../views/register/register_view.dart';

@StackedApp(routes: [
  MaterialRoute(page: RegisterView),
  MaterialRoute(page: LoginView),
  MaterialRoute(page: HomeView),
  MaterialRoute(page: ProjectTasksView),
  MaterialRoute(page: AddProjectView),
  MaterialRoute(page: AddTasksView),
  MaterialRoute(page: TaskDetailView),
  MaterialRoute(page: ProjectDetailView),
  MaterialRoute(page: SplashView, initial: true),
], dependencies: [
  LazySingleton(
    classType: NavigationService,
  ),
  LazySingleton(
    classType: TimerService,
  ),
  LazySingleton(
    classType: ProjectCSVExportServices,
  ),
])
class AppSetup {}
