import 'package:biztoso/core/navigation/app_router.dart';
import 'package:biztoso/core/navigation/screens.dart';
import 'package:biztoso/core/themes/app_sizes.dart';
import 'package:biztoso/data/repositories/post_repository.dart';
import 'package:biztoso/presentation/pages/home/components/build_story_list.dart';
import 'package:biztoso/presentation/pages/home/components/create_new_post_card.dart';
import 'package:biztoso/presentation/pages/home/components/home_appbar.dart';
import 'package:biztoso/presentation/widgets/appbar_icon.dart';
import 'package:biztoso/presentation/widgets/profile_avatar.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';

import '../../blocs/post/post_bloc.dart';
import '../../blocs/user/user_bloc.dart';
import 'components/build_post_list.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _scrollCtrl = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollCtrl.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollCtrl.removeListener(_onScroll);
    _scrollCtrl.dispose();
    super.dispose();
  }

  void _onScroll() {
    final bloc = context.read<PostBloc>();
    if (!_scrollCtrl.hasClients) return;

    final pos = _scrollCtrl.position;
    if (pos.pixels > pos.maxScrollExtent - 300) {
      bloc.add(const PostNextPageRequested());
    }
  }

  Future<void> _onRefresh() async {
    final bloc = context.read<PostBloc>();
    bloc.add(const PostRefreshed());
    await bloc.stream.firstWhere(
      (s) =>
          s is PostState &&
          (s.status == PostStatus.success || s.status == PostStatus.failure),
    );
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => UserBloc()..add(FetchProfileDetailsEvent()),
        ),
      ],
      child: Scaffold(
        appBar: HomeAppbar(),
        body: RefreshIndicator.adaptive(
          color: Theme.of(context).colorScheme.surfaceContainer,
          onRefresh: _onRefresh,
          child: CustomScrollView(
            controller: _scrollCtrl,
            physics: const AlwaysScrollableScrollPhysics(),
            slivers: [
              SliverToBoxAdapter(child: CreateNewPostCard()),

              SliverPadding(
                padding: EdgeInsets.symmetric(vertical: 8),
                sliver: BuildPostList(), // <- your posts
              ),

              // bottom loader when more pages exist
              BlocBuilder<PostBloc, PostState>(
                buildWhen: (p, c) =>
                    p.hasNextPage != c.hasNextPage || p.status != c.status,
                builder: (context, state) {
                  final show =
                      state.hasNextPage && (state.status == PostStatus.success);
                  if (!show) {
                    return const SliverToBoxAdapter(child: SizedBox.shrink());
                  }
                  return SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      child: Center(
                        child: CupertinoActivityIndicator(
                          color: Theme.of(context).colorScheme.surfaceContainer,
                        ),
                      ),
                    ),
                  );
                },
              ),

              const SliverToBoxAdapter(child: SizedBox(height: 24)),
            ],
          ),
        ),
      ),
    );
  }
}
