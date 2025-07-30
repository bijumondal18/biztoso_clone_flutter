import 'package:biztoso/core/themes/app_sizes.dart';
import 'package:biztoso/presentation/widgets/horizontal_divider.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';

class ConnectionScreen extends StatefulWidget {
  const ConnectionScreen({super.key});

  @override
  State<ConnectionScreen> createState() => _ConnectionScreenState();
}

class _ConnectionScreenState extends State<ConnectionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).dividerColor.withAlpha(50),
      appBar: AppBar(
        title: Text(
          'Connections',
          style: Theme.of(
            context,
          ).textTheme.headlineLarge!.copyWith(fontWeight: FontWeight.w900),
        ),
      ),
      body: ListView(
        children: [
          ListTile(
            onTap: () {},
            dense: true,
            title: Text(
              'Invitations',
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.w600,
              ),
            ),
            trailing: Icon(
              EvaIcons.arrowIosForward,
              color: Theme.of(context).primaryColor,
            ),
          ),
          HorizontalDivider(),
          ListTile(
            onTap: () {},
            dense: true,
            title: Text(
              'People You May Know',
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.w600,
              ),
            ),
            trailing: Icon(
              EvaIcons.arrowIosForward,
              color: Theme.of(context).primaryColor,
            ),
          ),
          HorizontalDivider(),
          Container(
            margin: EdgeInsets.symmetric(
              horizontal: AppSizes.kDefaultPadding,
              vertical: AppSizes.kDefaultPadding,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppSizes.cardCornerRadius),
              border: Border.all(
                width: 1.0,
                color: Theme.of(context).dividerColor,
              ),
            ),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    left: AppSizes.kDefaultPadding/2,
                  ),
                  child: Icon(
                    EvaIcons.search,
                    color: Theme.of(context).hintColor,
                  ),
                ),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search connections here...',
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: AppSizes.kDefaultPadding/2,
                      ),
                      hintStyle: Theme.of(context).textTheme.bodyLarge!
                          .copyWith(color: Theme.of(context).hintColor),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: AppSizes.kDefaultPadding),
            child: Text(
              '6 Connections',
              style: Theme.of(
                context,
              ).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}
