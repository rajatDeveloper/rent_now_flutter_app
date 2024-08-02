import 'package:flutter/material.dart';
import 'package:rent_now/core/utils/use_full_functions.dart';
// Assuming you have AppColors

// ignore: must_be_immutable
class CustomTextField extends StatefulWidget {
  final TextEditingController controller;
  final FocusNode node;
  final FocusNode? nextNode;

  final Color backgroundColor; // Added parameter for background color
  final Color borderActiveColor; // Added parameter for active border color
  final Color textColor; // Added parameter for text color
  final Color activeTextColor; // Added parameter for active text color
  final Color textFieldTextColor; // Added parameter for text color in TextField
  final bool isWritable; // Added parameter for whether the field is writable
  Function(String val)? onChange;
  final int? maxLines;

  CustomTextField({
    super.key,
    required this.controller,
    this.maxLines,
    this.onChange,
    this.hintText,
    this.tapOn,
    this.isNum = false,
    this.maxLength = 50,
    this.isPassword = false,
    this.autofillHints,
    required this.node,
    this.nextNode,
    this.backgroundColor = Colors.transparent, // Default background color
    this.borderActiveColor = Colors.blue, // Default active border color
    this.textColor = Colors.black, // Default text color
    this.activeTextColor = Colors.blue, // Default active text color
    this.textFieldTextColor = Colors.black, // Default text color in TextField
    this.isWritable = true,
    this.borderRadius = 5.0, // Default is writable
  });
  String? hintText;
  Function()? tapOn;
  final bool isNum;
  int maxLength;
  bool isPassword;
  final Iterable<String>? autofillHints;
  final double borderRadius;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  void dispose() {
    super.dispose();
    // widget.controller.dispose();
  }

  bool ishide = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.hintText!,
          style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: getFontSize(16.5, getDeviceWidth(context)),
              color: widget.node.hasFocus
                  ? widget.activeTextColor
                  : widget.textColor),
        ),
        SizedBox(
          height: getDeviceHeight(context) * 0.01,
        ),
        TextField(
          onChanged: (val) {
            if (widget.onChange != null) {
              widget.onChange!(val);
            }
          },
          maxLength: widget.maxLength,
          maxLines: widget.maxLines ?? 1,
          keyboardType:
              widget.isNum ? TextInputType.number : TextInputType.text,
          controller: widget.controller,
          obscureText: widget.isPassword ? ishide : false,
          autofillHints: widget.autofillHints,
          focusNode: widget.node,
          textInputAction: widget.nextNode == null
              ? TextInputAction.done
              : TextInputAction.next,
          onSubmitted: (value) {
            if (widget.nextNode != null) {
              widget.node.unfocus();
              FocusScope.of(context).requestFocus(widget.nextNode);
            }
          },
          enabled:
              widget.isWritable, // Set the enabled property based on isWritable
          style: TextStyle(
              color: widget.textFieldTextColor), // Set text color in TextField
          decoration: InputDecoration(
            suffixIcon: widget.isPassword
                ? IconButton(
                    onPressed: () {
                      setState(() {
                        ishide = !ishide;
                      });
                    },
                    icon: Icon(
                      ishide ? Icons.visibility : Icons.visibility_off,
                      color: Colors.black,
                    ),
                  )
                : null,
            counterText: '',
            filled: true,
            fillColor: widget.backgroundColor,
            hintText: '',

            hintStyle: const TextStyle(color: Colors.black),
            enabledBorder: OutlineInputBorder(
              borderRadius:
                  BorderRadius.all(Radius.circular(widget.borderRadius)),
              borderSide: const BorderSide(
                color: Colors
                    .grey, // Use a default border color for inactive state
              ),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius:
                  BorderRadius.all(Radius.circular(widget.borderRadius)),
              borderSide: const BorderSide(
                color: Colors
                    .grey, // Use a default border color for disabled state
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius:
                  BorderRadius.all(Radius.circular(widget.borderRadius)),
              borderSide: BorderSide(
                color: widget.borderActiveColor,
              ),
            ),
            // Set text color based on focus state
          ),
        ),
      ],
    );
  }
}
