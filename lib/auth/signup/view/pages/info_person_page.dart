import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vizable/common/const/barrel.dart';
import 'package:vizable/common/core/blocs/check/check_bloc.dart';
import 'package:vizable/common/core/blocs/data/data_bloc.dart';
import 'package:vizable/common/core/blocs/post/post_bloc.dart';
import 'package:vizable/common/core/blocs/toggle/toggle_bloc.dart';
import 'package:vizable/common/core/usecases/change_birth_use_case.dart';
import 'package:vizable/common/core/usecases/change_email_use_case.dart';
import 'package:vizable/common/core/usecases/change_name_use_case.dart';
import 'package:vizable/common/core/usecases/change_post_use_case.dart';
import 'package:vizable/common/data/data.dart';
import 'package:vizable/common/view/pages/post_page.dart';
import 'package:vizable/common/view/widgets/cupertino_calendar_window.dart';
import 'package:vizable/flows/auth/common/core/usecases/change_password_use_case.dart';
import 'package:vizable/flows/auth/common/data/mock_auth_repository.dart';
import 'package:vizable/flows/auth/common/services/date_time_service.dart';
import 'package:vizable/common/view/widgets/bloc_button.dart';
import 'package:vizable/common/view/widgets/bloc_text_field.dart';
import 'package:vizable/common/view/widgets/return_bar.dart';
import 'package:vizable/flows/auth/common/view/step_counter.dart';
import 'package:vizable/flows/auth/common/view/step_progress.dart';
import 'package:vizable/common/view/widgets/surface_button.dart';
import 'package:vizable/common/view/widgets/universal_text_field.dart';
import 'package:vizable/flows/auth/signin/sign_in_page.dart';
import 'package:vizable/flows/auth/signup/core/usecases/send_use_case.dart';
import 'package:vizable/flows/auth/signup/core/usecases/validate_data_use_case.dart';
import 'package:vizable/flows/auth/signup/view/pages/deny_page.dart';
import 'package:vizable/flows/auth/signup/view/pages/terms_page.dart';
import 'package:vizable/flows/auth/signup/view/pages/verify_page.dart';
import 'package:vizable/flows/auth/signup/view/widgets/note_card.dart';
import 'package:vizable/flows/auth/token/data/mock_token_datasource.dart';
import 'package:vizable/flows/auth/token/data/mock_token_repository.dart';

class InfoPersonPage extends StatefulWidget {
  static const routeName = '/info';

  @override
  _InfoPersonPageState createState() => _InfoPersonPageState();
}

class _InfoPersonPageState extends State<InfoPersonPage> {
  Data _data;
  DataBloc _dataBloc;
  CheckBloc _firstBloc;
  CheckBloc _lastBloc;
  CheckBloc _emailBloc;
  CheckBloc _birthBloc;
  CheckBloc _postcodeBloc;
  CheckBloc _passwordBloc;
  ToggleBloc _readyBloc;
  PostBloc _postBloc;
  TextEditingController _postcodeController;
  TextEditingController _calendarController;
  bool _showCalendar;

  @override
  void initState() {
    super.initState();
    _data = Data();
    _dataBloc = DataBloc(data: _data, usecase: ValidateDataUseCase());
    _firstBloc = CheckBloc<ChangeNameUseCase>(usecase: ChangeNameUseCase());
    _lastBloc = CheckBloc<ChangeNameUseCase>(usecase: ChangeNameUseCase());
    _emailBloc = CheckBloc<ChangeEmailUseCase>(usecase: ChangeEmailUseCase());
    _birthBloc = CheckBloc<ChangeBirthUseCase>(usecase: ChangeBirthUseCase());
    _postcodeBloc =
        CheckBloc<ChangePostcodeUseCase>(usecase: ChangePostcodeUseCase());
    _passwordBloc =
        CheckBloc<ChangePasswordUseCase>(usecase: ChangePasswordUseCase());
    _readyBloc = ToggleBloc();
    _postBloc = PostBloc<SendUseCase>(
        usecase: SendUseCase(
      authRepository: MockAuthRepository(),
      tokenRepository: MockTokenRepository(datasource: MockTokenDatasource()),
      data: _data,
    ));
    _postcodeController = TextEditingController();
    _calendarController = TextEditingController();
    _showCalendar = false;
  }

