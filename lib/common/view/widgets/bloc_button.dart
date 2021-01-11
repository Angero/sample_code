import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vizable/common/core/blocs/toggle/toggle_bloc.dart';
import 'package:vizable/common/view/widgets/convex_button.dart';

class BlocButton extends StatelessWidget {
  final ToggleBloc toggleBloc;
  final String label;
  final Function() onClick;

  const BlocButton({
    @required this.toggleBloc,
    @required this.label,
    @required this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ToggleBloc, ToggleState>(
        cubit: toggleBloc,
        builder: (BuildContext context, ToggleState toggleState) {
          return Container(
            child: Center(
              child: ConvexButton(
                label: this.label,
                buttonColor: ButtonColor.blue,
                active: toggleState is OnToggleState,
                onClick: () => onClick(),
              ),
            ),
          );
        });
  }
}
