import 'package:flutter/material.dart';
import 'package:flutter_getx_boilerplate/utils/constants/colors.dart';

class TabBarSeparatorWidget extends StatelessWidget {
  const TabBarSeparatorWidget({
    Key? key,
    this.borderColor = LIGHT_DIVIDER_COLOR,
  }) : super(key: key);

  final Color? borderColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 1.0,
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: borderColor!),
        ),
      ),
    );
  }
}
