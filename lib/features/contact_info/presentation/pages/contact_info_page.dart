import 'package:flutter/material.dart';

import '../../../../core/domain/entities/contact.dart';

class ContactInfoPage extends StatelessWidget {
  const ContactInfoPage({
    Key? key,
    required this.contact,
  }) : super(key: key);

  final Contact contact;

  @override
  Widget build(BuildContext context) {
    // return Container();
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              pinned: true,
              centerTitle: true,
              expandedHeight: 160.0,
              collapsedHeight: kToolbarHeight + 42,
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                title: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 8.0),
                    CircleAvatar(backgroundColor: contact.profileColor),
                    const SizedBox(height: 8.0),
                    Text(
                      contact.firstName + ' ' + contact.lastName,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return Container(
                    color: Colors.red,
                    height: 80,
                    width: 10,
                    margin: EdgeInsets.all(8.0),
                  );
                },
                childCount: 50,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
