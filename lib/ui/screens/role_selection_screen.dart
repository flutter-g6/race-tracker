import 'package:flutter/material.dart';
import 'package:race_tracker/ui/screens/authentication/login_screen.dart';
import '../theme/theme.dart';

class RoleSelectionScreen extends StatelessWidget {
  const RoleSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: RTColors.backGroundColor,
      body: Padding(
        padding: const EdgeInsets.all(RTSpacings.xl),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Race Tracker',
              style: RTTextStyles.heading.copyWith(
                color: RTColors.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: RTSpacings.m),
            Text(
              'Who are you?',
              style: RTTextStyles.subHeading.copyWith(color: RTColors.black),
            ),
            const SizedBox(height: RTSpacings.xxl),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: _RoleButton(
                    role: 'Manager',
                    color: RTColors.primary,
                    iconPath: 'assets/images/manager.png',
                    onPressed: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder:
                              (ctx) => LoginScreen(selectedRole: 'Manager'),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(width: RTSpacings.l),
                Expanded(
                  child: _RoleButton(
                    role: 'Tracker',
                    color: RTColors.secondary,
                    iconPath: 'assets/images/tracker.png',
                    onPressed: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder:
                              (ctx) => LoginScreen(selectedRole: 'Tracker'),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _RoleButton extends StatelessWidget {
  final String role;
  final Color color;
  final String iconPath;
  final VoidCallback onPressed;

  const _RoleButton({
    required this.role,
    required this.color,
    required this.iconPath,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        foregroundColor: RTColors.white,
        padding: const EdgeInsets.all(RTSpacings.m),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(RTSpacings.radius),
        ),
        elevation: 0,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(iconPath, width: 100, height: 100),
          const SizedBox(height: RTSpacings.s),
          Text(
            role,
            style: RTTextStyles.button.copyWith(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
