import 'package:flutter/material.dart';
import 'package:semur/config/application.dart';
import 'package:url_launcher/url_launcher.dart';

class AppPolicyButton extends StatelessWidget {
  const AppPolicyButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () async {
        // TODO: Use value from firebase
        await launchUrl(Uri.https('semur.ai',
            '/docs/privacy-policy.html'));
      },
      child: Container(
        padding:
            const EdgeInsets.fromLTRB(20, 0, 20, 0),
        child: Text(
          Application.appLocalizations!.terms,
          textScaler: const TextScaler.linear(1),
          style:
              Theme.of(context).textTheme.bodyMedium,
        ),
      ),
    );
  }
}
