import 'package:flutter/material.dart';
import 'package:kanban_board_flutter/utils/dialogs.dart';
import 'package:kanban_board_flutter/utils/extensions.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../main.dart';

@override
Widget homeDrawer(
    {required BuildContext context, required onExport, required onLogout}) {
  return Drawer(
    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
    child: Column(
      children: <Widget>[
        Container(
          height: context.height * 0.2,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary,
          ),
          alignment: Alignment.center,
          child: Text(
            AppLocalizations.of(context)!.kanbanBoard,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Theme.of(context).textTheme.displayLarge!.color,
              fontSize: 24,
            ),
          ),
        ),
        ListTile(
          leading: Icon(
            Icons.download_rounded,
            color: Theme.of(context).textTheme.displayLarge!.color,
          ),
          title: Text(AppLocalizations.of(context)!.exportProjects,
              style: TextStyle(
                  color: Theme.of(context).textTheme.displayLarge!.color,
                  fontSize: 23,
                  fontWeight: FontWeight.bold)),
          onTap: () {
            // MyApp.of(context).changeTheme();

            Navigator.of(context).pop();
            Dialogs.showExportDialog(
              context: context,
              onExport: onExport,
            );
          },
        ),
        ListTile(
          leading: Icon(
            Icons.color_lens_rounded,
            color: Theme.of(context).textTheme.displayLarge!.color,
          ),
          title: Text(AppLocalizations.of(context)!.changeTheme,
              style: TextStyle(
                  color: Theme.of(context).textTheme.displayLarge!.color,
                  fontSize: 23,
                  fontWeight: FontWeight.bold)),
          onTap: () {
            MyApp.of(context).changeTheme();
          },
        ),
        SwitchListTile(
          title: Text(AppLocalizations.of(context)!.switchTo,
              style: TextStyle(
                  color: Theme.of(context).textTheme.displayLarge!.color,
                  fontSize: 23,
                  fontWeight: FontWeight.bold)),
          value: MyApp.of(context).locale == const Locale('fr') ? true : false,
          onChanged: (_) => MyApp.of(context).changeLocale(),
        ),
        const Spacer(),
        ListTile(
          leading: Icon(
            Icons.logout,
            color: Theme.of(context).textTheme.displayLarge!.color,
          ),
          title: Text(AppLocalizations.of(context)!.logOut,
              style: TextStyle(
                  color: Theme.of(context).textTheme.displayLarge!.color,
                  fontSize: 23,
                  fontWeight: FontWeight.bold)),
          onTap: onLogout,
        ),
        SizedBox(height: context.height * 0.05)
      ],
    ),
  );
}
