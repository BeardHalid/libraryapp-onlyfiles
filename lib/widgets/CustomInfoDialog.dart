import 'package:flutter/material.dart';
import 'package:libraryapp/widgets/CustomText.dart';

class CustomInfoDialog extends StatefulWidget {
  final String title;
  final Widget content;
  const CustomInfoDialog(
      {super.key, required this.content, required this.title});

  @override
  State<CustomInfoDialog> createState() => _CustomInfoDialogState();
}

class _CustomInfoDialogState extends State<CustomInfoDialog>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _anim;
  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 200));
    _anim = Tween<double>(begin: 0.0, end: 1.0).animate(_controller)
      ..addListener(() {
        setState(() {});
      });

    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: _anim.value,
      child: AlertDialog(
        title: CustomText(
          text: widget.title,
          align: TextAlign.center,
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
        content: widget.content,
        actions: [
          TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Tamam'))
        ],
      ),
    );
  }
}
