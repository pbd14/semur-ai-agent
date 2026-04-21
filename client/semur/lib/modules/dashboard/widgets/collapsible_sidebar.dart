import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:semur/config/routing/router.dart';
import 'package:semur/global/app_colors.dart';
import 'package:semur/global/app_user.dart';
import 'package:semur/global/widgets/custom_dialog.dart';
import 'package:semur/config/application.dart';
import 'package:semur/models.pb/chats/chat.pbserver.dart';
import 'package:semur/modules/auth/bloc/auth/auth_bloc.dart';

class CollapsibleSidebar extends StatefulWidget {
  final bool isExpanded;
  final VoidCallback onToggle;
  final Function(ChatSession) onChatSelected;
  final Function() onNewChatSelected;
  final List<ChatSession> chatSessions;
  final String selectedChatSessionId;

  const CollapsibleSidebar({
    super.key,
    required this.isExpanded,
    required this.onToggle,
    required this.onChatSelected,
    required this.onNewChatSelected,
    required this.chatSessions,
    required this.selectedChatSessionId,
  });

  @override
  State<CollapsibleSidebar> createState() => _CollapsibleSidebarState();
}

class _CollapsibleSidebarState extends State<CollapsibleSidebar>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  Animation<double>? _widthAnimation;
  bool _isInitialized = false;
  String? _hoveredChatId;
  String? _menuOpenChatId;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_isInitialized) {
      _updateAnimation();
      _isInitialized = true;
    }
  }

  @override
  void didUpdateWidget(CollapsibleSidebar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.isExpanded != widget.isExpanded) {
      _updateAnimation();
    }
  }

  void _updateAnimation() {
    if (!mounted) return;

    final screenWidth = MediaQuery.sizeOf(context).width;
    final expandedWidth = screenWidth * 0.2 < 120 ? 120.0 : screenWidth * 0.2;

    _widthAnimation = Tween<double>(begin: 60, end: expandedWidth).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    if (widget.isExpanded) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_widthAnimation == null) {
      // Return a simple container while animation is being set up
      return Container(
        width: widget.isExpanded ? 200 : 60,
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 8,
              offset: const Offset(2, 0),
            ),
          ],
        ),
        child: _buildContent(),
      );
    }

    return AnimatedBuilder(
      animation: _widthAnimation!,
      builder: (context, child) {
        return Container(
          width: _widthAnimation!.value,
          decoration: BoxDecoration(
            color:
                widget.isExpanded
                    ? AppColors.darkWhiteColor
                    : AppColors.whiteColor,
          ),
          child: _buildContent(),
        );
      },
    );
  }

  Widget _buildContent() {
    return Column(
      children: [
        // Header with toggle button
        Container(
          height: 56, // Same as AppBar height
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: Icon(
                  widget.isExpanded
                      ? CupertinoIcons.chevron_left
                      : CupertinoIcons.line_horizontal_3,
                  color: AppColors.primaryColor,
                  size: 24,
                ),
                onPressed: widget.onToggle,
              ),
              if (widget.isExpanded) ...[
                Image.asset("assets/icons/Logo512.png", width: 24),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    "Semur",
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: AppColors.primaryColor,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),

        // Main options
        Expanded(
          child: ListView(
            padding: const EdgeInsets.symmetric(vertical: 8),
            children: [
              _buildMenuItem(
                icon: CupertinoIcons.mail,
                title: 'Inbox',
                onTap: () {
                  context.router.push(const GmailInboxRoute());
                },
              ),
              // TODO: Text
              _buildMenuItem(
                color: AppColors.secondaryColor,
                backgroundColor: AppColors.secondaryColor,
                icon: CupertinoIcons.plus_circle,
                title: 'New Chat',
                onTap: widget.onNewChatSelected,
              ),
              _buildMenuItem(
                icon: CupertinoIcons.chat_bubble_2,
                title: 'Chats',
                onTap: () {
                  // TODO: Implement chats view
                },
              ),
              _buildMenuItem(
                icon: Icons.apps,
                title: 'External apps',
                onTap: () {
                  context.router.push(AllExternalAppIntegrationsRoute());
                },
              ),
              _buildMenuItem(
                icon: Icons.extension,
                title: 'Integrations',
                onTap: () {
                  context.router.push(const AllIntegrationsRoute());
                },
              ),
              _buildMenuItem(
                icon: CupertinoIcons.settings,
                title: 'Settings',
                onTap: () {
                  // TODO: Implement settings
                },
              ),

              if (widget.isExpanded) ...[
                Divider(color: AppColors.darkColor, height: 32),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    'Recent Chats',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColors.darkColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                ...widget.chatSessions.map(
                  (chat) => _buildChatItem(chat, widget.onChatSelected),
                ),
              ],
            ],
          ),
        ),

        // Profile avatar at bottom
        Container(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              CircleAvatar(
                radius: 15,
                backgroundColor: AppColors.primaryColor,
                child: Icon(
                  CupertinoIcons.person_fill,
                  color: AppColors.whiteColor,
                  size: 15,
                ),
              ),
              if (widget.isExpanded) ...[
                const SizedBox(width: 6),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "${AppUser.user.firstName} ${AppUser.user.lastName}",
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      GestureDetector(
                        onTap: _showLogoutDialog,
                        child: Text(
                          Application.appLocalizations!.logout,
                          style: Theme.of(
                            context,
                          ).textTheme.bodySmall?.copyWith(
                            color: Colors.red[300],
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    Color? color,
    Color? backgroundColor,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(8),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(8),
          hoverColor:
              backgroundColor?.withValues(alpha: 0.1) ??
              AppColors.primaryColor.withValues(alpha: 0.1),
          splashColor:
              backgroundColor?.withValues(alpha: 0.2) ??
              AppColors.primaryColor.withValues(alpha: 0.2),
          highlightColor:
              backgroundColor?.withValues(alpha: 0.15) ??
              AppColors.primaryColor.withValues(alpha: 0.15),
          child: Container(
            height: 48,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              children: [
                Icon(icon, color: color ?? AppColors.darkColor, size: 20),
                if (widget.isExpanded) ...[
                  const SizedBox(width: 16),
                  Expanded(
                    child: Text(
                      title,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: color ?? AppColors.darkColor,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildChatItem(
    ChatSession chat,
    Function(ChatSession) onChatSelected,
  ) {
    final isHovered = _hoveredChatId == chat.id;
    final isMenuOpen = _menuOpenChatId == chat.id;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 1),
      child: Column(
        children: [
          Material(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(6),
            child: MouseRegion(
              onEnter: (_) => setState(() => _hoveredChatId = chat.id),
              onExit: (_) => setState(() => _hoveredChatId = null),
              child: InkWell(
                onTap: () => onChatSelected(chat),
                borderRadius: BorderRadius.circular(6),
                hoverColor: AppColors.primaryColor.withValues(alpha: 0.08),
                splashColor: AppColors.primaryColor.withValues(alpha: 0.15),
                highlightColor: AppColors.primaryColor.withValues(alpha: 0.1),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color:
                        widget.selectedChatSessionId == chat.id
                            ? AppColors.primaryColor.withValues(alpha: 0.12)
                            : Colors.transparent,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        CupertinoIcons.chat_bubble,
                        color: AppColors.darkColor.withValues(alpha: 0.7),
                        size: 16,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          chat.title,
                          style: Theme.of(
                            context,
                          ).textTheme.bodySmall?.copyWith(
                            color: AppColors.darkColor.withValues(
                              alpha:
                                  widget.selectedChatSessionId == chat.id
                                      ? 1.0
                                      : 0.8,
                            ),
                            fontWeight:
                                widget.selectedChatSessionId == chat.id
                                    ? FontWeight.w700
                                    : FontWeight.w500,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (isHovered || isMenuOpen) ...[
                        const SizedBox(width: 8),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _menuOpenChatId = isMenuOpen ? null : chat.id;
                            });
                          },
                          child: Container(
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: AppColors.darkColor.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Icon(
                              CupertinoIcons.ellipsis,
                              color: AppColors.darkColor.withValues(alpha: 0.7),
                              size: 14,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ),
          ),
          if (isMenuOpen)
            Container(
              margin: const EdgeInsets.only(left: 28, top: 4),
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildChatMenuOption(
                    icon: CupertinoIcons.pencil,
                    title: 'Rename',
                    onTap: () {
                      setState(() => _menuOpenChatId = null);
                      // TODO: Implement rename functionality
                    },
                  ),
                  const SizedBox(height: 4),
                  _buildChatMenuOption(
                    icon: CupertinoIcons.delete,
                    title: 'Delete',
                    onTap: () {
                      setState(() => _menuOpenChatId = null);
                      // TODO: Implement delete functionality
                    },
                    isDestructive: true,
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildChatMenuOption({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    bool isDestructive = false,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(4),
        hoverColor:
            isDestructive
                ? Colors.red.withValues(alpha: 0.1)
                : AppColors.primaryColor.withValues(alpha: 0.08),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(
                icon,
                color:
                    isDestructive
                        ? Colors.red[400]
                        : AppColors.darkColor.withValues(alpha: 0.7),
                size: 14,
              ),
              const SizedBox(width: 8),
              Text(
                title,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color:
                      isDestructive
                          ? Colors.red[400]
                          : AppColors.darkColor.withValues(alpha: 0.8),
                  fontWeight: FontWeight.w500,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showLogoutDialog() {
    showDialog(
      barrierDismissible: true,
      context: context,
      builder: (BuildContext context) {
        return CustomDialog(
          title: Application.appLocalizations!.logoutText,
          text: Application.appLocalizations!.logoutText2,
          onSubmitted: () {
            BlocProvider.of<AuthBloc>(context).add(const AuthSignOut());
            Navigator.of(context).pop(false);
          },
        );
      },
    );
  }
}
