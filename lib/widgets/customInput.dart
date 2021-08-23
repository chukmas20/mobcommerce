import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomInput extends StatelessWidget {
final String? hintText;
final void Function(String)? onChanged;
final void Function(String)? onSubmitted;
final FocusNode? focusNode;
final TextInputAction? textInputAction;
final bool? isPasswordField;
CustomInput({this.hintText, this.onChanged, this.onSubmitted, this.focusNode, this.textInputAction, this.isPasswordField});

  @override
  Widget build(BuildContext context) {
    bool _isPasswordField = isPasswordField ?? false;
    return Container(
      margin: EdgeInsets.symmetric(
          vertical: 12,
          horizontal:24
      ),
        decoration:BoxDecoration(
           color: Colors.grey[200],
          borderRadius: BorderRadius.circular(12.0)
        ),
      child: Column(
        children: [
          TextField(
            obscureText: _isPasswordField,
            onChanged: onChanged,
             onSubmitted: onSubmitted,
             focusNode: focusNode,
             textInputAction: textInputAction,
             decoration: InputDecoration(
               border: InputBorder.none,
               hintText: hintText ?? "Hint text",
               contentPadding: EdgeInsets.symmetric(
                 vertical: 18,
                 horizontal: 18,
               ),
             ),
          ),
        ],
      ),
    );
  }
}
