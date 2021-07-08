import 'package:eureka_learn/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

class Input extends StatefulWidget {
  final IconData icon;
  final BuildContext context;
  final TextEditingController controller;
  final String label;
  final String hint;
  final bool isPassword;
  final bool isPhone;
  final TextInputType type;

  const Input(
      {Key? key,
      required this.context,
      required this.controller,
      required this.label,
      required this.hint,
      required this.isPassword,
      required this.type,
      required this.isPhone,
      required this.icon})
      : super(key: key);

  @override
  _InputState createState() => _InputState();
}

class _InputState extends State<Input> {
  bool obscure = true;
  bool iconChanged = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: TextField(
        style: TextStyle(
          color: Palette.primary,
          fontWeight: FontWeight.w400,
        ),
        onTap: () {
          Navigator.canPop(widget.context);
        },
        keyboardType: widget.type,
        obscureText: widget.isPassword && obscure ? true : false,
        decoration: InputDecoration(
            prefixIcon:
                Icon(widget.icon, color: Palette.primary.withOpacity(0.5)),
            hintText: widget.hint,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0)),
              borderSide: BorderSide(color: Palette.primary),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0)),
              borderSide: BorderSide(
                  color: Palette.primary.withOpacity(0.5), width: 0.5),
            ),
            contentPadding: const EdgeInsets.only(left: 12.0),
            suffixIcon: widget.isPassword
                ? IconButton(
                    icon: iconChanged
                        ? Icon(LineIcons.eyeSlashAlt,
                            color: Palette.primary.withOpacity(0.5))
                        : Icon(LineIcons.eye,
                            color: Palette.primary.withOpacity(0.5)),
                    onPressed: () {
                      setState(() {
                        iconChanged = !iconChanged;
                        obscure = !obscure;
                      });
                    })
                : null,
            labelText: widget.label),
      ),
    );
  }
}
