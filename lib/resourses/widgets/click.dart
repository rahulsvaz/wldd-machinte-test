import 'package:flutter/cupertino.dart';

class Click extends StatefulWidget {
  final CupertinoButtonSize? buttonSize ;
  final Widget child;
  final EdgeInsets? padding;
  final VoidCallback onPressed;
  const Click(
      {super.key, required this.child, required this.onPressed, this.padding ,this.buttonSize});

  @override
  State<StatefulWidget> createState() {
    return _ClickState();
  }
}

class _ClickState extends State<Click> {
  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      sizeStyle: widget.buttonSize?? CupertinoButtonSize.large,
        padding: widget.padding ?? EdgeInsets.all(1),
        onPressed: widget.onPressed,
        child: widget.child);
  }
}
