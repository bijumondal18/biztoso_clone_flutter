import 'package:biztoso/core/navigation/app_router.dart';
import 'package:biztoso/core/navigation/screens.dart';
import 'package:biztoso/core/themes/app_sizes.dart';
import 'package:biztoso/presentation/pages/home/components/create_new_post_card.dart';
import 'package:biztoso/presentation/pages/home/components/home_appbar.dart';
import 'package:biztoso/presentation/widgets/appbar_icon.dart';
import 'package:biztoso/presentation/widgets/profile_avatar.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      backgroundColor: Theme.of(context).dividerColor.withAlpha(50),
      appBar: HomeAppbar(),
      body: ListView(
        children: [
          CreateNewPostCard(),
          SizedBox(
            height: height * 0.18,
            child: ListView.separated(
              itemCount: 6,
              padding: EdgeInsets.symmetric(
                horizontal: AppSizes.kDefaultPadding / 2,
              ),
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: DottedBorder(
                    options: RoundedRectDottedBorderOptions(
                      radius: Radius.circular(AppSizes.cardCornerRadius + 2),
                      dashPattern: [10, 2],
                      strokeWidth: 1.5,
                    ),
                    child: Container(
                      width: width * 0.25,
                      padding: EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          AppSizes.cardCornerRadius,
                        ),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(
                          AppSizes.cardCornerRadius,
                        ),
                        child: Image.network(
                          'https://media.istockphoto.com/id/1436794232/photo/what-is-your-story-speech-bubble-isolated-on-the-yellow-background.jpg?s=612x612&w=0&k=20&c=hAghJgGBAikKfsc8LIEC5Bw3_fcwP5YiVDhxMP2ol7c=',
                          width: width * 0.25,
                          height: height * 0.18,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return SizedBox(width: AppSizes.kDefaultPadding / 1.5);
              },
            ),
          ),
        ],
      ),
    );
  }
}
