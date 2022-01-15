import 'package:flutter/material.dart';

import '../../../../core/domain/entities/contact.dart';

class ProfilePictureWithTextWidget extends StatelessWidget {
  const ProfilePictureWithTextWidget({
    Key? key,
    required this.contact,
    this.radius,
  }) : super(key: key);

  final Contact contact;
  final double? radius;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return CircleAvatar(
      backgroundColor: contact.profileColor,
      radius: radius,
      child: Text(
        contact.initals.toUpperCase(),
        style: textTheme.headline6,
      ),
    );
  }
}
