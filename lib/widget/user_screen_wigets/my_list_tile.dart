import 'package:flutter/material.dart';

class MyUserScreenListTile extends StatelessWidget {
  final String title;
  final IconData myIcon;
  final Color color;
  final void Function()? onTap;

  const MyUserScreenListTile({
    super.key,
    required this.title,
    required this.myIcon,
    required this.color,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: ListTile(
        leading: SizedBox(
          height: 60,
          width: 60,
          child: Card(
            child: Icon(
              myIcon,
            ),
          ),
        ),
        title: Text(
          title,
          style: TextStyle(color: color),
        ),
        trailing: Icon(
          Icons.chevron_right,
          color: color,
        ),
      ),
    );
  }
}
