import 'package:fe_ezlang_admin/core/resources/dimens.dart';
import 'package:fe_ezlang_admin/core/resources/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class TextfieldWithTitle extends StatelessWidget {
  final String title;
  final String? hint;
  final bool? obscureText;
  final TextInputType? keyboardType;
  final IconData? leadingIcon;
  const TextfieldWithTitle(
      {super.key,
      required this.title,
      this.hint,
      this.obscureText,
      this.keyboardType,
      this.leadingIcon});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Styles.kLabelStyle,
        ),
        SizedBox(
          height: Dimens.mSpacing,
        ),
        Container(
          alignment: Alignment.centerLeft,
          decoration: Styles.kBoxDecorationStyle,
          padding: EdgeInsets.symmetric(horizontal: Dimens.sPadding),
          height: 60.0,
          child: TextField(
            keyboardType: this.keyboardType ?? TextInputType.text,
            style: TextStyle(color: Colors.white),
            obscureText: this.obscureText ?? false,
            decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding:
                    leadingIcon != null ? EdgeInsets.only(top: 14.0) : null,
                prefixIcon: (leadingIcon != null
                    ? Icon(
                        leadingIcon,
                        color: Colors.white,
                      )
                    : null),
                hintText: hint,
                hintStyle: Styles.kHintTextStyle),
          ),
        )
      ],
    );
  }
}
