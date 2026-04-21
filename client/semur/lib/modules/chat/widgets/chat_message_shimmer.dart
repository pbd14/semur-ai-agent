import 'package:flutter/material.dart';
import 'package:semur/global/app_colors.dart';
import 'package:shimmer/shimmer.dart';

class ChatMessageShimmer extends StatelessWidget {
  const ChatMessageShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Shimmer.fromColors(
          baseColor: AppColors.primaryColor.withValues(alpha: 0.1),
          highlightColor: Colors.grey[100]!,
          child: Row(
            children: <Widget>[
              Container(
                width: 32.0,
                height: 32.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: 12.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      width: 100.0,
                      height: 15.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.0),
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    Container(
                      width: double.infinity,
                      height: 15.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
