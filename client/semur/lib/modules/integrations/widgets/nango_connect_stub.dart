import 'package:flutter/material.dart';

class NangoConnectModal extends StatelessWidget {
  final String sessionToken;
  final Function(String) onConnect;
  final Function()? onClose;

  const NangoConnectModal({
    super.key,
    required this.sessionToken,
    required this.onConnect,
    this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.45,
      padding: const EdgeInsets.all(24),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.link_off, size: 48),
          const SizedBox(height: 16),
          const Text(
            'Nango Connect is currently available in the web build only.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 12),
          const Text(
            'Use Flutter web for the Semur class demo, or add native OAuth handling before enabling this screen on mobile.',
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () {
              onClose?.call();
              Navigator.of(context).pop();
            },
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }
}
