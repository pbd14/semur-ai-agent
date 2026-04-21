import 'dart:js_interop';
import 'dart:js_interop_unsafe';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:web/web.dart' as web;

class NangoConnectModal extends StatefulWidget {
  final String sessionToken;
  final Function(String) onConnect;
  final Function()? onClose;

  const NangoConnectModal({
    Key? key,
    required this.sessionToken,
    required this.onConnect,
    this.onClose,
  }) : super(key: key);

  @override
  State<NangoConnectModal> createState() => _NangoConnectModalState();
}

class _NangoConnectModalState extends State<NangoConnectModal> {
  bool _isLoading = true;
  bool _scriptLoaded = false;
  String? _error;
  String _status = 'Initializing...';

  @override
  void initState() {
    super.initState();
    _loadNangoAndInitialize();
  }

  Future<void> _loadNangoAndInitialize() async {
    try {
      await _loadNangoScript();

      setState(() {
        _scriptLoaded = true;
        _status = 'Script loaded, initializing Connect UI...';
      });

      // Give more time for the module to initialize
      await Future.delayed(Duration(milliseconds: 500));

      _initializeNango();
    } catch (e) {
      print('💥 Error loading Nango: $e');
      setState(() {
        _error = 'Failed to load: $e';
        _isLoading = false;
      });
    }
  }

  Future<void> _loadNangoScript() async {
    final completer = Completer<void>();

    // Check if Nango is already available
    if (_isNangoAvailable()) {
      completer.complete();
      return completer.future;
    }

    // Create a script that imports Nango as an ES module and makes it globally available
    final moduleScript = '''
      import Nango from 'https://cdn.skypack.dev/@nangohq/frontend';
      window.NangoClass = Nango;
      window.nangoLoaded = true;
      window.dispatchEvent(new CustomEvent('nangoLoaded'));
    ''';

    // Create script element with module type
    final script =
        web.document.createElement('script') as web.HTMLScriptElement;
    script.type = 'module';
    script.text = moduleScript;

    // Listen for the custom event
    final eventListener =
        ((web.Event event) {
          completer.complete();
        }).toJS;

    web.window.addEventListener('nangoLoaded', eventListener);

    // Add error handling
    script.addEventListener(
      'error',
      (web.Event event) {
        print('❌ Script error event fired');
        web.window.removeEventListener('nangoLoaded', eventListener);
        completer.completeError('Failed to load Connect UI script');
      }.toJS,
    );

    web.document.head!.appendChild(script);

    // Add timeout fallback
    Timer(Duration(seconds: 10), () {
      if (!completer.isCompleted) {
        web.window.removeEventListener('nangoLoaded', eventListener);
        completer.completeError('Timeout loading Connect UI module');
      }
    });

    return completer.future;
  }

  bool _isNangoAvailable() {
    try {
      final hasProperty = web.window.hasProperty('NangoClass'.toJS).toDart;
      final loaded = web.window.hasProperty('nangoLoaded'.toJS).toDart;
      return hasProperty && loaded;
    } catch (e) {
      return false;
    }
  }

  void _initializeNango() {
    try {
      // Check if Nango is available
      if (!_isNangoAvailable()) {
        throw Exception('Nango is not available on window object');
      }

      setState(() {
        _status = 'Creating connection instance...';
      });

      // Get Nango constructor
      final nangoClass = web.window.getProperty('NangoClass'.toJS);
      if (nangoClass == null) {
        throw Exception('NangoClass not found on window');
      }

      final nango = (nangoClass as JSFunction).callAsConstructor();

      setState(() {
        _status = 'Opening Connect UI...';
      });

      // Create event handler
      final onEventHandler =
          ((JSObject event) {
            try {
              final eventData = event.dartify() as Map<String, dynamic>?;
              if (eventData != null && eventData.containsKey('type')) {
                final eventType = eventData['type'] as String;

                if (eventType == 'close') {
                  print('❌ Connect UI closed');
                  if (mounted) {
                    widget.onClose?.call();
                    Navigator.pop(context);
                  }
                } else if (eventType == 'connect') {
                  print('🔗 Connect UI success: $eventData');
                  if (mounted) {
                    widget.onConnect(eventData.toString());
                    Navigator.pop(context);
                  }
                }
              }
            } catch (e) {
              print('Error processing event: $e');
            }
          }).toJS;

      // Create options object
      final options = {'onEvent': onEventHandler}.jsify() as JSObject;

      // Call openConnectUI
      final connectUI = (nango as JSObject).callMethod(
        'openConnectUI'.toJS,
        options,
      );

      setState(() {
        _status = 'Setting session token...';
      });

      (connectUI as JSObject).callMethod(
        'setSessionToken'.toJS,
        widget.sessionToken.toJS,
      );
      setState(() {
        _isLoading = false;
        _status = 'Ready!';
      });
    } catch (e, stackTrace) {
      print('💥 Error initializing Nango: $e');
      print('📋 Stack trace: $stackTrace');
      setState(() {
        _error = 'Failed to initialize Connect UI: $e';
        _isLoading = false;
      });
    }
  }

  void _retry() {
    setState(() {
      _error = null;
      _isLoading = true;
      _scriptLoaded = false;
      _status = 'Retrying...';
    });
    _loadNangoAndInitialize();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.8,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      child: Column(
        children: [
          // Handle bar
          Container(
            margin: const EdgeInsets.symmetric(vertical: 8),
            height: 4,
            width: 40,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(2),
            ),
          ),

          // Header
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Connect Account',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                IconButton(
                  onPressed: () {
                    widget.onClose?.call();
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.close),
                ),
              ],
            ),
          ),

          const Divider(height: 1),

          // Content
          Expanded(
            child:
                _error != null
                    ? Center(
                      child: Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.error_outline,
                              size: 64,
                              color: Colors.red,
                            ),
                            const SizedBox(height: 24),
                            Text(
                              'Error',
                              style: Theme.of(
                                context,
                              ).textTheme.headlineSmall?.copyWith(
                                color: Colors.red,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              _error!,
                              style: const TextStyle(color: Colors.red),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 32),
                            ElevatedButton.icon(
                              onPressed: _retry,
                              icon: const Icon(Icons.refresh),
                              label: const Text('Retry'),
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 32,
                                  vertical: 16,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                    : _isLoading
                    ? Center(
                      child: Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const CircularProgressIndicator(strokeWidth: 3),
                            const SizedBox(height: 24),
                            Text(
                              _status,
                              style: Theme.of(context).textTheme.titleMedium,
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              _scriptLoaded
                                  ? 'Connect UI module loaded successfully'
                                  : 'Loading Connect UI ES module...',
                              style: Theme.of(context).textTheme.bodyMedium
                                  ?.copyWith(color: Colors.grey[600]),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    )
                    : const Center(
                      child: Padding(
                        padding: EdgeInsets.all(24.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.check_circle_outline,
                              size: 64,
                              color: Colors.green,
                            ),
                            SizedBox(height: 24),
                            Text(
                              'Connect UI is ready!',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.green,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 16),
                            Text(
                              'The Connect UI should be displayed now.',
                              style: TextStyle(color: Colors.grey),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
          ),
        ],
      ),
    );
  }
}
