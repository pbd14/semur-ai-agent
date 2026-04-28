import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:semur/config/application.dart';
import 'package:semur/global/adaptive_layout_manager.dart';
import 'package:semur/global/app_colors.dart';
import 'package:semur/global/log/log.dart';
import 'package:semur/services/notification_service.dart';
import 'package:semur/global/widgets/default_rounded_button.dart';

import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

class UserAcceptPolicyCard extends StatefulWidget {
  final Function onError;
  final Function(int policyVersion) onPressed;
  const UserAcceptPolicyCard({
    super.key,
    required this.onError,
    required this.onPressed,
  });

  @override
  State<UserAcceptPolicyCard> createState() => _UserAcceptPolicyCardState();
}

class _UserAcceptPolicyCardState extends State<UserAcceptPolicyCard> {
  bool isConfirmed = false;
  bool loading = true;

  int policyVersion = 0;
  String policyLink = "";

  WebViewController getWebViewController(String url) {
    WebViewController controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onHttpError: (HttpResponseError error) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith(url)) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(url));
    return controller;
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      try {
        DocumentSnapshot semurVars = await Application.firestore
            .collection('app_data')
            .doc('semur_vars')
            .get();
        if (mounted) {
          setState(() {
            policyVersion = semurVars.get('privacyPolicyVersion');
            policyLink = semurVars.get('privacyPolicyLink');
          });
        }
      } catch (e) {
        Log.e("Error in UserAcceptPolicyCard", e);
        widget.onError();
      }
      if (!mounted) {
        return;
      }
      setState(() {
        loading = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AdaptiveLayoutManager(
      centerVertically: false,
      config: AdaptiveLayoutConfig.allOneColumn().copyWith(
        maxContentWidth: 800,
      ),
      children: loading
          ? [
              Center(
                child: SpinKitWave(
                  color: AppColors.primaryColor,
                  size: 20,
                ),
              ),
            ]
          : [
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  Application.appLocalizations!.rules,
                  style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                        color: AppColors.primaryColor,
                        fontWeight: FontWeight.w700,
                      ),
                ),
              ),
              CupertinoButton(
                padding: const EdgeInsets.all(0),
                onPressed: () async {
                  await launchUrl(Uri.parse(policyLink));
                },
                child: Container(
                  height: 300,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    border:
                        Border.all(color: AppColors.primaryColor, width: 2.0),
                    color: kIsWeb ? AppColors.primaryColor : Colors.transparent,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(18.0),
                    child: AbsorbPointer(
                      child: kIsWeb
                          ? Center(
                              child: Text(
                                Application.appLocalizations!.viewDocument,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 10,
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineSmall!
                                    .copyWith(
                                      color: AppColors.secondaryColor,
                                      fontWeight: FontWeight.w700,
                                    ),
                              ),
                            )
                          : WebViewWidget(
                              controller: getWebViewController(
                                policyLink,
                              ),
                            ),
                    ),
                  ),
                ),
              ),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Theme(
                      data: Theme.of(context).copyWith(
                        unselectedWidgetColor: AppColors.primaryColor,
                      ),
                      child: Transform.scale(
                        scale: 1.5,
                        child: Checkbox(
                          value: isConfirmed,
                          onChanged: (value) {
                            setState(() {
                              isConfirmed = value!;
                            });
                          },
                          checkColor: AppColors.secondaryColor,
                          activeColor: AppColors.primaryColor,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      Application.appLocalizations!.iAgreeWithRules,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 10,
                      style: Theme.of(context).textTheme.bodyLarge!,
                    ),
                  ],
                ),
              ),
              Center(
                child: DefaultRoundedButton(
                  text: Application.appLocalizations!.continueText,
                  press: () async {
                    if (!isConfirmed) {
                      showNotification(
                        Application.appLocalizations!.error,
                        NotificationType.error,
                      );
                      return;
                    }
                    widget.onPressed(policyVersion);
                  },
                  color: AppColors.primaryColor,
                  textColor: AppColors.secondaryColor,
                ),
              ),
            ],
    );
  }
}
