import 'package:biztoso/presentation/pages/auth/profile/widgets/verified_badge.dart';
import 'package:biztoso/presentation/pages/auth/profile/widgets/verify_now_button.dart';
import 'package:biztoso/presentation/pages/auth/verification/components/verification_scheen_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../core/navigation/app_router.dart';
import '../../../../core/themes/app_sizes.dart';
import '../../../blocs/user/user_bloc.dart';
import '../../../widgets/appbar_icon.dart';

class VerificationScreen extends StatelessWidget {
  const VerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: AppSizes.elevationSmall,
        leading: AppbarIcon(onPressed: () => appRouter.pop()),
        title: Text(
          'Verification',
          style: Theme.of(
            context,
          ).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.w900),
        ),
        centerTitle: true,
      ),
      body: BlocProvider(
        create: (context) => UserBloc()..add(FetchProfileDetailsEvent()),
        child: BlocBuilder<UserBloc, UserState>(
          builder: (context, state) {
            if (state is FetchUserProfileStateLoading) {
              return const VerificationShimmer();
            }
            if (state is FetchUserProfileStateLoaded) {
              bool? isIdentityVerified =
                  state.profileResponse.result?.documentVerify;
              bool? isEmailVerified = state.profileResponse.result?.emailVerify;
              bool? isPhoneVerified = state.profileResponse.result?.phoneVerify;
              return ListView(
                padding: EdgeInsets.all(AppSizes.kDefaultPadding),
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      top: AppSizes.kDefaultPadding / 2,
                    ),
                    child: Text(
                      'Verify Your Information',
                      style: Theme.of(context).textTheme.displaySmall,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: AppSizes.kDefaultPadding / 2,
                    ),
                    child: Text(
                      'Complete the verification steps to secure your account and protect your information.',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),

                  const SizedBox(height: AppSizes.kDefaultPadding * 2),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: AppSizes.kDefaultPadding / 1.5,
                    ),
                    child: Row(
                      spacing: AppSizes.kDefaultPadding,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        VerifiedBadge(
                          iconData: Icons.person,
                          isVerified: isIdentityVerified ?? false,
                          radius: 50,
                        ),
                        Expanded(
                          child: Text(
                            'Identity Verification',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ),
                        VerifyNowButton(
                          isVerified: isIdentityVerified ?? false,
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: AppSizes.kDefaultPadding / 1.5,
                    ),
                    child: Row(
                      spacing: AppSizes.kDefaultPadding,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        VerifiedBadge(
                          iconData: Icons.email_rounded,
                          isVerified: isEmailVerified ?? false,
                          radius: 50,
                        ),
                        Expanded(
                          child: Text(
                            'Email Verification',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ),
                        VerifyNowButton(
                          isVerified: isEmailVerified ?? false,
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: AppSizes.kDefaultPadding / 1.5,
                    ),
                    child: Row(
                      spacing: AppSizes.kDefaultPadding,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        VerifiedBadge(
                          iconData: Icons.call,
                          isVerified: isPhoneVerified ?? false,
                          radius: 50,
                        ),
                        Expanded(
                          child: Text(
                            'Phone Verification',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ),
                        VerifyNowButton(
                          isVerified: isPhoneVerified ?? false,
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }
            return const VerificationShimmer();
          },
        ),
      ),
    );
  }
}
