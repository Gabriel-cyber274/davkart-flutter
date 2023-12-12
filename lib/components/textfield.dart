import 'package:flutter/material.dart';

class MyTextField extends StatefulWidget {
  final String hintText;
  bool obscureText;
  final controller;
  final Widget icon;
  bool confirm;

  MyTextField({
    Key? key,
    required this.hintText,
    required this.controller,
    required this.confirm,
    required this.obscureText,
    required this.icon,
  }) : super(key: key);

  @override
  State<MyTextField> createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  // bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: TextFormField(
        controller: widget.controller,
        obscureText: widget.obscureText,
        validator: (value) {
          if ((value == null || value.isEmpty) &&
              widget.hintText == 'Username') {
            return 'Please enter your username';
          } else if ((value == null || value.isEmpty) &&
              widget.hintText == 'Phone number') {
            return 'Please enter your Phone number';
          } else if ((value == null || value.isEmpty) &&
              widget.hintText == 'Confirm Password') {
            return 'Please enter Confirm Password';
          } else if ((value == null || value.isEmpty) &&
              widget.hintText == 'Password') {
            return 'Please enter your Password';
          } else if ((value == null || value.isEmpty) &&
              widget.hintText == 'Email') {
            return 'Please enter your Email';
          } else if (widget.hintText == 'Email' &&
              !RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$')
                  .hasMatch(value!)) {
            return 'Please enter a valid Email';
          } else if (widget.hintText == 'Confirm Password' && !widget.confirm) {
            return "Confirm password doesn't match password";
          }
          // if ((value == null || value.isEmpty) &&
          //         widget.hintText == 'Password' ||
          //     widget.hintText == 'Username' ||
          //     widget.hintText == 'Phone number' ||
          //     widget.hintText == 'Confirm Password' ||
          //     widget.hintText == 'Email') {
          //   return 'this field is required';
          // }
          // else if (!RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$')
          //         .hasMatch(value) &&
          //     widget.hintText == 'Email') {
          //   return 'Please enter a valid email address';
          // }
          return null;
        },
        decoration: InputDecoration(
          enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xFF3A3A3A))),
          focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey)),
          // prefixIcon: Icon(Icons.person),
          prefixIcon: widget.icon,
          prefixIconColor: const Color(0xFF010CA6),
          suffixIcon: (widget.hintText == 'Password' && widget.obscureText) ||
                  (widget.hintText == 'Confirm Password' && widget.obscureText)
              ? GestureDetector(
                  onTap: () => {
                    setState(() {
                      widget.obscureText = false;
                    }),
                  },
                  child: const Icon(Icons.visibility_off),
                )
              : (widget.hintText == 'Password' && !widget.obscureText) ||
                      (widget.hintText == 'Confirm Password' &&
                          !widget.obscureText)
                  ? GestureDetector(
                      onTap: () => {
                        setState(() {
                          widget.obscureText = true;
                        }),
                      },
                      child: const Icon(Icons.visibility),
                    )
                  : null,
          suffixIconColor: const Color(0xFF010CA6),
          hintText: widget.hintText,
        ),
      ),
    );
  }
}
