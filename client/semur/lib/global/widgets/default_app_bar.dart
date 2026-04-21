import 'package:flutter/material.dart';
import 'package:semur/global/widgets/glass_wrapper.dart';
import 'package:semur/global/app_colors.dart';

class DefaultAppBar extends StatelessWidget implements PreferredSizeWidget {
  final AppBar? appBar;
  final List<Widget> actions;

  const DefaultAppBar({
    super.key,
    this.appBar,
    this.actions = const [],
  });

  @override
  Size get preferredSize => const Size(double.infinity, 56);

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size(double.infinity, 56),
      child: GlassWrapper(
        sigma: 5,
        child: appBar ??
            AppBar(
              elevation: 0,
              automaticallyImplyLeading: true,
              foregroundColor: AppColors.primaryColor,
              backgroundColor:
                  AppColors.whiteColor.withValues(alpha: 0.4),
              actions: actions,
            ),
      ),
    );
  }
}
