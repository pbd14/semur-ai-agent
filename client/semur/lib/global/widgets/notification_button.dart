import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:semur/config/application.dart';
import 'package:semur/global/app_user.dart';
import 'package:semur/global/app_colors.dart';
import 'package:semur/global/log/log.dart';
import 'package:semur/models.pb/notifications/notification.pbenum.dart';

class NotificationButton extends StatefulWidget {
  final Color color;
  final Function onPressed;

  const NotificationButton({
    super.key,
    this.color = const Color.fromRGBO(0, 66, 37, 1.0),
    required this.onPressed,
  });

  @override
  State<NotificationButton> createState() => _NotificationButtonState();
}

class _NotificationButtonState extends State<NotificationButton> {
  int count = 0;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      try {
        if (AppUser.user.hasId() && FirebaseAuth.instance.currentUser != null) {
          Application.userNotificationsSubscription = Application.firestore
              .collection("users")
              .doc(AppUser.user.id)
              .collection("notifications")
              .where("status", isEqualTo: NotificationStatus.UNREAD.value)
              .snapshots()
              .listen(
                (event) {
                  if (mounted) {
                    setState(() {
                      count = event.docs.length;
                    });
                  } else {
                    count = event.docs.length;
                  }
                },
                onError: (e) {
                  Log.e("Error getting notification count", e);
                },
              );
        }
      } catch (e) {
        Log.e("Error getting notification count", e);
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    Application.userNotificationsSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: () {
        if (AppUser.user.hasId() && FirebaseAuth.instance.currentUser != null) {
          widget.onPressed();
        }
      },
      child: Container(
        padding: const EdgeInsets.all(8.0),
        width: 50,
        height: 50,
        child: Stack(
          children: [
            Center(
              child: Icon(
                CupertinoIcons.bell_fill,
                color: widget.color,
                size: 30,
              ),
            ),
            if (count > 0)
              Positioned(
                right: 0,
                top: 0,
                child: Container(
                  padding: const EdgeInsets.all(2.0),
                  decoration: BoxDecoration(
                    color: AppColors.secondaryColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  constraints: const BoxConstraints(
                    minWidth: 15,
                    minHeight: 10,
                  ),
                  child: Text(
                    count < 100 ? count.toString() : "99+",
                    style: TextStyle(
                      color: AppColors.primaryColor,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
