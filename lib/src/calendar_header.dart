import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/src/default_styles.dart'
    show defaultHeaderTextStyle;

class CalendarHeader extends StatelessWidget {
  /// Passing in values for [leftButtonIcon] or [rightButtonIcon] will override [headerIconColor]
  const CalendarHeader(
      {Key? key,
      required this.headerTitle,
      this.headerMargin,
      required this.showHeader,
      this.headerTextStyle,
      this.showHeaderButtons = true,
      this.headerIconColor,
      this.leftButtonIcon,
      this.rightButtonIcon,
      required this.onLeftButtonPressed,
      required this.onRightButtonPressed,
      this.onHeaderTitlePressed})
      : isTitleTouchable = onHeaderTitlePressed != null,
        super(key: key);

  final String headerTitle;
  final EdgeInsetsGeometry? headerMargin;
  final bool showHeader;
  final TextStyle? headerTextStyle;
  final bool showHeaderButtons;
  final Color? headerIconColor;
  final Widget? leftButtonIcon;
  final Widget? rightButtonIcon;
  final VoidCallback onLeftButtonPressed;
  final VoidCallback onRightButtonPressed;
  final bool isTitleTouchable;
  final VoidCallback? onHeaderTitlePressed;

  TextStyle get getTextStyle => headerTextStyle ?? defaultHeaderTextStyle;

  Widget _leftButton() => IconButton(
        onPressed: onLeftButtonPressed,
        icon:
            leftButtonIcon ?? Icon(Icons.chevron_left, color: headerIconColor),
      );

  Widget _rightButton() => IconButton(
        onPressed: onRightButtonPressed,
        icon: rightButtonIcon ??
            Icon(Icons.chevron_right, color: headerIconColor),
      );

  Widget _headerTouchable() => TextButton(
        onPressed: onHeaderTitlePressed,
        child: Text(
          headerTitle,
          semanticsLabel: headerTitle,
          style: getTextStyle,
        ),
      );

  @override
  Widget build(BuildContext context) => showHeader
      ? Container(
          margin: headerMargin,
          child: DefaultTextStyle(
              style: getTextStyle,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    if (showHeaderButtons) _leftButton() else Container(),
                    if (isTitleTouchable)
                      _headerTouchable()
                    else
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 12),
                        margin: const EdgeInsets.only(bottom: 10),
                        decoration: BoxDecoration(
                          border: Border.all(color: Color(0xFF032A52)),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(18),
                          ),
                          color: Color(0xFF032A52).withAlpha(20),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.calendar_today_outlined,
                              color: Color(0xFF032A52),
                              size: 14,
                            ),
                            const SizedBox(width: 5),
                            Text(headerTitle, style: getTextStyle)
                          ],
                        ),
                      ),
                    if (showHeaderButtons) _rightButton() else Container(),
                  ])),
        )
      : Container();
}
