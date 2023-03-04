import 'package:flutter/material.dart';
import 'package:kanban_board_flutter/views/home/tabs/my_projects_view.dart';
import 'package:kanban_board_flutter/views/home/tabs/other_projects_view.dart';
import 'package:kanban_board_flutter/views/home/widgets/home_drawer.dart';
import 'package:stacked/stacked.dart';
import '../../utils/colors.dart';
import '../../viewmodels/home_view_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
      viewModelBuilder: () => HomeViewModel(),
      builder: (context, viewModel, child) {
        return DefaultTabController(
          length: 2,
          child: Scaffold(
            key: viewModel.scaffoldkey,
            appBar: AppBar(
              iconTheme: const IconThemeData(
                color: ColorUtils.blackColor,
              ),
              backgroundColor: Theme.of(context).colorScheme.primary,
              elevation: 0,
              centerTitle: true,
              title: Text(
                AppLocalizations.of(context)!.projects,
                style: TextStyle(
                  color: Theme.of(context).textTheme.displayLarge!.color,
                ),
              ),
              leading: IconButton(
                icon: const Icon(Icons.menu, color: ColorUtils.primaryColor),
                onPressed: () {
                  viewModel.scaffoldkey.currentState!.openDrawer();
                },
              ),
            ),
            drawer: homeDrawer(
                context: context,
                onLogout: () {
                  viewModel.signOutAndClearStorage(context: context);
                },
                onExport: () {
                  viewModel.onExportProjects(context);
                }),
            body: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                children: [
                  TabBar(
                      unselectedLabelColor: ColorUtils.blackColor,
                      labelColor: ColorUtils.blackColor,
                      indicatorColor: Theme.of(context).colorScheme.primary,
                      tabs: [
                        Tab(
                          child: Center(
                            child: Text(
                              AppLocalizations.of(context)!.ownProjects,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 17,
                                  color: Theme.of(context)
                                      .textTheme
                                      .displayLarge!
                                      .color,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        Tab(
                          child: Center(
                            child: Text(
                              AppLocalizations.of(context)!.teamProjects,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 17,
                                  color: Theme.of(context)
                                      .textTheme
                                      .displayLarge!
                                      .color,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ]),
                  const Expanded(
                      child: TabBarView(children: [
                    MyProjectsView(),
                    OtherProjectsView(),
                  ]))
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
