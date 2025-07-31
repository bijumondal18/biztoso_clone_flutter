import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

import '../../../../core/themes/app_sizes.dart';

class BuildStoryList extends StatefulWidget {
  const BuildStoryList({super.key});

  @override
  State<BuildStoryList> createState() => _BuildStoryListState();
}

class _BuildStoryListState extends State<BuildStoryList> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    return SizedBox(
      height: height * 0.18,
      child: ListView.separated(
        itemCount: 6,
        padding: EdgeInsets.symmetric(
          horizontal: AppSizes.kDefaultPadding / 2,
        ),
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final int itemCount = 6;
          final dashLength = 5.0;
          final spaceLength = (60 / itemCount).clamp(4.0, 25.0);
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: AppSizes.kDefaultPadding/2),
            child: DottedBorder(
              options: RoundedRectDottedBorderOptions(
                radius: Radius.circular(AppSizes.cardCornerRadius + 2),
                dashPattern: [dashLength, spaceLength],
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
    );
  }
}
