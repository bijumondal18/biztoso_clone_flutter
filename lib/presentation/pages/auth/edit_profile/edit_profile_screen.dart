import 'package:biztoso/presentation/widgets/name_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/navigation/app_router.dart';
import '../../../../core/themes/app_sizes.dart';
import '../../../../data/models/language.dart';
import '../../../blocs/user/user_bloc.dart';
import '../../../widgets/appbar_icon.dart';
import '../../../widgets/language_dropdown.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  Language? selectedLanguage;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserBloc()..add(GetLanguageEvent()),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          scrolledUnderElevation: AppSizes.elevationSmall,
          leading: AppbarIcon(onPressed: () => appRouter.pop()),
          title: Text(
            'Edit Profile',
            style: Theme.of(
              context,
            ).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.w900),
          ),
        ),
        body: ListView(
          padding: EdgeInsets.all(AppSizes.kDefaultPadding),
          children: [
            Text(
              'Primary Language',
              style: Theme.of(
                context,
              ).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.w600),
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
            Text(
              'Personal/Business Details',
              style: Theme.of(
                context,
              ).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: AppSizes.kDefaultPadding),
            NameTextField(
              controller: _nameController,
              hasPrefixIcon: false,
              hintText: 'Full Name',
              errorText: 'Please enter your full name',
            ),
            const SizedBox(height: AppSizes.kDefaultPadding),
            NameTextField(
              controller: _usernameController,
              hasPrefixIcon: false,
              hintText: 'Username',
              errorText: 'Please enter your username',
            ),
          ],
        ),
      ),
    );
  }
}
