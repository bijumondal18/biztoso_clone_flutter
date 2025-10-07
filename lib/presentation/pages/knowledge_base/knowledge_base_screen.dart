import 'package:biztoso/presentation/widgets/custom_card.dart';
import 'package:biztoso/presentation/widgets/custom_primary_button.dart';
import 'package:biztoso/presentation/widgets/still_need_help_container.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/navigation/app_router.dart';
import '../../../core/themes/app_sizes.dart';
import '../../../data/models/language.dart';
import '../../blocs/user/user_bloc.dart';
import '../../widgets/appbar_icon.dart';
import '../../widgets/language_dropdown.dart';

class KnowledgeBaseScreen extends StatefulWidget {
  const KnowledgeBaseScreen({super.key});

  @override
  State<KnowledgeBaseScreen> createState() => _KnowledgeBaseScreenState();
}

class _KnowledgeBaseScreenState extends State<KnowledgeBaseScreen> {
  Language? selectedLanguage;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserBloc()..add(GetLanguageEvent()),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          leading: AppbarIcon(onPressed: () => appRouter.pop()),
          title: Text('Knowledge Base'),
          actions: [
            AppbarIcon(
              onPressed: () {},
              iconPath: CupertinoIcons.search,
              hasGradient: false,
            ),
          ],
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                left: AppSizes.kDefaultPadding,
                right: AppSizes.kDefaultPadding,
                top: AppSizes.kDefaultPadding,
              ),
              child: Text(
                'Select Your Preferred Language',
                style: Theme.of(
                  context,
                ).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.w600),
              ),
            ),
            BlocBuilder<UserBloc, UserState>(
              builder: (context, state) {
                if (state is GetLanguageStateLoaded) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: AppSizes.kDefaultPadding,
                      horizontal: AppSizes.kDefaultPadding,
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
                    horizontal: AppSizes.kDefaultPadding,
                  ),
                  child: LanguageDropdown(
                    languages: [],
                    selectedLanguage: selectedLanguage,
                    onChanged: (lang) {},
                  ),
                );
              },
            ),
            Flexible(
              child: ListView.builder(
                itemCount: 5,
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return CustomCard(
                    margin: EdgeInsets.symmetric(
                      horizontal: AppSizes.kDefaultPadding,
                      vertical: 4.0,
                    ),
                    child: Row(mainAxisSize: MainAxisSize.min, children: []),
                  );
                },
              ),
            ),
            /**
             * Help Container
             * */
            StillNeedHelpContainer(),
          ],
        ),
      ),
    );
  }
}
