import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vizable/common/core/blocs/post/post_bloc.dart';
import 'package:vizable/flows/auth/common/view/popup_window.dart';

class BlocPopupWindow extends StatelessWidget {
  final PostBloc postBloc;

  const BlocPopupWindow({Key key, @required this.postBloc}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PostBloc, PostState>(
        cubit: postBloc,
        builder: (BuildContext context, PostState postState) {
          if (postState is FailurePostState) {
            return PopupWindow(
              title: faker.lorem.sentence(),
              content: faker.lorem.sentence(),
              onClick: () {
                postBloc.add(InitiatePostEvent());
              },
            );
          }
          return Container();
        });
  }
}
