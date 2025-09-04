import 'package:biztoso/core/resources/app_images.dart';
import 'package:biztoso/presentation/pages/blog/components/blog_list_shimmer.dart';
import 'package:biztoso/utils/date_time_utils.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/navigation/app_router.dart';
import '../../../core/themes/app_sizes.dart';
import '../../../data/models/blog_response.dart';
import '../../blocs/blog/blog_bloc.dart';
import '../../widgets/appbar_icon.dart';

class BlogScreen extends StatefulWidget {
  const BlogScreen({super.key});

  @override
  State<BlogScreen> createState() => _BlogScreenState();
}

class _BlogScreenState extends State<BlogScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: AppbarIcon(onPressed: () => appRouter.pop()),
        title: Text(
          'Blogs',
          style: Theme.of(
            context,
          ).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.w900),
        ),
      ),
      body: BlocBuilder<BlogBloc, BlogState>(
        builder: (context, state) {
          if (state is BlogStateLoading) {
            return const ShimmerBlogList();
          }
          if (state is BlogStateFailed) {
            return Center(
              child: Text(
                state.error,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: Theme.of(
                    context,
                  ).colorScheme.surfaceContainer.withAlpha(150),
                  fontWeight: FontWeight.w600,
                ),
              ),
            );
          }
          if (state is BlogStateLoaded) {
            final rows = state.rows;

            return ListView.builder(
              padding: const EdgeInsets.only(
                top: AppSizes.kDefaultPadding,
                bottom: AppSizes.kDefaultPadding*2,
                left: AppSizes.kDefaultPadding,
                right: AppSizes.kDefaultPadding,
              ),
              itemCount: rows.length,
              itemBuilder: (context, index) {
                final row = rows[index];

                if (row is HeaderRow) {
                  return _Header(title: row.title);
                } else if (row is BlogRow) {
                  final b = row.blog;
                  return _BlogTile(
                    title: b.title ?? '',
                    subtitle: b.summary ?? '',
                    imageUrl: b.blogImage,
                    date: b.createdAt,
                    onTap: () {
                      // Navigate to details using b.sId
                    },
                  );
                }
                return const SizedBox.shrink();
              },
            );
          }
          return const ShimmerBlogList();
        },
      ),
    );
  }
}

class _Header extends StatelessWidget {
  final String title;

  const _Header({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSizes.kDefaultPadding),
      child: Text(
        title,
        style: Theme.of(
          context,
        ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
      ),
    );
  }
}

class _BlogTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final String? imageUrl;
  final String? date;
  final VoidCallback? onTap;

  const _BlogTile({
    super.key,
    required this.title,
    required this.subtitle,
    this.imageUrl,
    this.date,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSizes.kDefaultPadding),
      child: Row(
        spacing: AppSizes.kDefaultPadding,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(AppSizes.cardCornerRadius),
            child: CachedNetworkImage(
              imageUrl: imageUrl ?? '',
              width: width * 0.22,
              height: width * 0.23,
              fit: BoxFit.cover,
              placeholder: (context, value) =>
                  Image.asset(AppImages.blogPlaceholder, fit: BoxFit.cover),
              errorWidget: (context, value, error) =>
                  Image.asset(AppImages.blogPlaceholder, fit: BoxFit.cover),
            ),
          ),
          Expanded(
            child: Column(
              spacing: 4.0,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(
                    context,
                  ).textTheme.titleSmall!.copyWith(fontWeight: FontWeight.w600),
                ),
                Text(
                  subtitle,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.labelLarge!.copyWith(
                    color: Theme.of(context).hintColor,
                  ),
                ),
                Text(
                  '📅 ${DateTimeUtils.formatToDayMonthYear(date ?? '')}',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.labelLarge!.copyWith(
                    color: Theme.of(context).hintColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
