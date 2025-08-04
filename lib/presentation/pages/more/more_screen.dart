import 'package:biztoso/core/themes/app_sizes.dart';
import 'package:biztoso/presentation/pages/more/widgets/more_tile.dart';
import 'package:biztoso/presentation/widgets/horizontal_divider.dart';
import 'package:flutter/material.dart';

import '../../../data/models/more_options.dart';

class MoreScreen extends StatefulWidget {
  const MoreScreen({super.key});

  @override
  State<MoreScreen> createState() => _MoreScreenState();
}

class _MoreScreenState extends State<MoreScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'More',
          style: Theme.of(
            context,
          ).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.w900),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: moreOptionsList
                  .map(
                    (moreOptions) =>
                        MoreTile(onPressed: () {}, moreOptions: moreOptions),
                  )
                  .toList(),
            ),
            HorizontalDivider(),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSizes.kDefaultPadding,
                vertical: AppSizes.kDefaultPadding,
              ),
              child: Text(
                'Support',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            Column(
              children: supportOptionsList
                  .map(
                    (moreOptions) =>
                        MoreTile(onPressed: () {}, moreOptions: moreOptions),
                  )
                  .toList(),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSizes.kDefaultPadding,
                vertical: AppSizes.kDefaultPadding * 3,
              ),
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  'App Version : v1.0.5 (234)',
                  style: Theme.of(context).textTheme.labelMedium,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
