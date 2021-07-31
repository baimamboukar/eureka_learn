import 'package:eureka_learn/main.dart';
import 'package:eureka_learn/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class NavItem extends HookWidget {
  final IconData icon;
  final int position;
  final String label;
  const NavItem({
    Key? key,
    required this.icon,
    required this.position,
    required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final index = useProvider(navigationIndexProvider);
    return GestureDetector(
      onTap: () => index.state = position,
      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: Column(
            children: [
              position == index.state
                  ? Container(
                      height: 4.0,
                      width: 4.0,
                      decoration: BoxDecoration(
                          color: Palette.primary, shape: BoxShape.circle))
                  : SizedBox.shrink(),
              Icon(icon,
                  color: position == index.state
                      ? Palette.primary
                      : Palette.primary.withOpacity(0.5)),
              Text(label,
                  style: TextStyle(
                      color: position == index.state
                          ? Palette.primary
                          : Palette.primary.withOpacity(0.5),
                      fontWeight: position == index.state
                          ? FontWeight.bold
                          : FontWeight.normal))
            ],
          ),
        ),
      ),
    );
  }
}
