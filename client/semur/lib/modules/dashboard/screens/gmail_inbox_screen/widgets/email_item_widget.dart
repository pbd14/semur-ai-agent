import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:html/parser.dart' as html_parser;
import 'package:semur/global/app_colors.dart';
import 'package:semur/models.pb/syncs/sync_google-mail.pb.dart';

class EmailItemWidget extends StatefulWidget {
  final SyncGoogleMailEmail email;
  final VoidCallback? onTap;

  const EmailItemWidget({
    super.key,
    required this.email,
    this.onTap,
  });

  @override
  State<EmailItemWidget> createState() => _EmailItemWidgetState();
}

class _EmailItemWidgetState extends State<EmailItemWidget> 
    with SingleTickerProviderStateMixin {
  bool _isExpanded = false;
  late AnimationController _animationController;
  late Animation<double> _expandAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _expandAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _toggleExpanded() {
    setState(() {
      _isExpanded = !_isExpanded;
      if (_isExpanded) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    });
  }

  String _formatDate(DateTime dateTime) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final emailDate = DateTime(dateTime.year, dateTime.month, dateTime.day);
    
    if (emailDate == today) {
      return DateFormat.Hm().format(dateTime);
    } else if (emailDate.isAfter(today.subtract(const Duration(days: 7)))) {
      return DateFormat.E().format(dateTime);
    } else {
      return DateFormat.yMMMMd().format(dateTime);
    }
  }

  String _getSenderName() {
    if (widget.email.hasSender() && widget.email.sender.isNotEmpty) {
      // Extract name from email format "Name <email@domain.com>" or just return email
      final sender = widget.email.sender;
      final match = RegExp(r'^([^<]+)<([^>]+)>$').firstMatch(sender);
      if (match != null) {
        return match.group(1)?.trim() ?? sender;
      }
      return sender;
    }
    return 'Unknown Sender';
  }

  String _getSubjectPreview() {
    if (widget.email.hasSubject() && widget.email.subject.isNotEmpty) {
      return widget.email.subject;
    }
    return '(No subject)';
  }

  String _convertHtmlToText(String htmlContent) {
    if (htmlContent.isEmpty) return 'No content available';
    
    try {
      // Parse the HTML content
      final document = html_parser.parse(htmlContent);
      
      // Get the text content, which automatically handles HTML entities
      String textContent = document.body?.text ?? document.documentElement?.text ?? '';
      
      // Clean up extra whitespace and newlines
      textContent = textContent
          .replaceAll(RegExp(r'\s+'), ' ') // Replace multiple whitespace with single space
          .replaceAll(RegExp(r'\n\s*\n'), '\n\n') // Clean up multiple newlines
          .trim();
      
      return textContent.isNotEmpty ? textContent : 'No content available';
    } catch (e) {
      // Fallback to simple regex if HTML parsing fails
      return htmlContent
          .replaceAll(RegExp(r'<[^>]*>'), '') // Remove HTML tags
          .replaceAll(RegExp(r'&[a-zA-Z0-9#]+;'), '') // Remove HTML entities
          .replaceAll(RegExp(r'\s+'), ' ')
          .trim();
    }
  }



  Widget _buildEmailHeader() {
    final dateTime = widget.email.hasDate() 
        ? DateTime.fromMillisecondsSinceEpoch(widget.email.date.seconds.toInt() * 1000)
        : DateTime.now();

    return InkWell(
      onTap: _toggleExpanded,
      borderRadius: BorderRadius.circular(12.0),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
        child: Row(
          children: [
            // Sender Avatar
            CircleAvatar(
              radius: 14,
              backgroundColor: AppColors.primaryColor.withValues(alpha: 0.1),
              child: Text(
                _getSenderName().isNotEmpty ? _getSenderName()[0].toUpperCase() : 'U',
                style: TextStyle(
                  color: AppColors.primaryColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 11,
                ),
              ),
            ),
            const SizedBox(width: 10),
            
            // Sender name
            SizedBox(
              width: 120,
              child: Text(
                _getSenderName(),
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                  color: Colors.grey[800],
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            
            const SizedBox(width: 8),
            
            // Subject with fade effect
            Expanded(
              child: ShaderMask(
                shaderCallback: (bounds) => const LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [Colors.black, Colors.black, Colors.transparent],
                  stops: [0.0, 0.7, 1.0],
                ).createShader(bounds),
                blendMode: BlendMode.dstIn,
                child: Text(
                  _getSubjectPreview(),
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 12,
                    color: Colors.grey[700],
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.clip,
                ),
              ),
            ),
            
            const SizedBox(width: 8),
            
            // Right side: attachments, date, expand icon
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (widget.email.attachments.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(right: 6.0),
                    child: Icon(
                      Icons.attachment,
                      size: 12,
                      color: Colors.grey[500],
                    ),
                  ),
                Text(
                  _formatDate(dateTime),
                  style: TextStyle(
                    fontSize: 10,
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(width: 4),
                Icon(
                  _isExpanded ? Icons.expand_less : Icons.expand_more,
                  color: Colors.grey[500],
                  size: 18,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildExpandedContent() {
    return Container(
      constraints: const BoxConstraints(maxHeight: 400), // Limit max height
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Divider(color: Colors.grey[300]),
              const SizedBox(height: 6),
              
              // From
              if (widget.email.hasSender())
                _buildDetailRow('From:', widget.email.sender),
              
              // To
              if (widget.email.hasRecipients())
                _buildDetailRow('To:', widget.email.recipients),
              
              // Subject
              if (widget.email.hasSubject())
                _buildDetailRow('Subject:', widget.email.subject),
              
              const SizedBox(height: 12),
              
              // Email body
              Container(
                width: double.infinity,
                constraints: const BoxConstraints(maxHeight: 250),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.grey[50],
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey[200]!),
                ),
                child: SingleChildScrollView(
                  child: Text(
                    widget.email.hasBody() && widget.email.body.isNotEmpty
                        ? _convertHtmlToText(widget.email.body)
                        : widget.email.hasFullContent()
                            ? _convertHtmlToText(widget.email.fullContent)
                            : 'No content available',
                    style: const TextStyle(fontSize: 13),
                  ),
                ),
              ),
              
              // Attachments
              if (widget.email.attachments.isNotEmpty) ...[
                const SizedBox(height: 12),
                Text(
                  'Attachments (${widget.email.attachments.length})',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                    color: Colors.grey[700],
                  ),
                ),
                const SizedBox(height: 6),
                ...widget.email.attachments.map((attachment) => Padding(
                  padding: const EdgeInsets.only(bottom: 3),
                  child: Row(
                    children: [
                      Icon(Icons.attachment, size: 14, color: Colors.grey[500]),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          attachment.hasFilename() ? attachment.filename : 'Unknown file',
                          style: const TextStyle(fontSize: 12),
                        ),
                      ),
                      if (attachment.hasSize())
                        Text(
                          '(${(attachment.size / 1024).toStringAsFixed(1)} KB)',
                          style: TextStyle(
                            fontSize: 11,
                            color: Colors.grey[600],
                          ),
                        ),
                    ],
                  ),
                )),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 70,
            child: Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.grey[600],
                fontSize: 12,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      elevation: 0,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(
          color: AppColors.primaryColor.withValues(alpha: 0.3),
          width: 0.5,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildEmailHeader(),
          SizeTransition(
            sizeFactor: _expandAnimation,
            child: _buildExpandedContent(),
          ),
        ],
      ),
    );
  }
}
