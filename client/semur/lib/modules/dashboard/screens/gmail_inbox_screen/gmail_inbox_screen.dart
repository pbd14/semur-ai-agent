import 'dart:async';
import 'package:auto_route/auto_route.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:semur/accessors/users/syncs/user_sync_google_mail_accessor.dart';
import 'package:semur/accessors/users/user_accessor.dart';
import 'package:semur/config/application.dart';
import 'package:semur/config/config.dart';
import 'package:semur/global/app_user.dart';
import 'package:semur/global/log/log.dart';
import 'package:semur/global/screens/loading_screen.dart';
import 'package:semur/global/app_colors.dart';

import 'package:semur/global/widgets/default_app_bar.dart';
import 'package:semur/models.pb/syncs/sync.pb.dart';
import 'package:semur/models.pb/syncs/sync_google-mail.pb.dart';
import 'package:semur/modules/dashboard/bloc/gmail_inbox_bloc/gmail_inbox_bloc.dart';
import 'package:semur/modules/dashboard/screens/gmail_inbox_screen/widgets/email_item_widget.dart';
import 'package:semur/modules/dashboard/screens/gmail_inbox_screen/widgets/sync_status_widget.dart';
import 'package:semur/semur_engine/syncs/google_mail_sync_engine.dart';
import 'package:semur/services/notification_service.dart';
import 'package:semur/transformers/syncs/sync_transformer.dart';

@RoutePage()
class GmailInboxScreen extends StatefulWidget {
  const GmailInboxScreen({super.key});

  @override
  State<GmailInboxScreen> createState() => _GmailInboxScreenState();
}

