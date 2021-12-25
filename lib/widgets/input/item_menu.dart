import 'package:flutter/material.dart';
import 'package:flutter_getx_boilerplate/utils/constants/colors.dart';
import 'package:flutter_getx_boilerplate/widgets/menus/tab_bar_separator.dart';

class ItemMenu extends StatelessWidget {
  final String? headLabel;
  final String? title;
  final TextStyle? titleStyle;
  final Function? onPressed;
  final Widget? badgeIcon;
  final bool? useDivider;
  final bool required;
  final Widget? customWidget;
  final EdgeInsets? headLabelPadding;
  final bool hideOnPressedIcon;

  const ItemMenu({
    Key? key,
    this.headLabel,
    this.title,
    this.onPressed,
    this.customWidget,
    this.badgeIcon,
    this.useDivider = true,
    this.required = false,
    this.hideOnPressedIcon = false,
    this.headLabelPadding = const EdgeInsets.only(bottom: 15),
    this.titleStyle = const TextStyle(
      color: PRIMARY_TEXT_COLOR,
      fontWeight: FontWeight.bold,
    ),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 15.0, right: 15.0, top: 15.0),
      child: InkWell(
        onTap: () {
          if (onPressed != null) {
            onPressed!();
          }
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            headLabel != null
                ? Container(
                    padding: headLabelPadding,
                    child: Text(
                      headLabel!,
                      style: const TextStyle(
                        color: DIVIDER_COLOR,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                : SizedBox(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Container(
                    child: customWidget ??
                        RichText(
                          text: TextSpan(
                            style: TextStyle(fontFamily: "Nunito"),
                            children: [
                              TextSpan(
                                text: title!,
                                style: titleStyle!,
                              ),
                              required
                                  ? TextSpan(
                                      text: "*",
                                      style: TextStyle(
                                        color: Colors.red,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    )
                                  : WidgetSpan(child: Offstage()),
                            ],
                          ),
                          maxLines: 2,
                        ),
                  ),
                ),
                SizedBox(width: 12.0),
                badgeIcon != null ? badgeIcon! : const SizedBox(),
                onPressed != null && !hideOnPressedIcon
                    ? Icon(
                        Icons.chevron_right,
                        color: Colors.grey[500],
                      )
                    : const SizedBox(),
              ],
            ),
            const SizedBox(height: 15.0),
            useDivider! ? TabBarSeparatorWidget() : const SizedBox(),
          ],
        ),
      ),
    );
  }
}
