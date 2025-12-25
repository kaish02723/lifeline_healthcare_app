import 'dart:ui';
import 'package:flutter/material.dart';

import '../../core/utils/services/notification_service.dart';

class NotificationGlassScreen extends StatelessWidget {
  const NotificationGlassScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: isDark ? Colors.black : Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Icon(
            Icons.arrow_back,
            color: isDark ? Colors.white : Colors.black,
          ),
        ),
        title: Text(
          "Notification",
          style: TextStyle(
            color: isDark ? Colors.white : Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),

      body: Stack(
        children: [
          // Background gradient
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors:
                    isDark
                        ? [Colors.black, Colors.grey.shade900]
                        : [Colors.teal.shade50, Colors.white],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),

          ListView(
            padding: const EdgeInsets.only(top: 100, left: 16, right: 16),
            children: [
              _glassTile(
                isDark,
                title: "Your Test report is ready",
                time: "2 min ago",
                msg: "Recently you applied for a liver test. Test is ready.",
              ),
              _glassTile(
                isDark,
                title: "Book your doctor now",
                time: "10 min ago",
                msg: "You can now book doctors from this app.",
              ),
            ],
          ),
          // Center(
          //   child: ElevatedButton(
          //     onPressed: () {
          //       NotificationService.showNotification();
          //     },
          //     child: const Text("Show Notification"),
          //   ),
          // ),
        ],
      ),
    );
  }

  Widget _glassTile(
    bool isDark, {
    required String title,
    required String time,
    required String msg,
  }) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
        child: Container(
          margin: const EdgeInsets.only(bottom: 18),
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: (isDark ? Colors.white10 : Colors.white.withOpacity(0.4)),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.white.withOpacity(0.4), width: 1),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _iconBox(),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            title,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: isDark ? Colors.white : Colors.black,
                            ),
                          ),
                        ),
                        Text(
                          time,
                          style: TextStyle(
                            fontSize: 12,
                            color: isDark ? Colors.white70 : Colors.black54,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Text(
                      msg,
                      style: TextStyle(
                        fontSize: 13.5,
                        color: isDark ? Colors.white70 : Colors.black87,
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

  Widget _iconBox() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.red.withOpacity(0.15),
      ),
      child: const Icon(Icons.notifications_active, color: Colors.red),
    );
  }
}