class _GmailInboxScreenState extends State<GmailInboxScreen> {
  bool isLoadingMore = false;
  bool isSyncing = false;
  final GmailInboxBloc bloc = GmailInboxBloc();
  StreamSubscription? syncInformationStreamSubscription;
  SyncInformation? syncInformation;
  final TextEditingController _searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  String _searchQuery = '';
  final String _sortOrder = 'newest'; // 'newest' or 'oldest'
  List<SyncGoogleMailEmail> _filteredEmails = [];
  List<SyncGoogleMailEmail> _allEmails = [];

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      bloc.add(const GmailInboxInitialize());
      setupSyncInformationStream();
    });

    _searchController.addListener(_onSearchChanged);
    super.initState();
  }

  @override
  void dispose() {
    bloc.close();
    syncInformationStreamSubscription?.cancel();
    _searchController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _loadMoreEmails() async {
    final currentState = bloc.state;
    if (currentState is GmailInboxInitial &&
        currentState.lastDocument != null) {
      setState(() {
        isLoadingMore = true;
      });
      // Load more emails when button is pressed
      await loadPageOfEmails(currentState.lastDocument);
      if (!mounted) {
        return;
      }
      setState(() {
        isLoadingMore = false;
      });
    }
  }

  void _onSearchChanged() {
    setState(() {
      _searchQuery = _searchController.text.toLowerCase();
      _filterAndSortEmails();
    });
  }

  Future<void> loadPageOfEmails(DocumentSnapshot? lastDocument) async {
    try {
      // TODO: Move this to Bloc?
      final (emails, newLastDocument) = await Application
          .accessors
          .userSyncGoogleMailAccessor
          .getQueryWithLastDocumentSnapshot(
            callerRole: AppUser.currentCallerRole,
            queryKey: UserSyncGoogleMailAccessorQueryKey.latestWithLastDocument,
            arguments: {
              "userId": AppUser.user.id,
              // TODO: Magic value
              "nangoIntegrationId": "google-mail",
              "lastDocument": lastDocument,
            },
          );

      if (mounted) {
        setState(() {
          _allEmails.addAll(emails);
          _filteredEmails.addAll(emails);
          lastDocument = newLastDocument;
        });
      } else {
        _allEmails.addAll(emails);
        _filteredEmails.addAll(emails);
        lastDocument = newLastDocument;
      }
    } catch (e) {
      showNotification(
        Application.appLocalizations!.errorTryAgainLater,
        NotificationType.error,
      );
    }
  }

  Future<void> _syncEmails() async {
    setState(() {
      isSyncing = true;
    });
    try {
      SyncGoogleMailEmailsFromNangoToFirestoreResponseWrapper responseWrapper =
          await SyncGoogleMailEngine.emails(
            isDev: Config.devMode,
            requestModel:
                SyncGoogleMailEmailsFromNangoToFirestoreRequestWrapper(
                  userId: AppUser.user.id,
                  // TODO: Magic value
                  integrationId: "google-mail",
                ),
          );
      if (responseWrapper.isSuccess()) {
        showNotification(
          // TODO: Text
          'Sync successful',
          NotificationType.success,
        );
      } else {
        Log.e("Error syncing emails: ${responseWrapper.response}");
        showNotification(
          Application.appLocalizations!.errorTryAgainLater,
          NotificationType.error,
        );
      }
    } catch (e) {
      showNotification(
        Application.appLocalizations!.errorTryAgainLater,
        NotificationType.error,
      );
    }
    if (!mounted) {
      return;
    }
    setState(() {
      isSyncing = false;
    });
  }

  Future<void> _refresh() async {
    bloc.add(const GmailInboxInitialize());
    Completer<void> completer = Completer<void>();
    completer.complete();
    return completer.future;
  }

  void _filterAndSortEmails() {
    List<SyncGoogleMailEmail> filtered =
        _allEmails.where((email) {
          if (_searchQuery.isEmpty) return true;

          final sender = email.hasSender() ? email.sender.toLowerCase() : '';
          final subject = email.hasSubject() ? email.subject.toLowerCase() : '';
          final body = email.hasBody() ? email.body.toLowerCase() : '';

          return sender.contains(_searchQuery) ||
              subject.contains(_searchQuery) ||
              body.contains(_searchQuery);
        }).toList();

    // Sort emails by date
    filtered.sort((a, b) {
      final aDate =
          a.hasDate()
              ? DateTime.fromMillisecondsSinceEpoch(
                a.date.seconds.toInt() * 1000,
              )
              : DateTime.now();
      final bDate =
          b.hasDate()
              ? DateTime.fromMillisecondsSinceEpoch(
                b.date.seconds.toInt() * 1000,
              )
              : DateTime.now();

      return _sortOrder == 'newest'
          ? bDate.compareTo(aDate)
          : aDate.compareTo(bDate);
    });

    setState(() {
      _filteredEmails = filtered;
    });
  }

  bool _shouldShowEmails() {
    if (syncInformation == null) return true;

    // Show emails if sync is completed, failed, or partially completed
    return syncInformation!.status == SyncStatus.COMPLETED ||
        syncInformation!.status == SyncStatus.FAILED ||
        syncInformation!.status == SyncStatus.PARTIALLY_COMPLETED;
  }

  String _getEmailCountText() {
    final totalEmails = _allEmails.length;
    final filteredCount = _filteredEmails.length;

    if (_searchQuery.isNotEmpty) {
      return '$filteredCount of $totalEmails emails match your search';
    } else {
      return '$totalEmails emails';
    }
  }

  Widget _buildNoSearchResults() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.search_off, size: 48, color: Colors.grey[400]),
        const SizedBox(height: 12),
        Text(
          'No emails found',
          style: Theme.of(context).textTheme.titleMedium,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 6),
        Text(
          'No emails match your search for "$_searchQuery"',
          style: TextStyle(color: Colors.grey[600], fontSize: 13),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildEmailList(GmailInboxInitial state) {
    if (_filteredEmails.isEmpty && _searchQuery.isEmpty) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.inbox_outlined, size: 48, color: Colors.grey[400]),
          const SizedBox(height: 12),
          Text(
            'No emails yet',
            style: Theme.of(context).textTheme.titleMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 6),
          Text(
            'Your Gmail emails will appear here once synced',
            style: TextStyle(color: Colors.grey[600], fontSize: 13),
            textAlign: TextAlign.center,
          ),
        ],
      );
    }

    // Calculate items to show including load more button
    int itemCount = _filteredEmails.length;
    if (state.lastDocument != null && _allEmails.length >= 20) {
      itemCount += 1; // Add one for load more button
    }

    return ListView.builder(
      controller: _scrollController,
      itemCount: itemCount,
      itemBuilder: (context, index) {
        // Show load more button at the end
        if (index >= _filteredEmails.length) {
          return IntrinsicWidth(
            child: Container(
              constraints: BoxConstraints(maxWidth: 400),
              padding: const EdgeInsets.all(12),
              child: ElevatedButton(
                onPressed: _loadMoreEmails,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.whiteColor,
                  foregroundColor: AppColors.primaryColor,
                  elevation: 0,
                  side: BorderSide(
                    color: AppColors.primaryColor.withValues(alpha: 0.2),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  isLoadingMore ? 'Loading...' : 'Load More Emails',
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
              ),
            ),
          );
        }

        // Show email item
        final email = _filteredEmails[index];
        return Padding(
          padding: EdgeInsets.fromLTRB(
            12,
            index == 0 ? 4 : 2, // Top padding for first item
            12,
            index == _filteredEmails.length - 1 &&
                    (state.lastDocument == null || _allEmails.length < 20)
                ? 4
                : 2, // Bottom padding for last item if no load more
          ),
          child: EmailItemWidget(
            email: email,
            onTap: () {
              // Handle email tap if needed
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: DefaultAppBar(
        appBar: AppBar(
          backgroundColor: AppColors.whiteColor.withValues(alpha: 0.4),
          foregroundColor: AppColors.primaryColor,
          elevation: 0,
          actions: [
            // Refresh button
            Container(
              margin: const EdgeInsets.all(10),
              child: IconButton(
                padding: EdgeInsets.zero,
                color: AppColors.primaryColor,
                icon: const Icon(CupertinoIcons.refresh_bold, size: 30),
                onPressed: _refresh,
              ),
            ),
          ],
        ),
      ),
      body: BlocListener(
        bloc: bloc,
        listener: blocListener,
        child: BlocBuilder(
          bloc: bloc,
          builder: (context, state) {
            if (state is GmailInboxLoading) {
              return const LoadingScreen();
            }
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 12),
              child: SafeArea(
                child: Column(
                  children: [
                    // Sync status (above email list)
                    if (syncInformation != null) ...[
                      Align(
                        alignment: Alignment.centerLeft,
                        child: SyncStatusWidget(
                          syncInformation: syncInformation,
                          onSync: _syncEmails,
                        ),
                      ),
                    ],
                    if (isSyncing)
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 8),
                        child: LinearProgressIndicator(),
                      ),
                    // Search bar
                    Container(
                      margin: const EdgeInsets.fromLTRB(12, 8, 12, 4),
                      child: TextField(
                        controller: _searchController,
                        style: const TextStyle(fontSize: 14),
                        decoration: InputDecoration(
                          hintText: 'Search emails...',
                          hintStyle: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[500],
                          ),
                          prefixIcon: Icon(
                            Icons.search,
                            size: 20,
                            color: Colors.grey[600],
                          ),
                          suffixIcon:
                              _searchQuery.isNotEmpty
                                  ? IconButton(
                                    icon: Icon(
                                      Icons.clear,
                                      size: 18,
                                      color: Colors.grey[600],
                                    ),
                                    onPressed: () {
                                      _searchController.clear();
                                    },
                                  )
                                  : null,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(color: Colors.grey[300]!),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(color: Colors.grey[300]!),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(
                              color: AppColors.primaryColor,
                            ),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 10,
                          ),
                          filled: true,
                          fillColor: Colors.grey[50],
                        ),
                      ),
                    ),

                    // Email count info
                    if (state is GmailInboxInitial &&
                        _shouldShowEmails() &&
                        _filteredEmails.isNotEmpty)
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 6,
                        ),
                        child: Text(
                          _getEmailCountText(),
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 12,
                          ),
                        ),
                      ),

                    // Email list or loading state
                    if (state is GmailInboxInitial) ...[
                      if (_shouldShowEmails()) ...[
                        // Email list
                        Expanded(
                          child: RefreshIndicator(
                            onRefresh: _refresh,
                            child:
                                _filteredEmails.isEmpty &&
                                        _searchQuery.isNotEmpty
                                    ? _buildNoSearchResults()
                                    : _buildEmailList(state),
                          ),
                        ),
                      ] else ...[
                        // Sync in progress message
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.all(32),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const SizedBox(
                                  width: 50,
                                  height: 50,
                                  child: CircularProgressIndicator(),
                                ),
                                const SizedBox(height: 24),
                                Text(
                                  'Syncing your emails...',
                                  style:
                                      Theme.of(context).textTheme.headlineSmall,
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  'Please wait while we sync your Gmail emails. This may take a few minutes.',
                                  style: TextStyle(color: Colors.grey[600]),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ] else if (state is GmailInboxError) ...[
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(32),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.error_outline,
                                size: 64,
                                color: Colors.red[300],
                              ),
                              const SizedBox(height: 16),
                              Text(
                                'Error Loading Emails',
                                style:
                                    Theme.of(context).textTheme.headlineSmall,
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 8),
                              Text(
                                state.errorText,
                                style: TextStyle(color: Colors.grey[600]),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 16),
                              ElevatedButton(
                                onPressed: _refresh,
                                child: const Text('Retry'),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void blocListener(BuildContext context, state) {
    if (state is GmailInboxError) {
      showNotification(state.errorText, NotificationType.error);
    } else if (state is GmailInboxInitial) {
      // Update emails when new data comes in
      if (state.emails.isNotEmpty) {
        setState(() {
          _allEmails = state.emails;
          _filterAndSortEmails();
        });
      }
    }
  }

  void setupSyncInformationStream() {
    // TODO: Move to accessor
    syncInformationStreamSubscription = Application.firestore
        .collection(UserAccessor.firebaseCollectionName)
        .doc(AppUser.user.id)
        .collection(
          UserSyncGoogleMailAccessor.firestoreNangoConnectionsSubcollectionName,
        )
        // TODO: Magic value
        .doc("google-mail")
        .collection(UserSyncGoogleMailAccessor.firebaseCollectionName)
        // TODO: Magic value
        .doc("sync")
        .snapshots()
        .listen((snapshot) {
          if (snapshot.exists) {
            if (mounted) {
              setState(() {
                syncInformation = SyncTransformer.fromFirebase(snapshot);
              });
            } else {
              syncInformation = SyncTransformer.fromFirebase(snapshot);
            }

            if (syncInformation?.status == SyncStatus.PENDING) {}
          }
        });
  }

  void startSync() {
    // TODO: To implement later
  }
}
