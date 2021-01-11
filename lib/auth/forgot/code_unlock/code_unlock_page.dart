import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vizable/common/const/barrel.dart';
import 'package:vizable/common/core/blocs/check/check_bloc.dart';
import 'package:vizable/common/core/blocs/data/data_bloc.dart';
import 'package:vizable/common/core/blocs/post/post_bloc.dart';
import 'package:vizable/common/core/blocs/toggle/toggle_bloc.dart';
import 'package:vizable/flows/auth/common/core/usecases/change_code_use_case.dart';
import 'package:vizable/flows/auth/common/core/usecases/use_case_interface.dart';
import 'package:vizable/common/data/data.dart';
import 'package:vizable/flows/auth/common/data/mock_auth_repository.dart';
import 'package:vizable/flows/auth/common/services/view_service.dart';
import 'package:vizable/common/view/widgets/bloc_button.dart';
import 'package:vizable/common/view/widgets/bloc_text_field.dart';
import 'package:vizable/flows/auth/common/view/image_banner.dart';
import 'package:vizable/flows/auth/common/view/popup_window.dart';
import 'package:vizable/common/view/widgets/return_bar.dart';
import 'package:vizable/common/view/widgets/surface_button.dart';
import 'package:vizable/flows/auth/forgot/code_unlock/send_code_use_case.dart';
import 'package:vizable/flows/auth/forgot/code_unlock/validate_data_use_case.dart';
import 'package:vizable/flows/auth/forgot/reset_password/reset_password_page.dart';
import 'package:vizable/flows/auth/token/data/mock_token_datasource.dart';
import 'package:vizable/flows/auth/token/data/mock_token_repository.dart';

class CodeUnlockPage extends StatefulWidget {
  static const routeName = '/code_unlock';

  @override
  _CodeUnlockPageState createState() => _CodeUnlockPageState();
}

class _CodeUnlockPageState extends State<CodeUnlockPage> {
  Data _data;
  DataBloc _dataBloc;
  CheckBloc _codeBloc;
  ToggleBloc _readyBloc;
  PostBloc _postBloc;

  @override
  void initState() {
    super.initState();
    _data = Data();
    _dataBloc = DataBloc(data: _data, usecase: ValidateDataUseCase());
    _codeBloc = CheckBloc<ChangeCodeUseCase>(usecase: ChangeCodeUseCase());
    _readyBloc = ToggleBloc();
    _postBloc = PostBloc<SendUseCase>(
        usecase: SendUseCase(
      authRepository: MockAuthRepository(),
      tokenRepository: MockTokenRepository(datasource: MockTokenDatasource()),
      data: _data,
    ));
  }

  @override
  void dispose() {
    _dataBloc.close();
    _codeBloc.close();
    _readyBloc.close();
    _postBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<CheckBloc, CheckState>(
          cubit: _codeBloc,
          listener: (BuildContext context, CheckState checkState) {
            if (checkState is ChangedCheckState)
              _dataBloc.add(ChangeDataEvent(
                  key: WORD.code,
                  value: checkState.result.hasError()
                      ? null
                      : checkState.result.value));
          },
        ),
        BlocListener<DataBloc, DataState>(
          cubit: _dataBloc,
          listener: (BuildContext context, DataState dataState) {
            if (dataState is ChangedDataState)
              _readyBloc.add(dataState.result.hasError()
                  ? TurnOffToggleEvent()
                  : TurnOnToggleEvent());
          },
        ),
        BlocListener<PostBloc, PostState>(
          cubit: _postBloc,
          listener: (BuildContext context, PostState postState) {
            if (postState is SuccessPostState) {
              _readyBloc.add(TurnOnToggleEvent());
              Navigator.of(context).pushNamed(ResetPasswordPage.routeName);
            } else if (postState is FailurePostState) {
              FocusScope.of(context).unfocus();
              _readyBloc.add(TurnOnToggleEvent());
              print('RA: ' + postState.error);
            }
          },
        ),
      ],
      child: _safeArea(context),
    );
  }

  Widget _safeArea(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SafeArea(
              child: Stack(
            children: [
              _listWidget(),
              ReturnBar(title: 'Reset password'),
            ],
          )),
          _popupWidget(),
        ],
      ),
    );
  }

  BlocBuilder<PostBloc<IFutureUseCase>, PostState> _popupWidget() {
    return BlocBuilder<PostBloc, PostState>(
        cubit: _postBloc,
        builder: (BuildContext context, PostState postState) {
          if (postState is FailurePostState) {
            return PopupWindow(
              title: faker.lorem.sentence(),
              content: faker.lorem.sentence(),
              onClick: () {
                _postBloc.add(InitiatePostEvent());
              },
            );
          }
          return Container();
        });
  }

  Widget _listWidget() {
    return ListView(
      physics: ClampingScrollPhysics(),
      children: [
        SizedBox(height: 48.0),
        ImageBanner(image: PICTURE.codeUnlock),
        SizedBox(height: 78.0),
        Container(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            width: double.infinity,
            child: Text(
                'A message will be sent to that address containing a Code to unlock your account.',
                style: STYLE.b_24_700.copyWith(color: COLOR.dark))),
        SizedBox(height: 7.0),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          width: double.infinity,
          child: Text(
            'If you do not receive your email within five minutes check your spam folder.',
            style: STYLE.r_17_400,
          ),
        ),
        SizedBox(height: 26.0),
        BlocTextField(
          checkBloc: _codeBloc,
          label: 'Code',
          title: 'Code',
          inputType: TextInputType.number,
        ),
        SizedBox(height: 40.0),
        BlocButton(
          toggleBloc: _readyBloc,
          label: 'Next',
          onClick: () {
            _readyBloc.add(TurnOffToggleEvent());
            _postBloc.add(SendPostEvent());
          },
        ),
        SizedBox(height: 30.0),
        Container(
          child: Center(
            child: SurfaceButton(
              label: 'RESEND',
              textStyle: STYLE.b_14_700.copyWith(color: COLOR.blue),
              onClick: () {},
            ),
          ),
        ),
        SizedBox(height: 20.0),
      ],
    );
  }
}
