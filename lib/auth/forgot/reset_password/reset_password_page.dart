import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vizable/common/const/barrel.dart';
import 'package:vizable/common/core/blocs/check/check_bloc.dart';
import 'package:vizable/common/core/blocs/data/data_bloc.dart';
import 'package:vizable/common/core/blocs/post/post_bloc.dart';
import 'package:vizable/common/core/blocs/toggle/toggle_bloc.dart';
import 'package:vizable/flows/auth/common/core/usecases/change_password_use_case.dart';
import 'package:vizable/flows/auth/common/core/usecases/use_case_interface.dart';
import 'package:vizable/common/data/data.dart';
import 'package:vizable/flows/auth/common/data/mock_auth_repository.dart';
import 'package:vizable/flows/auth/common/services/view_service.dart';
import 'package:vizable/common/view/widgets/bloc_button.dart';
import 'package:vizable/common/view/widgets/bloc_text_field.dart';
import 'package:vizable/flows/auth/common/view/image_banner.dart';
import 'package:vizable/flows/auth/common/view/popup_window.dart';
import 'package:vizable/common/view/widgets/return_bar.dart';
import 'package:vizable/common/view/widgets/universal_text_field.dart';
import 'package:vizable/flows/auth/forgot/reset_password/send_use_case.dart';
import 'package:vizable/common/core/usecases/validate_password_use_case.dart';
import 'package:vizable/flows/auth/token/data/mock_token_datasource.dart';
import 'package:vizable/flows/auth/token/data/mock_token_repository.dart';
import 'package:vizable/flows/main/view/main_page.dart';

class ResetPasswordPage extends StatefulWidget {
  static const routeName = '/reset_password';

  @override
  _ResetPasswordPageState createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  Data _data;
  DataBloc _dataBloc;
  CheckBloc _passwordBloc;
  CheckBloc _confirmBloc;
  ToggleBloc _readyBloc;
  PostBloc _postBloc;

  @override
  void initState() {
    super.initState();
    _data = Data();
    _dataBloc = DataBloc(data: _data, usecase: ValidatePasswordUseCase());
    _passwordBloc =
        CheckBloc<ChangePasswordUseCase>(usecase: ChangePasswordUseCase());
    _confirmBloc =
        CheckBloc<ChangePasswordUseCase>(usecase: ChangePasswordUseCase());
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
    _passwordBloc.close();
    _confirmBloc.close();
    _readyBloc.close();
    _postBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<CheckBloc, CheckState>(
          cubit: _passwordBloc,
          listener: (BuildContext context, CheckState checkState) {
            if (checkState is ChangedCheckState)
              _dataBloc.add(ChangeDataEvent(
                  key: WORD.password,
                  value: checkState.result.hasError()
                      ? null
                      : checkState.result.value));
          },
        ),
        BlocListener<CheckBloc, CheckState>(
          cubit: _confirmBloc,
          listener: (BuildContext context, CheckState checkState) {
            if (checkState is ChangedCheckState)
              _dataBloc.add(ChangeDataEvent(
                  key: WORD.confirm,
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
              Navigator.of(context).pushNamed(MainPage.routeName);
            } else if (postState is FailurePostState) {
              FocusScope.of(context).unfocus();
              _readyBloc.add(TurnOnToggleEvent());
              print('RA: ' + postState.error);
            }
          },
        ),
      ],
      child: _safeArea(),
    );
  }

  Widget _safeArea() {
    return Scaffold(
      body: Stack(
        children: [
          SafeArea(child: Stack(
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
        ImageBanner(image: PICTURE.resetPassword),
        SizedBox(height: 119.0),
        Container(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            width: double.infinity,
            child: Text('Create new password',
                style: STYLE.b_24_700.copyWith(color: COLOR.dark))),
        SizedBox(height: 7.0),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          width: double.infinity,
          child: Text(
            'At least 8 characters',
            style: STYLE.r_17_400,
          ),
        ),
        SizedBox(height: 19.0),
        BlocTextField(
          checkBloc: _passwordBloc,
          label: 'New password',
          title: 'New password',
          type: TextFieldType.secret,
          inputType: TextInputType.visiblePassword,
          action: TextInputAction.next,
        ),
        SizedBox(height: 20.0),
        BlocTextField(
          checkBloc: _confirmBloc,
          label: 'Confirm password',
          title: 'Confirm password',
          type: TextFieldType.secret,
          inputType: TextInputType.visiblePassword,
        ),
        SizedBox(height: 50.0),
        BlocButton(
          toggleBloc: _readyBloc,
          label: 'Let\'s Start',
          onClick: () {
            _readyBloc.add(TurnOffToggleEvent());
            _postBloc.add(SendPostEvent());
          },
        ),
        SizedBox(height: 20.0),
      ],
    );
  }
}
