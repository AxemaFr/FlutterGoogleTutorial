import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ListItem extends StatelessWidget {
  ListItem({this.title, this.subtitle, this.leftIcon, this.rightIcon, this.onTap});

  final _titleFont = const TextStyle(fontSize: 16, color: Color.fromRGBO(66, 66, 66, 1));
  final _subtitleFont = const TextStyle(fontSize: 12, color: Color.fromRGBO(179, 179, 179, 1));

  final String title;
  final String subtitle;
  final Icon leftIcon;
  final Icon rightIcon;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: this.leftIcon != null ? Container(
        child: this.leftIcon,
        alignment: Alignment.centerLeft,
        width: 16,
      ) : null,
      title: Text(
        this.title,
        style: _titleFont,
      ),
      subtitle: Text(
          this.subtitle,
          style: _subtitleFont
      ),
      trailing: this.rightIcon != null ? this.rightIcon : null,
      onTap: this.onTap != null ? () => this.onTap(title, subtitle) : null,
    );
  }

}