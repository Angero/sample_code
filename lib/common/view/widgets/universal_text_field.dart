import 'dart:io' show Platform;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:vizable/common/const/barrel.dart';
import 'package:vizable/flows/auth/common/services/date_time_service.dart';

enum TextFieldType { simple, secret, calendar, reference }

class UniversalTextField extends StatefulWidget {
  final String label;
  final String title;
  final String hint;
  final String error;
  final String comment;
  final TextFieldType type;
  final TextInputType inputType;
  final TextInputAction action;
  final String initialValue;
  final bool readOnly;
  final TextEditingController controller;
  final bool autoFocus;
  final int maxLines;
  final int maxLength;
  final Function(String) onChange;
  final Function() onSuffixClick;
  final Function() onTap;

  const UniversalTextField({
    Key key,
    this.label = '',
    this.title = '',
    this.hint = '',
    this.error = '',
    this.comment = '',
    this.type = TextFieldType.simple,
    this.inputType = TextInputType.text,
    this.action = TextInputAction.done,
    this.initialValue = '',
    this.readOnly = false,
    this.controller,
    this.autoFocus = false,
    this.maxLines = 1,
    this.maxLength,
    this.onChange,
    this.onSuffixClick,
    this.onTap,
  }) : super(key: key);

  @override
  _UniversalTextFieldState createState() => _UniversalTextFieldState();
}

class _UniversalTextFieldState extends State<UniversalTextField> {
  FocusNode myFocusNode;
  bool _obscureText;
  TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    myFocusNode = FocusNode();
    myFocusNode.addListener(() {
      setState(() {});
    });
    _controller = widget.controller ?? TextEditingController();
    _controller.text = widget.initialValue;
    _obscureText = widget.type == TextFieldType.secret;
  }

  @override
  void dispose() {
    myFocusNode.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _textFieldContainer(context),
          widget.error.isEmpty ? _commentText() : _errorText(),
        ],
      ),
    );
  }

  Container _textFieldContainer(BuildContext context) {
    return Container(
      height: widget.maxLines == 1 ? 56.0 : null,
      // color: Colors.yellow,
      decoration: BoxDecoration(
        border: Border.all(color: COLOR.grey),
        borderRadius: BorderRadius.circular(4.0),
        // color: Colors.red,
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 4.0),
        child: _textField(context),
      ),
    );
  }

  Container _textField(BuildContext context) {
    Widget _suffixWidget;
    if (widget.type == TextFieldType.secret)
      _suffixWidget = _secretSuffixWidget();
    if (widget.type == TextFieldType.calendar)
      _suffixWidget = _calendarSuffixWidget(context);
    if (widget.type == TextFieldType.reference)
      _suffixWidget = _referenceSuffixWidget();
    return Container(
      // color: Colors.yellow,
      child: TextField(
        // autofocus: true,
        // textAlignVertical: TextAlignVertical.top,
        readOnly: widget.readOnly,
        focusNode: myFocusNode,
        controller: _controller,
        cursorColor: COLOR.grey_dark,
        style: STYLE.r_17_400.copyWith(color: COLOR.dark),
        obscureText: _obscureText ?? false,
        maxLines: widget.maxLines,
        keyboardType: widget.inputType,
        textInputAction: widget.action,
        autofocus: widget.autoFocus,
        maxLength: widget.maxLength,
        decoration: InputDecoration(
          contentPadding:
              EdgeInsets.only(left: 12.0, right: 12.0, top: 8.0, bottom: 11.0),
          labelText:
              !myFocusNode.hasFocus && (_controller.text?.isEmpty ?? true)
                  ? widget.title
                  : widget.label,
          labelStyle: STYLE.r_17_400.copyWith(
              color: myFocusNode.hasFocus
                  ? (widget.error.isEmpty ? COLOR.blue : COLOR.error)
                  : COLOR.grey_dark),
          hintText: widget.hint,
          hintStyle: STYLE.r_17_400.copyWith(color: COLOR.grey_dark),
          border: _border(),
          focusedBorder: _border(),
          enabledBorder: _border(),
          errorBorder: _border(),
          disabledBorder: _border(),
          suffix: _suffixWidget,
          // counter: Container(color: Colors.yellow,),
          counterText: '',
          // counterStyle: STYLE.r_15_400,
        ),
        onChanged: (value) => widget.onChange(value),
        onTap: () => widget.onTap != null ? widget.onTap() : null,
      ),
    );
  }

  Widget _secretSuffixWidget() {
    return InkWell(
      child: Container(
        // color: Colors.yellow,
        child: Icon(
          (_obscureText ? Icons.visibility : Icons.visibility_off),
          color: COLOR.grey_dark,
        ),
      ),
      onTap: () {
        setState(() {
          _obscureText = !_obscureText;
        });
      },
    );
  }

  Widget _calendarSuffixWidget(BuildContext context) {
    return InkWell(
      child: Container(
        // color: Colors.yellow,
        child: Icon(
          Icons.calendar_today,
          color: COLOR.grey_dark,
        ),
      ),
      onTap: () async {
        Platform.isIOS ? widget.onSuffixClick() : _googleCalendar();
      },
    );
  }

  void _googleCalendar() async {
    DateTime initialDate = DateTimeService.transformDate(_controller.text);
    DateTime dt = await showDatePicker(
      context: context,
      initialDate: initialDate ?? DateTime.now(),
      firstDate: DateTime(1920),
      lastDate: DateTime(2031),
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.light(primary: COLOR.blue),
          ),
          child: child,
        );
      },
    );
    if (dt != null) {
      _controller.text = DateFormat('dd/MM/yyyy').format(dt);
      widget.onChange(_controller.text);
    }
  }

  Widget _referenceSuffixWidget() {
    return InkWell(
      child: Container(
        // color: Colors.yellow,
        child: Icon(
          (Icons.chevron_right),
          color: COLOR.grey_dark,
        ),
      ),
      onTap: () => widget.onSuffixClick(),
    );
  }

  InputBorder _border() {
    return UnderlineInputBorder(
      borderSide: myFocusNode.hasFocus
          ? BorderSide(
              color: widget.error.isEmpty ? COLOR.blue : COLOR.error,
              width: 2.0)
          : BorderSide.none,
    );
  }

  Widget _errorText() {
    return Container(
      // height: 20.0,
      // color: Colors.yellow,
      child: Padding(
        padding: EdgeInsets.only(left: 16.0, right: 8.0, top: 3.0),
        child: Text(
          widget.error,
          style: STYLE.r_12_400.copyWith(color: COLOR.error),
          // maxLines: 1,
          // overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
  Widget _commentText() {
    return Container(
      height: widget.comment.isEmpty || _controller.text.isNotEmpty ? 0.0 : 20.0,
      // color: Colors.yellow,
      child: Padding(
        padding: EdgeInsets.only(left: 16.0, right: 8.0, top: 3.0),
        child: Text(
          widget.comment,
          style: STYLE.r_12_400,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }

}
