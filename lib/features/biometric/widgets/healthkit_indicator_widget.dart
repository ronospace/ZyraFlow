import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';

/// HealthKit indicator widget for App Store Guideline 2.5.1 compliance
/// Shows clear visual indication that the app uses Apple Health (HealthKit)
class HealthKitIndicatorWidget extends StatelessWidget {
  final bool isConnected;
  final VoidCallback? onInfoTap;

  const HealthKitIndicatorWidget({
    super.key,
    this.isConnected = true,
    this.onInfoTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isConnected 
            ? AppTheme.successGreen.withValues(alpha: 0.1)
            : AppTheme.warningOrange.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isConnected 
              ? AppTheme.successGreen.withValues(alpha: 0.3)
              : AppTheme.warningOrange.withValues(alpha: 0.3),
          width: 2,
        ),
      ),
      child: Row(
        children: [
          // Apple Health Icon
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: isConnected ? AppTheme.successGreen : AppTheme.warningOrange,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.favorite,
              color: Colors.white,
              size: 24,
            ),
          ),
          const SizedBox(width: 12),
          
          // Text
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  isConnected 
                      ? 'Connected to Apple Health'
                      : 'Apple Health Not Connected',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.onSurface,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  isConnected
                      ? 'Syncing biometric data from HealthKit'
                      : 'Tap to enable HealthKit integration',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
                  ),
                ),
              ],
            ),
          ),
          
          // Info Button
          IconButton(
            onPressed: onInfoTap ?? () => _showHealthKitInfoDialog(context),
            icon: Icon(
              Icons.info_outline,
              color: isConnected ? AppTheme.successGreen : AppTheme.warningOrange,
            ),
            tooltip: 'About HealthKit Integration',
          ),
        ],
      ),
    );
  }

  void _showHealthKitInfoDialog(BuildContext context) {
    final theme = Theme.of(context);
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: theme.cardColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppTheme.successGreen.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(
                Icons.favorite,
                color: AppTheme.successGreen,
                size: 24,
              ),
            ),
            const SizedBox(width: 12),
            const Expanded(
              child: Text(
                'Apple Health Integration',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Flow-AI uses HealthKit to sync the following data:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 16),
              _buildHealthKitDataItem(
                icon: Icons.favorite,
                title: 'Heart Rate',
                description: 'Resting and active heart rate measurements',
              ),
              const SizedBox(height: 12),
              _buildHealthKitDataItem(
                icon: Icons.thermostat,
                title: 'Body Temperature',
                description: 'Basal body temperature for fertility tracking',
              ),
              const SizedBox(height: 12),
              _buildHealthKitDataItem(
                icon: Icons.hotel,
                title: 'Sleep Analysis',
                description: 'Sleep duration and quality metrics',
              ),
              const SizedBox(height: 12),
              _buildHealthKitDataItem(
                icon: Icons.monitor_weight,
                title: 'Body Measurements',
                description: 'Weight and other body composition data',
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppTheme.secondaryBlue.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: AppTheme.secondaryBlue.withValues(alpha: 0.3),
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.security,
                      color: AppTheme.secondaryBlue,
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Your health data is private and secure. Flow-AI uses HealthKit to provide better cycle predictions and health insights.',
                        style: TextStyle(
                          fontSize: 12,
                          color: theme.colorScheme.onSurface.withValues(alpha: 0.8),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Got it'),
          ),
        ],
      ),
    );
  }

  Widget _buildHealthKitDataItem({
    required IconData icon,
    required String title,
    required String description,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: AppTheme.accentMint.withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            icon,
            color: AppTheme.accentMint,
            size: 16,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                description,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
