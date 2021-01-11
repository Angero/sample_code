import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vizable/common/const/barrel.dart';
import 'package:vizable/common/core/blocs/check/check_bloc.dart';
import 'package:vizable/common/core/blocs/data/data_bloc.dart';
import 'package:vizable/common/core/blocs/post/post_bloc.dart';
import 'package:vizable/common/core/blocs/toggle/toggle_bloc.dart';
import 'package:vizable/common/core/usecases/change_email_use_case.dart';
import 'package:vizable/common/data/data.dart';
import 'package:vizable/common/view/widgets/bloc_button.dart';
import 'package:vizable/common/view/widgets/bloc_text_field.dart';
import 'package:vizable/common/view/widgets/return_bar.dart';
import 'package:vizable/common/view/widgets/surface_button.dart';
import 'package:vizable/common/view/widgets/universal_text_field.dart';
import 'package:vizable/flows/auth/common/core/usecases/change_password_use_case.dart';
import 'package:vizable/flows/auth/common/core/usecases/use_case_interface.dart';
import 'package:vizable/flows/auth/common/data/mock_auth_repository.dart';
import 'package:vizable/flows/auth/common/services/view_service.dart';
import 'package:vizable/flows/auth/common/view/image_banner.dart';
import 'package:vizable/flows/auth/common/view/popup_window.dart';
import 'package:vizable/flows/auth/forgot/email_code/email_code_page.dart';
import 'package:vizable/flows/auth/signin/send_use_case.dart';
import 'package:vizable/flows/auth/signin/validate_data_use_case.dart';
import 'package:vizable/flows/auth/signup/view/pages/sign_up_page.dart';
import 'package:vizable/flows/auth/token/data/mock_token_datasource.dart';
import 'package:vizable/flows/auth/token/data/mock_token_repository.dart';
import 'package:vizable/flows/main/view/main_page.dart';

class SignInPage extends StatefulWidget {
  static const routeName = '/signin';

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  Data _data;
  DataBloc _dataBloc;
  CheckBloc _emailBloc;
  CheckBloc _passwordBloc;
  ToggleBloc _readyBloc;
  PostBloc _postBloc;

  @override
  void initState() {
    super.initState();
    _data = Data();
    _dataBloc = DataBloc(data: _data, usecase: ValidateDataUseCase());
    _emailBloc = CheckBloc<ChangeEmailUseCase>(usecase: ChangeEmailUseCase());
    _passwordBloc =
        CheckBloc<ChangePasswordUseCase>(usecase: ChangePasswordUseCase());
    _readyBloc = ToggleBloc();
    // _postBloc = PostBloc<SendUseCase>(
    //     usecase: SendUseCase(
    //   authRepository: RealAuthRepository(),
    //   tokenRepository: MockTokenRepository(datasource: MockTokenDatasource()),
    //   data: _data,
    // ));
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
    _emailBloc.close();
    _passwordBloc.close();
    _readyBloc.close();
    _postBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<CheckBloc, CheckState>(
          cubit: _emailBloc,
          listener: (BuildContext context, CheckState checkState) {
            if (checkState is ChangedCheckState)
              _dataBloc.add(ChangeDataEvent(
                  key: WORD.email,
                  value: checkState.result.hasError()
                      ? null
                      : checkState.result.value));
          },
        ),
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
      child: _safeArea(context),
    );
  }

  Widget _safeArea(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SafeArea(child: _listWidget(context)),
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

  Widget _listWidget(BuildContext context) {
    return Stack(
      children: [
        _contentWidget(context),
        ReturnBar(title: 'Sign In'),
      ],
    );
  }

  Widget _contentWidget(BuildContext context) {
    return ListView(
      physics: ClampingScrollPhysics(),
      children: [
        SizedBox(height: 48.0),
        ImageBanner(image: PICTURE.signin),
        SizedBox(height: 33.0),
        GestureDetector(
          child: _helloWidget(),
          onDoubleTap: () {
            Navigator.of(context).pushNamed(MainPage.routeName);
          },
        ),
        SizedBox(height: 56.0),
        BlocTextField(
          checkBloc: _emailBloc,
          label: 'Email',
          title: 'Email',
          inputType: TextInputType.emailAddress,
          action: TextInputAction.next,
        ),
        SizedBox(height: 20.0),
        BlocTextField(
          checkBloc: _passwordBloc,
          label: 'Password',
          title: 'Password',
          type: TextFieldType.secret,
          inputType: TextInputType.visiblePassword,
        ),
        SizedBox(height: 4.0),
        _forgotButton(context),
        SizedBox(height: 32),
        _startSection(),
        SizedBox(height: 30.0),
        _questionWidget(),
        SizedBox(height: 5.0),
        _signUpButton(),
        SizedBox(height: 20.0),
      ],
    );
  }

  Container _forgotButton(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 32.0),
        child: Row(
          children: [
            SurfaceButton(
              label: 'Forgot password?',
              textStyle: STYLE.r_12_400.copyWith(color: COLOR.blue_dark),
              onClick: () {
                Navigator.of(context).pushNamed(EmailCodePage.routeName);
              },
            ),
            Expanded(child: Container(), flex: 1),
          ],
        ),
      ),
    );
  }

  Container _helloWidget() {
    return Container(
      child: Text('Hello and welcome!',
          textAlign: TextAlign.center,
          style: STYLE.r_34_400.copyWith(color: COLOR.dark)),
    );
  }

  Row _startSection() {
    return Row(
      children: [
        Expanded(child: Container(), flex: 1),
        BlocButton(
          toggleBloc: _readyBloc,
          label: 'Let\'s Start',
          onClick: () {
            _readyBloc.add(TurnOffToggleEvent());
            _postBloc.add(SendPostEvent());
          },
        ),
        Expanded(child: Container(), flex: 1),
      ],
    );
  }

  Container _questionWidget() {
    return Container(
      alignment: AlignmentDirectional.center,
      child: Text(
        'Not registered yet?',
        style: STYLE.r_12_400,
      ),
    );
  }

  Container _signUpButton() {
    return Container(
      alignment: AlignmentDirectional.center,
      child: SurfaceButton(
        label: 'SIGN UP',
        textStyle: STYLE.b_14_700.copyWith(color: COLOR.blue),
        onClick: () {
          Navigator.of(context).pushReplacementNamed(SignUpPage.routeName);
        },
      ),
    );
  }
}
