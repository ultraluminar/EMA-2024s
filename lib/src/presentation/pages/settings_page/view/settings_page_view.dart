import 'package:flutter/material.dart';
import 'package:fridge_manager/l10n/l10n.dart';
import 'package:fridge_manager/src/presentation/pages/settings_page/widgets/theme_list_tile.dart';
import 'package:fridge_manager/src/presentation/pages/settings_page/widgets/widgets.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  static Route<void> route() {
    return MaterialPageRoute(
      fullscreenDialog: true,
      builder: (context) {
        return const SettingsPage();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return const SettingsPageView();
  }
}

class SettingsPageView extends StatelessWidget {
  const SettingsPageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar.large(
            title: Text(S.of(context).settingsPageAppBarTitle),
            backgroundColor: Theme.of(context).colorScheme.surface,
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                const DailyNotificationTimeListTile(),
                const ThemeListTile(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
