import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vizable/common/core/blocs/check/check_bloc.dart';
import 'package:vizable/common/view/widgets/universal_text_field.dart';

class BlocTextField extends StatelessWidget {
  final CheckBloc checkBloc;
  final String label;
  final String title;
  final String hint;
  final String comment;
  final TextFieldType type;
  final TextInputType inputType;
  final TextInputAction action;
  final bool readOnly;
  final String initialValue;
  final TextEditingController controller;
  final bool autoFocus;
  final int maxLines;
  final int maxLength;
  final Function() onTap;
  final Function() onSuffixClick;

  const BlocTextField({
    Key key,
    @required this.checkBloc,
    this.label = '',
    this.title = '',
    this.hint = '',
    this.comment = '',
    this.type = TextFieldType.simple,
    this.inputType = TextInputType.text,
    this.action = TextInputAction.done,
    this.readOnly = false,
    this.initialValue = '',
    this.controller,
    this.autoFocus = false,
    this.maxLines = 1,
    this.maxLength,
    this.onTap,
    this.onSuffixClick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CheckBloc, CheckState>(
        cubit: this.checkBloc,
        builder: (BuildContext context, CheckState fieldState) {
          String error = '';
          if (fieldState is ChangedCheckState) {
            if (fieldState.result.hasError()) {
              error = fieldState.result.error;
            }
          }
          return UniversalTextField(
            label: this.label,
            title: this.title,
            hint: this.hint,
            type: this.type,
            inputType: this.inputType,
            action: this.action,
            error: error,
            comment: this.comment,
            readOnly: this.readOnly,
            initialValue: this.initialValue,
            controller: this.controller,
            autoFocus: this.autoFocus,
            maxLines: this.maxLines,
            maxLength: this.maxLength,
            onChange: (value) {
              this.checkBloc.add(ChangeCheckEvent(value));
              // _readyBloc.add(CheckReadyEvent());
            },
            onTap: () => this.onTap != null ? this.onTap() : null,
            onSuffixClick: () =>
                this.onSuffixClick != null ? this.onSuffixClick() : null,
          );
        });
  }
}
