import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:semur/config/application.dart';
import 'package:semur/config/config.dart';
import 'package:semur/global/app_user.dart';
import 'package:semur/global/app_colors.dart';
import 'package:semur/global/log/log.dart';
import 'package:semur/models.pb/agents/agent.pbenum.dart';
import 'package:semur/modules/chat/widgets/chat_component.dart';
import 'package:semur/modules/dashboard/widgets/collapsible_sidebar.dart';
import 'package:semur/models.pb/chats/chat.pb.dart';
import 'package:semur/semur_engine/agents/email_assistant_engine.dart';
import 'package:semur/semur_engine/semur_engine.dart';
import 'package:semur/transformers/users/chat_firebase_transformer.dart';
import 'package:semur/transformers/users/chat_messge_firebase_transformer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool isSidebarExpanded = false;

  String chatSessionId = Application.uuid.v4();
  // TODO: Move to ChatComponent
  StreamSubscription? messageSubscription;
  List<ChatMessage> messages = [];
  StreamSubscription? chatSessionsSubscription;
  List<ChatSession> chatSessions = [];
  bool isResponding = false;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setupMessageListener();
      setupChatSessionsListener();
    });
    super.initState();
  }

  @override
  void dispose() {
    messageSubscription?.cancel();
    chatSessionsSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);

    return Scaffold(
      key: _scaffoldKey,
      body: Row(
        children: [
          CollapsibleSidebar(
            isExpanded: isSidebarExpanded,
            chatSessions: chatSessions,
            selectedChatSessionId: chatSessionId,
            onToggle: () {
              setState(() {
                isSidebarExpanded = !isSidebarExpanded;
              });
            },
            onChatSelected: (chat) {
              if (mounted) {
                setState(() {
                  chatSessionId = chat.id;
                });
                setupMessageListener();
              } else {
                chatSessionId = chat.id;
                setupMessageListener();
              }
            },
            onNewChatSelected: () {
              if (mounted) {
                setState(() {
                  chatSessionId = Application.uuid.v4();
                });
                setupMessageListener();
              } else {
                chatSessionId = Application.uuid.v4();
                setupMessageListener();
              }
            },
          ),
          Expanded(
            child: Center(
              child: Container(
                constraints: BoxConstraints(maxWidth: size.width * 0.6),
                color: AppColors.whiteColor,
                child: ChatComponent(
                  messages: messages.toList(),
                  isLoading: isResponding,
                  onSendMessage: AppUser.isGuestMode() ? null : sendMessage,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> sendMessage(
    String userMessage,
    List<String> connectionIds,
    bool fastMode,
    bool proMode,
    AgentMood agentMood,
  ) async {
    Log.w("Sending message: $userMessage with connections: $connectionIds");
    setState(() {
      isResponding = true;
    });
    try {
      AgentChatOutputWrapper responseWrapper =
          await AgentEmailAssistantEngine.chat(
            isDev: Config.devMode,
            inputModel: AgentChatInputWrapper(
              userId: AppUser.user.id,
              sessionId: chatSessionId,
              connectionIds: connectionIds,
              userMessage: userMessage,
              fastMode: fastMode,
              proMode: proMode,
              agentMood: agentMood,
            ),
          );
      if (responseWrapper.isSuccess()) {}
    } catch (e) {
      Log.e("Error sending message: ${e.toString()}");
    }

    setState(() {
      isResponding = false;
    });
  }

  void setupMessageListener() {
    messageSubscription?.cancel();
    // Clear messages
    if (mounted) {
      setState(() {
        messages.clear();
      });
    } else {
      messages.clear();
    }

    // TODO: Move to accessor
    messageSubscription = Application.firestore
        .collection("users")
        .doc(AppUser.user.id)
        .collection("chats")
        .doc(chatSessionId)
        .collection("messages")
        .snapshots()
        .listen((QuerySnapshot snapshot) {
          List<ChatMessage> newMessages = [];
          for (DocumentSnapshot doc in snapshot.docs) {
            newMessages.add(ChatMessageFirebaseTransformer.fromFirebase(doc));
          }

          newMessages.sort((a, b) => a.id.compareTo(b.id));

          if (mounted) {
            setState(() {
              messages = newMessages;
            });
          } else {
            messages = newMessages;
          }
        });
  }

  void setupChatSessionsListener() {
    chatSessionsSubscription?.cancel();
    // Clear messages
    if (mounted) {
      setState(() {
        chatSessions.clear();
      });
    } else {
      chatSessions.clear();
    }

    // TODO: Move to accessor
    chatSessionsSubscription = Application.firestore
        .collection("users")
        .doc(AppUser.user.id)
        .collection("chats")
        .orderBy('createdAt', descending: true)
        .snapshots()
        .listen((QuerySnapshot snapshot) {
          List<ChatSession> newChatSessions = [];
          for (DocumentSnapshot doc in snapshot.docs) {
            newChatSessions.add(ChatFirebaseTransformer.fromFirebase(doc));
          }

          if (mounted) {
            setState(() {
              chatSessions = newChatSessions;
            });
          } else {
            chatSessions = newChatSessions;
          }
        });
  }

}
