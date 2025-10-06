import 'package:biztoso/data/models/user.dart';
import 'package:biztoso/presentation/widgets/horizontal_divider.dart';
import 'package:biztoso/presentation/widgets/language_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/navigation/app_router.dart';
import '../../../core/themes/app_sizes.dart';
import '../../../data/models/language.dart';
import '../../blocs/user/user_bloc.dart';
import '../../widgets/appbar_icon.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _switchPushNotification = false;
  bool _switchEmailNotification = false;
  bool _switchSmsNotification = false;

  Language? selectedLanguage;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserBloc()..add(GetLanguageEvent()),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          leading: AppbarIcon(onPressed: () => appRouter.pop()),
          title: Text('Settings'),
        ),
        body: ListView(
          padding: EdgeInsets.all(AppSizes.kDefaultPadding),
          children: [
            Row(
              spacing: AppSizes.kDefaultPadding / 2,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.translate_rounded,
                  color: Theme.of(context).colorScheme.surfaceContainer,
                ),
                Text(
                  'Language',
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            BlocBuilder<UserBloc, UserState>(
              builder: (context, state) {
                if (state is GetLanguageStateLoaded) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: AppSizes.kDefaultPadding,
                    ),
                    child: LanguageDropdown(
                      languages: state.getLanguage.result ?? [],
                      selectedLanguage: selectedLanguage,
                      onChanged: (lang) {
                        setState(() {
                          selectedLanguage = lang;
                        });
                      },
                    ),
                  );
                }
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: AppSizes.kDefaultPadding,
                  ),
                  child: LanguageDropdown(
                    languages: [],
                    selectedLanguage: selectedLanguage,
                    onChanged: (lang) {},
                  ),
                );
              },
            ),
            const SizedBox(height: AppSizes.kDefaultPadding),
            Row(
              spacing: AppSizes.kDefaultPadding / 2,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.notifications_none_rounded,
                  color: Theme.of(context).colorScheme.surfaceContainer,
                ),
                Text(
                  'Notification Settings',
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 30,
                top: AppSizes.kDefaultPadding,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Push Notifications',
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Get push notifications in-app to find out what\'s going on when you\'re online.',
                          style: Theme.of(context).textTheme.titleSmall!
                              .copyWith(
                                color: Theme.of(
                                  context,
                                ).colorScheme.surfaceContainer.withAlpha(200),
                              ),
                        ),
                      ),
                      const SizedBox(width: AppSizes.kDefaultPadding),
                      Switch(
                        value: _switchPushNotification,
                        onChanged: (value) {
                          setState(() {
                            _switchPushNotification = value;
                          });
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSizes.kDefaultPadding),
                  Text(
                    'Email Notifications',
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Get emails to find out what\'s going on when you\'re not online. Yo can turn these off.',
                          style: Theme.of(context).textTheme.titleSmall!
                              .copyWith(
                                color: Theme.of(
                                  context,
                                ).colorScheme.surfaceContainer.withAlpha(200),
                              ),
                        ),
                      ),
                      const SizedBox(width: AppSizes.kDefaultPadding),
                      Switch(
                        value: _switchEmailNotification,
                        onChanged: (value) {
                          setState(() {
                            _switchEmailNotification = value;
                          });
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSizes.kDefaultPadding),
                  Text(
                    'SMS Notifications',
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Get sms to find out what\'s going on when you\'re not online. Yo can turn these off.',
                          style: Theme.of(context).textTheme.titleSmall!
                              .copyWith(
                                color: Theme.of(
                                  context,
                                ).colorScheme.surfaceContainer.withAlpha(200),
                              ),
                        ),
                      ),
                      const SizedBox(width: AppSizes.kDefaultPadding),
                      Switch(
                        value: _switchSmsNotification,
                        onChanged: (value) {
                          setState(() {
                            _switchSmsNotification = value;
                          });
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: AppSizes.kDefaultPadding * 2,
              ),
              child: const HorizontalDivider(),
            ),
            _SettingsTile(
              label: 'Privacy Settings',
              iconData: Icons.remove_red_eye_outlined,
            ),
            _SettingsTile(
              label: 'Security Settings',
              iconData: Icons.security_rounded,
            ),
            _SettingsTile(
              label: 'Terms & Conditions',
              iconData: Icons.ten_k_rounded,
            ),
            _SettingsTile(
              label: 'Privacy Policy',
              iconData: Icons.privacy_tip_outlined,
            ),
            _SettingsTile(
              label: 'Cookie Policy',
              iconData: Icons.policy_outlined,
            ),
            _SettingsTile(
              label: 'About Us',
              iconData: Icons.info_outline_rounded,
            ),
            const SafeArea(child: SizedBox()),
          ],
        ),
      ),
    );
  }
}

class _SettingsTile extends StatelessWidget {
  final IconData? iconData;
  final String label;

  const _SettingsTile({super.key, this.iconData, required this.label});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSizes.kDefaultPadding / 2,
        vertical: AppSizes.kDefaultPadding,
      ),
      child: Row(
        spacing: AppSizes.kDefaultPadding,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            iconData,
            size: 20,
            color: Theme.of(context).colorScheme.surfaceContainer,
          ),
          Text(
            label,
            style: Theme.of(
              context,
            ).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
