import 'package:biztoso/core/extensions/string_extensions.dart';
import 'package:biztoso/core/navigation/app_router.dart';
import 'package:biztoso/core/navigation/screens.dart';
import 'package:biztoso/core/themes/app_sizes.dart';
import 'package:biztoso/presentation/widgets/custom_outline_button.dart';
import 'package:biztoso/presentation/widgets/custom_primary_button.dart';
import 'package:biztoso/presentation/widgets/custom_secondary_button.dart';
import 'package:biztoso/presentation/widgets/email_text_field.dart';
import 'package:biztoso/presentation/widgets/horizontal_divider.dart';
import 'package:biztoso/presentation/widgets/password_text_field.dart';
import 'package:biztoso/presentation/widgets/themed_statusbar_wrapper.dart';
import 'package:biztoso/utils/snackbar_helper.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/resources/app_images.dart';
import '../../../blocs/auth/auth_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool isValidEmail = false;
  bool isValidPassword = false;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: ThemedStatusBarWrapper(
        child: Scaffold(
          body: Stack(
            children: [
              SvgPicture.asset(AppImages.splashBg, fit: BoxFit.cover),
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSizes.kDefaultPadding,
                  ),
                  child: ListView(
                    children: [
                      Center(
                        child: Text(
                          'Biztoso',
                          style: Theme.of(context).textTheme.displayLarge!
                              .copyWith(
                                color: Theme.of(context).primaryColor,
                                fontWeight: FontWeight.w900,
                                letterSpacing: 1.5,
                              ),
                        ),
                      ),
                      const SizedBox(height: AppSizes.kDefaultPadding * 2),
                      Text(
                        'Welcome Back!',
                        style: Theme.of(context).textTheme.headlineLarge,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: AppSizes.kDefaultPadding / 3,
                        ),
                        child: Text(
                          'Please enter your details to continue',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ),
                      const SizedBox(height: AppSizes.kDefaultPadding * 2),
                      EmailTextField(
                        controller: _emailController,
                        readOnly: false,
                        errorText: 'Please enter email address',
                        onChanged: (dynamic value) {
                          setState(() {
                            if (value.toString().isValidEmail) {
                              isValidEmail = true;
                            } else {
                              isValidEmail = false;
                            }
                          });
                        },
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return 'Please enter email address';
                          } else if (!value.isValidEmail) {
                            return 'Please enter a valid email address';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: AppSizes.kDefaultPadding),
                      PasswordTextField(
                        controller: _passwordController,
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return 'Please enter password';
                          } else if (!value.isValidPassword) {
                            return 'Password length should be greater than 6 digit';
                          }
                          return null;
                        },
                        onChanged: (dynamic value) {
                          setState(() {
                            if (value.toString().isValidPassword) {
                              isValidPassword = true;
                            } else {
                              isValidPassword = false;
                            }
                          });
                        },
                        errorText: 'Password not valid',
                      ),
                      const SizedBox(height: AppSizes.kDefaultPadding),
                      Align(
                        alignment: Alignment.centerRight,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(
                            AppSizes.cardCornerRadius,
                          ),
                          onTap: () {},
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: AppSizes.kDefaultPadding / 2,
                              horizontal: AppSizes.kDefaultPadding / 2,
                            ),
                            child: Text(
                              'Forgot Password?',
                              style: Theme.of(context).textTheme.titleSmall!
                                  .copyWith(
                                    color: Theme.of(context).primaryColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: AppSizes.kDefaultPadding),
                      BlocConsumer<AuthBloc, AuthState>(
                        listener: (context, state) {
                          if (state is LoginFailed) {
                            SnackBarHelper.show(state.error.toString());
                          }
                          if (state is LoginLoaded) {
                            appRouter.go(Screens.main);
                          }
                        },
                        builder: (context, state) {
                          if (state is LoginLoading) {
                            return Center(
                              child: CupertinoActivityIndicator(
                                color: Theme.of(
                                  context,
                                ).colorScheme.surfaceContainer,
                              ),
                            );
                          }
                          return CustomPrimaryButton(
                            label: 'Login',
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                BlocProvider.of<AuthBloc>(context).add(
                                  LoginWithEmailEvent(
                                    email: _emailController.text
                                        .trim()
                                        .toString(),
                                    password: _passwordController.text
                                        .trim()
                                        .toString(),
                                  ),
                                );
                              }
                            },
                          );
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: AppSizes.kDefaultPadding,
                        ),
                        child: Row(
                          spacing: AppSizes.kDefaultPadding,
                          children: [
                            Expanded(child: HorizontalDivider()),
                            Text(
                              'OR',
                              style: Theme.of(context).textTheme.labelMedium,
                            ),
                            Expanded(child: HorizontalDivider()),
                          ],
                        ),
                      ),
                      CustomOutlineButton(
                        label: 'Login with Phone',
                        hasRoundedCorner: true,
                        hasIcon: true,
                        iconPath: Icons.phone_android_rounded,
                        onPressed: () {},
                      ),
                      const SizedBox(height: AppSizes.kDefaultPadding),
                      CustomSecondaryButton(
                        label: 'Login with Google',
                        hasRoundedCorner: true,
                        hasIcon: true,
                        iconPath: EvaIcons.google,
                        bgColor: Theme.of(context).dividerColor.withAlpha(200),
                        onPressed: () {},
                      ),
                      const SizedBox(height: AppSizes.kDefaultPadding),
                      // CustomSecondaryButton(
                      //   label: 'Login with Apple',
                      //   hasRoundedCorner: true,
                      //   hasIcon: true,
                      //   iconPath: Icons.apple_rounded,
                      //   iconColor: Theme.of(context).scaffoldBackgroundColor,
                      //   bgColor: Theme.of(context).colorScheme.surfaceContainer,
                      //   labelColor: Theme.of(context).scaffoldBackgroundColor,
                      //   onPressed: () {},
                      // ),
                      // const SizedBox(height: AppSizes.kDefaultPadding / 2),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: AppSizes.kDefaultPadding,
                        ),
                        child: Row(
                          spacing: AppSizes.kDefaultPadding,
                          children: [
                            Expanded(child: HorizontalDivider()),
                            Text(
                              'OR',
                              style: Theme.of(context).textTheme.labelMedium,
                            ),
                            Expanded(child: HorizontalDivider()),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Don\'t have an account yet? ',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          InkWell(
                            onTap: () {},
                            borderRadius: BorderRadius.circular(
                              AppSizes.cardCornerRadius,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: AppSizes.kDefaultPadding / 2,
                                vertical: AppSizes.kDefaultPadding / 2,
                              ),
                              child: Text(
                                'Sign Up',
                                style: Theme.of(context).textTheme.bodyMedium!
                                    .copyWith(
                                      fontWeight: FontWeight.w600,
                                      color: Theme.of(context).primaryColor,
                                    ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
