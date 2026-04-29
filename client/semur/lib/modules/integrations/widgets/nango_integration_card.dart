import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:semur/config/application.dart';
import 'package:semur/config/config.dart';
import 'package:semur/global/app_colors.dart';
import 'package:semur/global/app_user.dart';
import 'package:semur/global/log/log.dart';
import 'package:semur/global/widgets/default_modal_bottom_sheet.dart';
import 'package:semur/helpers/nango_integration_helper.dart';
import 'package:semur/models.pb/nango/nango.pbserver.dart';
import 'package:semur/modules/integrations/widgets/nango_connect.dart';
import 'package:semur/semur_engine/nango/nango_engine.dart';
import 'package:semur/services/notification_service.dart';

class NangoIntegrationCard extends StatefulWidget {
  final NangoIntegration integration;
  final Function()? onPressed;
  final Function()? onConnect;
  final bool isDisabled;

  const NangoIntegrationCard({
    super.key,
    required this.integration,
    this.onPressed,
    this.onConnect,
    this.isDisabled = false,
  });

  @override
  State<NangoIntegrationCard> createState() => _NangoIntegrationCardState();
}

class _NangoIntegrationCardState extends State<NangoIntegrationCard> {
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    // Size size = MediaQuery.sizeOf(context);
    return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed:
          widget.isDisabled
              ? null
              : () async {
                if (widget.onPressed != null) {
                  widget.onPressed!();
                } else {
                  setState(() {
                    loading = true;
                  });
                  // Get session token
                  try {
                    NangoSessionTokenResponseWrapper
                    responseWrapper = await NangoEngine.sessionToken(
                      isDev: Config.devMode,
                      requestModel: NangoSessionTokenRequestWrapper(
                        integrationId: widget.integration.id,
                        userId: AppUser.user.id,
                        userEmail: AppUser.user.email,
                        userName:
                            "${AppUser.user.firstName} ${AppUser.user.lastName}",
                      ),
                    );
                    if (!context.mounted) {
                      return;
                    }

                    if (!responseWrapper.isSuccess()) {
                      showNotification(
                        responseWrapper.response.message,
                        NotificationType.error,
                      );
                      setState(() {
                        loading = false;
                      });
                      return;
                    }

                    DefaultModalBottomSheet(
                      context: context,
                      isDismissible: true,
                      enableDrag: false,
                      canPop: false,
                    ).show(
                      NangoConnectModal(
                        sessionToken: responseWrapper.response.token,
                        onConnect: (String connectionId) {
                          Navigator.of(context).pop();
                          showNotification(
                            Application.appLocalizations!.success,
                            NotificationType.success,
                          );
                        },
                        onClose: () {
                          if (widget.onConnect != null) {
                            widget.onConnect!();
                          }
                        },
                      ),
                    );
                  } catch (e) {
                    Log.e("Error generating session token: ${e.toString()}");
                    showNotification(e.toString(), NotificationType.error);
                  }
                  if (!mounted) {
                    return;
                  }
                  setState(() {
                    loading = false;
                  });
                }
              },
      child: Container(
        padding: const EdgeInsets.all(10),
        constraints: const BoxConstraints(minHeight: 50, maxWidth: 360),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          color: AppColors.lightGrayColor,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Image
            Container(
              width: 50,
              height: 50,
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: AppColors.primaryColor, width: 1),
                color: Colors.transparent,
              ),
              child:
                  loading
                      ? SpinKitWave(color: AppColors.primaryColor, size: 20.0)
                      : widget.isDisabled
                      ? Icon(Icons.lock, color: AppColors.primaryColor)
                      : Image.asset(
                        NangoIntegrationHelper.getIntegrationImage(
                          widget.integration.id,
                        ),
                      ),
            ),
            const SizedBox(width: 10),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    widget.integration.name,
                    maxLines: 2,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(height: 5),
                  Text(
                    NangoIntegrationHelper.getIntegrationDescription(
                      widget.integration.id,
                    ),
                    maxLines: 2,
                    style: Theme.of(context).textTheme.bodySmall!,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
