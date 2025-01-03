import 'package:flutter/material.dart';
import 'package:pust_guest_house/core/common/widgets/small_title.dart';
import 'package:pust_guest_house/features/client/presentation/widgets/utils/number_controller.dart';

class MyRadoButton extends StatefulWidget {
  final String title;
  final Map<int, String> options;
  final NumberController controller;
  final bool? isColumn;
  final VoidCallback? callback;
  const MyRadoButton({
    super.key,
    required this.title,
    required this.options,
    required this.controller,
    this.isColumn,
    this.callback,
  });

  @override
  State<MyRadoButton> createState() => _MyRadoButtonState();
}

class _MyRadoButtonState extends State<MyRadoButton> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SmallTitle(title: widget.title),
        (widget.isColumn == null || widget.isColumn == false)
            ? Row(children: _getChildern())
            : Column(children: _getChildern())
      ],
    );
  }

  List<Widget> _getChildern() {
    return widget.options.entries.map((e) {
      return GestureDetector(
        onTap: () {
          setState(() {
            widget.controller.number = e.key;
          });
        },
        child: Row(
          children: [
            Radio(
              value: e.key,
              groupValue: widget.controller.number,
              onChanged: (value) {
                setState(() {
                  widget.controller.number = value ?? 0;
                });
                if (widget.callback != null) {
                  widget.callback!();
                }
              },
            ),
            Text('${e.value}'),
          ],
        ),
      );
    }).toList();
  }
}
