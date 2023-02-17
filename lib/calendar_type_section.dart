import 'package:custom_date_range_picker/calender_type.dart';
import 'package:flutter/material.dart';

class CalenderTypeSection extends StatelessWidget {
  final ValueChanged<CalenderType> onChanged;
  final CalenderType initial;
  const CalenderTypeSection({
    super.key,
    required this.onChanged,
    required this.initial,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFFEEF1F7),
          borderRadius: BorderRadius.circular(4),
        ),
        padding: const EdgeInsets.all(4),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _CalenderTypeButton(
              title: CalenderType.AD.name,
              onPressed: () {
                onChanged(CalenderType.AD);
              },
              isSelected: initial == CalenderType.AD,
            ),
            _CalenderTypeButton(
              title: CalenderType.BS.name,
              onPressed: () {
                onChanged(CalenderType.BS);
              },
              isSelected: initial == CalenderType.BS,
            ),
          ],
        ),
      ),
    );
  }
}

class _CalenderTypeButton extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;
  final bool isSelected;
  const _CalenderTypeButton({
    required this.title,
    required this.onPressed,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return InkWell(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 7.5),
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Row(
          children: [
            if (isSelected)
              Container(
                margin: const EdgeInsets.only(right: 8),
                height: 6,
                width: 6,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: theme.primaryColor,
                ),
              ),
            Text(
              title,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color:
                    isSelected ? theme.primaryColor : const Color(0xFF91979F),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
