import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import 'app_text.dart';

/// Custom Scaffold Widget - Reusable scaffold with consistent styling
/// Usage: AppScaffold(title: 'Home', body: yourWidget)
class AppScaffold extends StatelessWidget {
  final String? title;
  final Widget body;
  final Widget? floatingActionButton;
  final FloatingActionButtonLocation? floatingActionButtonLocation;
  final List<Widget>? actions;
  final Widget? leading;
  final Widget? bottomNavigationBar;
  final Widget? drawer;
  final Widget? endDrawer;
  final bool showAppBar;
  final bool centerTitle;
  final bool resizeToAvoidBottomInset;
  final Color? backgroundColor;
  final Color? appBarBackgroundColor;
  final PreferredSizeWidget? bottom;
  final VoidCallback? onBackPressed;
  final bool automaticallyImplyLeading;
  final double? elevation;

  const AppScaffold({
    super.key,
    this.title,
    required this.body,
    this.floatingActionButton,
    this.floatingActionButtonLocation,
    this.actions,
    this.leading,
    this.bottomNavigationBar,
    this.drawer,
    this.endDrawer,
    this.showAppBar = true,
    this.centerTitle = true,
    this.resizeToAvoidBottomInset = true,
    this.backgroundColor,
    this.appBarBackgroundColor,
    this.bottom,
    this.onBackPressed,
    this.automaticallyImplyLeading = true,
    this.elevation,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor ?? AppColors.background,
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      appBar: showAppBar ? _buildAppBar(context) : null,
      body: body,
      floatingActionButton: floatingActionButton,
      floatingActionButtonLocation: floatingActionButtonLocation,
      bottomNavigationBar: bottomNavigationBar,
      drawer: drawer,
      endDrawer: endDrawer,
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      title: title != null ? AppText.h5(title!) : null,
      centerTitle: centerTitle,
      backgroundColor: appBarBackgroundColor,
      elevation: elevation,
      leading:
          leading ??
          (onBackPressed != null
              ? IconButton(
                  icon: const Icon(Icons.arrow_back_ios),
                  onPressed: onBackPressed,
                )
              : null),
      automaticallyImplyLeading: automaticallyImplyLeading,
      actions: actions,
      bottom: bottom,
    );
  }
}

/// Scaffold with safe area padding
class AppSafeScaffold extends StatelessWidget {
  final String? title;
  final Widget body;
  final Widget? floatingActionButton;
  final FloatingActionButtonLocation? floatingActionButtonLocation;
  final List<Widget>? actions;
  final Widget? leading;
  final Widget? bottomNavigationBar;
  final bool showAppBar;
  final bool centerTitle;
  final Color? backgroundColor;
  final EdgeInsetsGeometry? padding;

  const AppSafeScaffold({
    super.key,
    this.title,
    required this.body,
    this.floatingActionButton,
    this.floatingActionButtonLocation,
    this.actions,
    this.leading,
    this.bottomNavigationBar,
    this.showAppBar = true,
    this.centerTitle = true,
    this.backgroundColor,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: title,
      showAppBar: showAppBar,
      centerTitle: centerTitle,
      backgroundColor: backgroundColor,
      actions: actions,
      leading: leading,
      floatingActionButton: floatingActionButton,
      floatingActionButtonLocation: floatingActionButtonLocation,
      bottomNavigationBar: bottomNavigationBar,
      body: SafeArea(
        child: Padding(
          padding: padding ?? const EdgeInsets.all(16),
          child: body,
        ),
      ),
    );
  }
}
