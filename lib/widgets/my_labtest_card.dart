import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TestCard extends StatelessWidget {
  final String userName;
  final String testName;
  final String phone;
  final String category;
  final String status;

  final VoidCallback? onCancel;
  final VoidCallback? onViewReport;

  const TestCard({
    super.key,
    required this.userName,
    required this.testName,
    required this.phone,
    required this.category,
    required this.status,
    this.onCancel,
    this.onViewReport,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),

        gradient: LinearGradient(
          colors: isDark
              ? [
            Colors.white.withOpacity(0.08),
            Colors.white.withOpacity(0.03),
          ]
              : [
            Colors.white.withOpacity(0.95),
            Colors.white.withOpacity(0.80),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),

        border: Border.all(
          color: isDark
              ? Colors.white.withOpacity(0.15)
              : Colors.white.withOpacity(0.9),
          width: 1.2,
        ),

        boxShadow: [
          BoxShadow(
            color: isDark
                ? Colors.black.withOpacity(0.6)
                : Colors.black.withOpacity(0.12),
            blurRadius: isDark ? 25 : 18,
            offset: const Offset(0, 6),
          ),
          BoxShadow(
            color: isDark
                ? Colors.white.withOpacity(0.05)
                : Colors.white.withOpacity(0.9),
            blurRadius: 12,
            offset: const Offset(-6, -6),
          ),
        ],
      ),

      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Text(
              testName,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.3,
                color: Theme.of(context).textTheme.bodyMedium!.color,
              ),
            ),

            const SizedBox(height: 14),

            _buildRow(context, "User Name", userName),
            _buildRow(context, "Phone", phone),
            _buildRow(context, "Category", category),

            const SizedBox(height: 16),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _statusChip(context, status),

                if (status.toLowerCase() == "pending")
                  OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: Colors.red.shade400, width: 0.7),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 6,
                      ),
                    ),
                    onPressed: onCancel,
                    child: Text(
                      "Cancel",
                      style: TextStyle(
                        color: Colors.red.shade500,
                        fontWeight: FontWeight.w700,
                        fontSize: 14,
                      ),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRow(BuildContext context, String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: "$label: ",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Theme.of(context).textTheme.bodyMedium!.color,
              ),
            ),
            TextSpan(
              text: value,
              style: TextStyle(
                fontSize: 16,
                color: Theme.of(context).textTheme.bodyMedium!.color,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case "pending":   return Colors.orange;
      case "approved":  return Colors.blue;
      case "completed": return Colors.green;
      case "cancelled": return Colors.red;
      default: return Colors.grey;
    }
  }

  Widget _statusChip(BuildContext context, String status) {
    final color = _getStatusColor(status);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.15),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color, width: 1),
      ),
      child: Row(
        children: [
          Icon(Icons.circle, color: color, size: 12),
          const SizedBox(width: 6),
          Text(
            status.toUpperCase(),
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}

