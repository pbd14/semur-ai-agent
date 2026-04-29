import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:semur/config/application.dart';
import 'package:semur/config/config.dart';
import 'package:semur/global/app_colors.dart';
import 'package:semur/global/app_user.dart';
import 'package:semur/global/widgets/default_text_form_field.dart';
import 'package:semur/models.pb/agents/email_assistant.pb.dart';
import 'package:semur/models.pb/syncs/sync_google-mail.pb.dart';
import 'package:semur/semur_engine/agents/email_assistant_engine.dart';
import 'package:semur/semur_engine/nango/google_mail_engine.dart';
import 'package:semur/services/notification_service.dart';

import '../../../global/log/log.dart';

class EmailDetailOverlay extends StatefulWidget {
  final EmailAssistantMentionedEmail email;

  const EmailDetailOverlay({super.key, required this.email});

  @override
  State<EmailDetailOverlay> createState() => _EmailDetailOverlayState();
}

class _EmailDetailOverlayState extends State<EmailDetailOverlay>
    with SingleTickerProviderStateMixin {
  final TextEditingController _recipientController = TextEditingController();
  final TextEditingController _subjectController = TextEditingController();
  final TextEditingController _bodyController = TextEditingController();

  bool _responseLoading = false;
  bool _responseGenerated = false;
  bool _responseError = false;
  bool _sendLoading = false;
  bool _sendSuccess = false;
  SyncGoogleMailEmail? email;
  late AnimationController _animationController;
  late Animation<Offset> _slideAnimation;

  Future<void> getEmail() async {
    SyncGoogleMailEmail emailFromFirestore = await Application
        .accessors
        .userSyncGoogleMailAccessor
        .get(
          userId: AppUser.user.id,
          nangoIntegrationId: widget.email.nangoIntegrationId,
          syncId: widget.email.id,
          callerRole: AppUser.currentCallerRole,
        );
    if (mounted) {
      setState(() {
        email = emailFromFirestore;
        // Update the recipient and subject with more accurate data
        _recipientController.text = emailFromFirestore.sender;
        _subjectController.text = "Re: ${emailFromFirestore.subject}";
      });
    } else {
      email = emailFromFirestore;
    }
  }

  @override
  void initState() {
    super.initState();

    // Initialize animation
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(1.0, 0.0),
      end: const Offset(0.0, 0.0),
    ).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    // Start animation
    _animationController.forward();

    // Set initial values from the summary email
    _recipientController.text = widget.email.senderEmail;
    _subjectController.text = "Re: ${widget.email.subject}";

    // Fetch full email
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await getEmail();
      if (!mounted) {
        return;
      }
      // Update the recipient after we fetch the email
      if (email != null) {
        _recipientController.text = widget.email.senderEmail;
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    _recipientController.dispose();
    _subjectController.dispose();
    _bodyController.dispose();
    super.dispose();
  }

  Future<void> _generateResponse() async {
    setState(() {
      _responseLoading = true;
      _responseGenerated = false;
      _responseError = false;
    });
    try {
      EmailAssistantGenerateResponseEmailOutputWrapper responseWrapper =
          await AgentEmailAssistantEngine.generateEmailResponse(
            isDev: Config.devMode,
            inputModel: EmailAssistantGenerateResponseEmailInputWrapper(
              from: _recipientController.text,
              to: widget.email.senderEmail,
              date: email?.date.toDateTime() ?? DateTime.now(),
              subject: email?.subject ?? "",
              body: email?.body ?? "",
            ),
          );
      if (responseWrapper.isSuccess()) {
        setState(() {
          _responseGenerated = true;
          _responseLoading = false;
          _subjectController.text =
              responseWrapper.response.responseEmailSubject;
          _bodyController.text = responseWrapper.response.responseEmailBody;
        });
      }
    } catch (e) {
      setState(() {
        _responseError = true;
        _responseLoading = false;
      });
    }
  }

  String _getImportanceLabel(double score) {
    if (score >= 0.8) return 'Very Important';
    if (score >= 0.6) return 'Important';
    if (score >= 0.4) return 'Less Important';
    return 'Not Important';
  }

  Color _getImportanceColor(double score) {
    if (score >= 0.8) return Colors.red;
    if (score >= 0.6) return Colors.orange;
    if (score >= 0.4) return Colors.yellow;
    return Colors.grey;
  }

  void _closeOverlay() {
    _animationController.reverse().then((_) {
      Navigator.of(context).pop();
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Material(
      color: Colors.transparent,
      child: Stack(
        children: [
          // Barrier that closes the overlay when tapped
          GestureDetector(
            onTap: _closeOverlay,
            child: Container(
              width: double.infinity,
              height: double.infinity,
              color: Colors.transparent,
            ),
          ),
          // Sliding overlay from right
          SlideTransition(
            position: _slideAnimation,
            child: Align(
              alignment: Alignment.centerRight,
              child: Container(
                width:
                    size.width * 0.85 > 600
                        ? 600
                        : size.width * 0.85, // Takes most of the screen width
                height: double.infinity,
                decoration: BoxDecoration(
                  color: AppColors.whiteColor,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 10,
                      offset: const Offset(-2, 0),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    // Header
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: AppColors.darkWhiteColor,
                        border: Border(
                          bottom: BorderSide(
                            color: AppColors.lightGrayColor,
                            width: 1,
                          ),
                        ),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              'Email Details',
                              style: Theme.of(
                                context,
                              ).textTheme.headlineMedium?.copyWith(
                                fontWeight: FontWeight.w600,
                                color: AppColors.primaryColor,
                              ),
                            ),
                          ),
                          IconButton(
                            onPressed: _closeOverlay,
                            icon: const Icon(CupertinoIcons.xmark_circle_fill),
                            color: AppColors.primaryColor,
                            iconSize: 32,
                          ),
                        ],
                      ),
                    ),

                    Expanded(
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.all(24),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Email information
                            _buildEmailInfoSection(),
                            const SizedBox(height: 32),

                            // Generate response section
                            if (email != null) ...[
                              _buildGenerateResponseSection(),
                              const SizedBox(height: 32),
                            ],

                            // Email compose section
                            if (_responseGenerated) _buildComposeSection(),
                          ],
                        ),
                      ),
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

  Widget _buildEmailInfoSection() {
    if (email == null) {
      return Container(
        padding: const EdgeInsets.all(32),
        decoration: BoxDecoration(
          color: AppColors.darkWhiteColor,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.lightGrayColor, width: 1),
        ),
        child: const Center(
          child: Column(
            children: [
              CircularProgressIndicator(),
              SizedBox(height: 16),
              Text('Loading email details...'),
            ],
          ),
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.darkWhiteColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.lightGrayColor, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Provider and importance
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: AppColors.primaryColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  widget.email.provider.toUpperCase(),
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.primaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: _getImportanceColor(
                    widget.email.importanceScore,
                  ).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  _getImportanceLabel(widget.email.importanceScore),
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: _getImportanceColor(widget.email.importanceScore),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Subject
          Text(
            'Subject',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: AppColors.lightDarkColor,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            email!.subject,
            style: Theme.of(
              context,
            ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 5),

          // From
          Text(
            'From',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: AppColors.lightDarkColor,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(email!.sender, style: Theme.of(context).textTheme.bodyLarge),
          const SizedBox(height: 5),

          // To (if available)
          if (email!.recipients.isNotEmpty) ...[
            Text(
              'To',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: AppColors.lightDarkColor,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              email!.recipients,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 5),
          ],

          // Date
          Text(
            'Date',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: AppColors.lightDarkColor,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            DateFormat('dd/MM/yyyy HH:mm').format(email!.date.toDateTime()),
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const SizedBox(height: 10),

          // Email Body
          Text(
            'Email Content',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: AppColors.lightDarkColor,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12),
          Container(
            width: double.infinity,
            constraints: const BoxConstraints(maxHeight: 300),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.whiteColor,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.lightGrayColor, width: 1),
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (email!.body.isNotEmpty) ...[
                    Text(
                      email!.body,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGenerateResponseSection() {
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'AI Response',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.w600,
              color: AppColors.primaryColor,
            ),
          ),
          const SizedBox(height: 16),

          // Error message
          if (_responseError) ...[
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              margin: const EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                color: Colors.red.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: Colors.red.withValues(alpha: 0.3),
                  width: 1,
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    CupertinoIcons.exclamationmark_triangle_fill,
                    color: Colors.red,
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Failed to generate response. Please try again.',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.red.shade700,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],

          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed:
                  (_responseGenerated || _responseLoading)
                      ? null
                      : _generateResponse,
              icon:
                  _responseLoading
                      ? SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            AppColors.whiteColor,
                          ),
                        ),
                      )
                      : Icon(
                        _responseGenerated
                            ? CupertinoIcons.checkmark
                            : CupertinoIcons.sparkles,
                        size: 20,
                      ),
              label: Text(
                _responseLoading
                    ? 'Generating...'
                    : _responseGenerated
                    ? 'Response Generated'
                    : 'Generate Response',
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    (_responseGenerated || _responseLoading)
                        ? AppColors.lightGrayColor
                        : AppColors.primaryColor,
                foregroundColor:
                    (_responseGenerated || _responseLoading)
                        ? AppColors.lightDarkColor
                        : AppColors.whiteColor,
                padding: const EdgeInsets.symmetric(vertical: 18),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildComposeSection() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.darkWhiteColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.lightGrayColor, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Compose Reply',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.w600,
              color: AppColors.primaryColor,
            ),
          ),
          const SizedBox(height: 24),

          // Recipient
          DefaultTextFormField(
            controller: _recipientController,
            hintText: 'Recipient email',
            labelText: 'To',
          ),
          const SizedBox(height: 20),

          // Subject
          DefaultTextFormField(
            controller: _subjectController,
            hintText: 'Email subject',
            labelText: 'Subject',
          ),
          const SizedBox(height: 20),

          // Body
          TextField(
            controller: _bodyController,
            maxLines: 12,
            style: Theme.of(context).textTheme.bodyLarge,
            decoration: InputDecoration(
              labelText: 'Message',
              hintText: 'Email content',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: AppColors.lightGrayColor),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: AppColors.primaryColor, width: 2),
              ),
              contentPadding: const EdgeInsets.all(16),
            ),
          ),
          const SizedBox(height: 24),

          // Success message
          if (_sendSuccess) ...[
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              margin: const EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                color: Colors.green.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: Colors.green.withValues(alpha: 0.3),
                  width: 1,
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    CupertinoIcons.checkmark_circle_fill,
                    color: Colors.green,
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Email sent successfully!',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.green.shade700,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],

          // Send button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed:
                  _sendLoading
                      ? null
                      : () async {
                        setState(() {
                          _sendSuccess = false;
                          _sendLoading = true;
                        });

                        try {
                          NangoGoogleMailSendEmailResponseWrapper
                          responseWrapper =
                              await NangoGoogleMailEngine.sendEmail(
                                isDev: Config.devMode,
                                requestModel:
                                    NangoGoogleMailSendEmailRequestWrapper(
                                      userId: AppUser.user.id,
                                      to: _recipientController.text,
                                      subject: _subjectController.text,
                                      body: _bodyController.text,
                                    ),
                              );
                          if (responseWrapper.isSuccess()) {
                            setState(() {
                              _sendSuccess = true;
                            });
                            showNotification(
                              Application.appLocalizations!.success,
                              NotificationType.success,
                            );
                          } else {
                            Log.e(
                              "Error sending email: ${responseWrapper.response}",
                            );
                            setState(() {
                              _sendSuccess = false;
                            });
                            showNotification(
                              Application.appLocalizations!.errorTryAgainLater,
                              NotificationType.error,
                            );
                          }
                        } catch (e) {
                          Log.e("Error sending email: ${e.toString()}");
                          setState(() {
                            _sendSuccess = false;
                          });
                          showNotification(
                            Application.appLocalizations!.errorTryAgainLater,
                            NotificationType.error,
                          );
                        }

                        setState(() {
                          _sendLoading = false;
                        });
                      },
              icon:
                  _sendLoading
                      ? SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            AppColors.whiteColor,
                          ),
                        ),
                      )
                      : const Icon(CupertinoIcons.mail, size: 20),
              label: Text(
                _sendLoading ? 'Sending...' : 'Send Email',
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    _sendLoading
                        ? AppColors.lightGrayColor
                        : AppColors.secondaryColor,
                foregroundColor:
                    _sendLoading
                        ? AppColors.lightDarkColor
                        : AppColors.whiteColor,
                padding: const EdgeInsets.symmetric(vertical: 18),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