  @override
  void dispose() {
    _dataBloc.close();
    _firstBloc.close();
    _lastBloc.close();
    _emailBloc.close();
    _birthBloc.close();
    _postcodeBloc.close();
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
          cubit: _firstBloc,
          listener: (BuildContext context, CheckState checkState) {
            if (checkState is ChangedCheckState)
              _dataBloc.add(ChangeDataEvent(
                  key: WORD.first,
                  value: checkState.result.hasError()
                      ? null
                      : checkState.result.value));
          },
        ),
        BlocListener<CheckBloc, CheckState>(
          cubit: _lastBloc,
          listener: (BuildContext context, CheckState checkState) {
            if (checkState is ChangedCheckState)
              _dataBloc.add(ChangeDataEvent(
                  key: WORD.last,
                  value: checkState.result.hasError()
                      ? null
                      : checkState.result.value));
          },
        ),
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
          cubit: _birthBloc,
          listener: (BuildContext context, CheckState checkState) {
            if (checkState is ChangedCheckState)
              _dataBloc.add(ChangeDataEvent(
                  key: WORD.birth,
                  value: checkState.result.hasError()
                      ? null
                      : checkState.result.value));
          },
        ),
        BlocListener<CheckBloc, CheckState>(
          cubit: _postcodeBloc,
          listener: (BuildContext context, CheckState checkState) {
            if (checkState is ChangedCheckState)
              _dataBloc.add(ChangeDataEvent(
                  key: WORD.postcode,
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
              Navigator.of(context).pushNamedAndRemoveUntil(
                  VerifyPage.routeName, (Route<dynamic> route) => false);
            } else if (postState is FailurePostState) {
              // _readyBloc.add(EnableReadyEvent());
              Navigator.of(context).pushNamed(DenyPage.routeName);
            }
          },
        ),
      ],
      child: _safeAreaWidget(context),
    );
  }

  Widget _safeAreaWidget(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            _listWidget(context),
            ReturnBar(title: 'Role'),
            _calendarWidget(),
          ],
        ),
      ),
    );
  }

  StatelessWidget _calendarWidget() {
    return _showCalendar
        ? CupertinoCalendarWindow(
            initialDateTime:
                DateTimeService.transformDate(_calendarController.text),
            onOpenSpaceClick: () {
              setState(() {
                _showCalendar = false;
              });
            },
            onSelectDate: (dt) {
              String formattedDate = DateFormat('dd/MM/yyyy').format(dt);
              _calendarController.text = formattedDate;
              _birthBloc.add(ChangeCheckEvent(formattedDate));
            },
          )
        : Container();
  }

  ListView _listWidget(BuildContext context) {
    return ListView(
      physics: ClampingScrollPhysics(),
      children: [
        SizedBox(height: 48.0),
        SizedBox(height: 16.0),
        Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: StepCounter(step: 1, steps: 6),
        ),
        SizedBox(height: 4.0),
        _titleWidget(),
        SizedBox(height: 16.0),
        StepProgress(step: 1, steps: 6),
        SizedBox(height: 24.0),
        _noticeWidget(),
        SizedBox(height: 16.0),
        BlocTextField(
          checkBloc: _firstBloc,
          label: 'First Name',
          title: 'First name (required)',
          action: TextInputAction.next,
        ),
        SizedBox(height: 20.0),
        BlocTextField(
          checkBloc: _lastBloc,
          label: 'Last Name',
          title: 'Last name (required)',
          action: TextInputAction.next,
        ),
        SizedBox(height: 20.0),
        BlocTextField(
          checkBloc: _emailBloc,
          label: 'Email',
          title: 'Email (required)',
          comment: 'Email will be hidden for public view',
          inputType: TextInputType.emailAddress,
          action: TextInputAction.next,
        ),
        SizedBox(height: 20.0),
        BlocTextField(
          checkBloc: _birthBloc,
          label: 'Date of birth',
          title: 'Date of birth (required)',
          comment: 'Only age will be shown for public view.',
          hint: 'DD/MM/YYYY',
          type: TextFieldType.calendar,
          inputType: TextInputType.datetime,
          action: TextInputAction.next,
          controller: _calendarController,
          onSuffixClick: () {
            setState(() {
              _showCalendar = true;
            });
          },
        ),
        SizedBox(height: 20.0),
        BlocTextField(
          checkBloc: _postcodeBloc,
          label: 'Postcode',
          title: 'Postcode (required)',
          comment: 'Only City & Country will be shown for public view.',
          inputType: TextInputType.number,
          action: TextInputAction.next,
          controller: _postcodeController,
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) {
                  return PostPage(
                    initialValue: _postcodeController.text,
                    onExit: (value) {
                      _postcodeController.text = value;
                      _postcodeBloc.add(ChangeCheckEvent(value));
                    },
                  );
                },
              ),
            );
          },
        ),
        SizedBox(height: 20.0),
        BlocTextField(
          checkBloc: _passwordBloc,
          label: 'Password',
          title: 'Password (required)',
          type: TextFieldType.secret,
          inputType: TextInputType.visiblePassword,
        ),
        SizedBox(height: 28.0),
        _agreeWidget(),
        SizedBox(height: 4.0),
        _termsWidget(),
        SizedBox(height: 16.0),
        BlocButton(
          toggleBloc: _readyBloc,
          label: 'Next',
          onClick: () {
            _readyBloc.add(TurnOffToggleEvent());
            _postBloc.add(SendPostEvent());
          },
        ),
        SizedBox(height: 28.0),
        _alreadyWidget(),
        SizedBox(height: 4.0),
        _signinButton(context),
        SizedBox(height: 24.0),
      ],
    );
  }

  Widget _titleWidget() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      child: Text(
        'Main info. Young person.',
        style: STYLE.b_24_700.copyWith(color: COLOR.dark),
      ),
    );
  }

  Padding _noticeWidget() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      child: NoteCard(
          content:
              'We manually approve each account. Please fill all the fields carefully and use real name'),
    );
  }

  Container _agreeWidget() {
    return Container(
        child: Center(
            child: Text(
      'By clicking on this button you agree to the ',
      style: STYLE.r_12_400,
    )));
  }

  Container _termsWidget() {
    return Container(
      child: Center(
        child: SurfaceButton(
          label: 'Terms and Conditions',
          textStyle: STYLE.b_12_700.copyWith(color: COLOR.blue),
          onClick: () {
            Navigator.of(context).pushNamed(TermsPage.routeName);
          },
        ),
      ),
    );
  }

  Container _alreadyWidget() {
    return Container(
        child: Center(
            child: Text(
      'Already have an account?',
      style: STYLE.r_12_400,
    )));
  }

  Container _signinButton(BuildContext context) {
    return Container(
      child: Center(
        child: SurfaceButton(
          label: 'SIGN IN',
          textStyle: STYLE.b_14_700.copyWith(color: COLOR.blue),
          onClick: () {
            Navigator.of(context).pushReplacementNamed(SignInPage.routeName);
          },
        ),
      ),
    );
  }
}
