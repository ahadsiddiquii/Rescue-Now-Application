import 'package:flutter/material.dart';

import '../config/screen_config.dart';
import 'text_widget.dart';

class ProfileMenuCard extends StatelessWidget {
  const ProfileMenuCard({
    Key? key,
    required this.title,
    required this.icon,
    required this.onTap,
  }) : super(key: key);
  final String title;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 25.0,
          vertical: 20,
        ),
        child: Row(
          children: [
            Icon(icon),
            const SizedBox(
              width: 5,
            ),
            RescueNowText(
              title,
              style: ScreenConfig.theme.textTheme.headlineSmall,
            )
          ],
        ),
      ),
    );
  }
}
