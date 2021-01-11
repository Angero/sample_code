import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vizable/common/const/barrel.dart';
import 'package:vizable/common/core/blocs/check/check_bloc.dart';
import 'package:vizable/common/core/blocs/take/take_bloc.dart';
import 'package:vizable/common/view/widgets/bloc_text_field.dart';
import 'package:vizable/common/view/widgets/return_bar.dart';
import 'package:vizable/common/core/usecases/change_post_use_case.dart';
import 'package:vizable/flows/auth/signup/core/usecases/find_code_use_case.dart';
import 'package:vizable/flows/auth/signup/data/mock_postcode_datasource.dart';
import 'package:vizable/flows/auth/signup/data/mock_postcode_repository.dart';

class PostPage extends StatefulWidget {
  static const routeName = '/post';
  final String initialValue;
  final Function(String) onExit;

  const PostPage({Key key, this.initialValue, this.onExit}) : super(key: key);

  @override
  _PostPageState createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  String _value;
  CheckBloc _codeBloc;
  TakeBloc _findBloc;
  MockPostcodeDatasource _datasource;

  @override
  void initState() {
    super.initState();
    _datasource = MockPostcodeDatasource();
    _value = widget.initialValue;
    _codeBloc = CheckBloc(usecase: ChangePostcodeUseCase());
    _findBloc = TakeBloc<List<String>, FindCodeUseCase>(
        usecase: FindCodeUseCase(
            repository: MockPostcodeRepository(datasource: _datasource)));
  }

  @override
  void dispose() {
    _codeBloc.close();
    _findBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<CheckBloc, CheckState>(
          cubit: _codeBloc,
          listener: (BuildContext context, CheckState checkState) {
            if (checkState is ChangedCheckState) {
              _value =
                  checkState.result.hasError() ? '' : checkState.result.value;
              _findBloc.add(SendTakeEvent(checkState.result.value));
            }
          },
        ),
      ],
      child: _safeArea(context),
    );
  }

  Widget _safeArea(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            _listBuilderWidget(),
            _controlWidget(context),
          ],
        ),
      ),
    );
  }

  Widget _controlWidget(BuildContext context) {
    return Column(
      children: [
        ReturnBar(),
        SizedBox(height: 32.0),
        BlocTextField(
          checkBloc: _codeBloc,
          label: 'Postcode',
          title: 'Postcode',
          initialValue: this.widget.initialValue,
          inputType: TextInputType.number,
          autoFocus: true,
        ),
      ],
    );
  }

  Widget _listBuilderWidget() {
    return BlocBuilder<TakeBloc, TakeState>(
        cubit: _findBloc,
        builder: (BuildContext context, TakeState takeState) {
          if (takeState is InitialTakeState) {
            return Center(
              child: Text(
                '',
                style: STYLE.r_17_400,
              ),
            );
          } else if (takeState is WaitingTakeState) {
            return Center(
              child: Text(
                'Waiting',
                style: STYLE.r_17_400,
              ),
            );
          } else if (takeState is SuccessTakeState) {
            return _listWidget(takeState.value);
          } else if (takeState is FailureTakeState) {
            return Center(
              child: Text(
                'Failure',
                style: STYLE.r_17_400,
              ),
            );
          }
          return Container();
        });
  }

  Widget _listWidget(List<String> list) {
    return Padding(
      padding: EdgeInsets.only(top: 160.0, left: 16.0, right: 16.0),
      child: ListView.builder(
        itemCount: list.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            child: Container(
              padding: EdgeInsets.only(left: 20.0),
              decoration: BoxDecoration(
                border: Border.all(color: COLOR.blue_thin),
              ),
              height: 48.0,
              child: Align(
                alignment: AlignmentDirectional.centerStart,
                child: Text(
                  list.elementAt(index),
                  style: STYLE.b_16_700.copyWith(color: COLOR.dark),
                ),
              ),
            ),
            onTap: () {
              _value = list.elementAt(index);
              Navigator.of(context).pop();
            },
          );
        },
      ),
    );
  }

  @override
  void deactivate() {
    widget.onExit(_value);
    super.deactivate();
  }
}
