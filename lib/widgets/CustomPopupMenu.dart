import 'package:flutter/material.dart';

class CustomPopupMenu extends StatelessWidget {
  const CustomPopupMenu(
      {required this.list,
      required this.onTap,
      required this.icon,
      this.color = Colors.white,
      this.radius = 16.0,
      super.key});

  final List<Row> list;
  final Function(Row) onTap;
  final IconData icon;
  final Color color;
  final double radius;
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      onSelected: onTap,
      itemBuilder: (context) {
        return list.map((e) => PopupMenuItem(value: e, child: e)).toList();
      },
      icon: Icon(icon),
      color: color,
      shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius)),
    );
  }
}
