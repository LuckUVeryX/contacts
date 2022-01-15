import 'package:flutter/material.dart';

class ProfilePictureWithTextWidget extends StatelessWidget {
  const ProfilePictureWithTextWidget({
    Key? key,
    required this.backgroundColor,
    required this.initials,
    this.radius,
    this.textStyle,
  }) : super(key: key);

  final double? radius;
  final Color backgroundColor;
  final String initials;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return CircleAvatar(
      backgroundColor: backgroundColor,
      radius: radius,
      child: Text(
        initials.toUpperCase(),
        style: textStyle ?? textTheme.headline6,
      ),
    );
  }
}
