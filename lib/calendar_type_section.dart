import 'package:custom_date_range_picker/calender_type.dart';
import 'package:flutter/material.dart';

class CalenderTypeSection extends StatefulWidget {
  final ValueChanged<CalenderType> onChanged;
  final CalenderType initial;
  const CalenderTypeSection({
    super.key,
    required this.onChanged,
    required this.initial,
  });

  @override
  State<CalenderTypeSection> createState() => _CalenderTypeSectionState();
}

class _CalenderTypeSectionState extends State<CalenderTypeSection>
    with SingleTickerProviderStateMixin {
  late CalenderType type;

  late final AnimationController _animationController;
  late final Animation<Alignment> _selectedAlignmentAnimation;
  late final Animation<Alignment> _unselectedAlignmentAnimation;

  @override
  void initState() {
    type = widget.initial;
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
      reverseDuration: const Duration(milliseconds: 300),
    );
    _selectedAlignmentAnimation = CurvedAnimation(
      curve: Curves.linear,
      reverseCurve: Curves.linear,
      parent: _animationController,
    ).drive(
      AlignmentTween(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      ),
    );

    _unselectedAlignmentAnimation = CurvedAnimation(
      curve: Curves.linear,
      reverseCurve: Curves.linear,
      parent: _animationController,
    ).drive(
      AlignmentTween(
        begin: Alignment.centerRight,
        end: Alignment.centerLeft,
      ),
    );
    super.initState();
  }

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
        height: 40,
        width: 110,
        child: Stack(
          children: [
            Positioned.fill(
              left: 0,
              right: 0,
              child: AnimatedBuilder(
                animation: _unselectedAlignmentAnimation,
                builder: (context, _) {
                  return Container(
                    alignment: _unselectedAlignmentAnimation.value,
                    child: _CalenderTypeButton(
                      showDot: false,
                      title: type.isAD
                          ? CalenderType.BS.name
                          : CalenderType.AD.name,
                      isSelected: false,
                      onPressed: () {
                        if (type.isAD) {
                          _animationController.forward();
                        } else {
                          _animationController.reverse();
                        }
                        final updatedType =
                            type.isAD ? CalenderType.BS : CalenderType.AD;
                        setState(() {
                          type = updatedType;
                        });
                        widget.onChanged(updatedType);
                      },
                    ),
                  );
                },
              ),
            ),
            Positioned.fill(
              left: 0,
              right: 0,
              child: AnimatedBuilder(
                animation: _selectedAlignmentAnimation,
                builder: (context, _) {
                  return Container(
                    alignment: _selectedAlignmentAnimation.value,
                    child: _CalenderTypeButton(
                      showDot: true,
                      title: type.name,
                      isSelected: true,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CalenderTypeButton extends StatelessWidget {
  final String title;
  final VoidCallback? onPressed;
  final bool isSelected;
  final bool showDot;
  const _CalenderTypeButton({
    required this.title,
    this.onPressed,
    required this.isSelected,
    required this.showDot,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return InkWell(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7.5),
        decoration: BoxDecoration(
          color: (isSelected && showDot) ? Colors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
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
