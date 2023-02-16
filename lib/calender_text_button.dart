import 'package:flutter/material.dart';

class CalenderTextButton extends StatelessWidget {
  final String title;
  final bool isDisabled;
  final VoidCallback onPressed;
  const CalenderTextButton({
    super.key,
    required this.onPressed,
    required this.title,
    this.isDisabled = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return InkWell(
      onTap: isDisabled ? null : onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        child: Text(
          title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: isDisabled ? const Color(0xFFB4B4BB) : theme.primaryColor,
          ),
        ),
      ),
    );
  }
}
