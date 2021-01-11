import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:vizable/flows/auth/token/core/bloc/access_bloc.dart';
import 'package:vizable/flows/auth/token/data/secure_token_repository.dart';

class SplashPage extends StatelessWidget {
  static const routeName = '/splash';

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AccessBloc>(
      create: (context) =>
          AccessBloc(repository: SecureTokenRepository(FlutterSecureStorage()))
            ..add(GetAccessEvent()),
      child: _blocListener(),
    );
  }

  BlocListener<AccessBloc, AccessState> _blocListener() {
    return BlocListener<AccessBloc, AccessState>(
      listener: (BuildContext context, AccessState accessState) {
        String _path;
        if (accessState is AccessibleAccessState)
          _path = 'main';
        else if (accessState is DeniedAccessState)
          _path = 'intro'; //'welcome';
        else
          _path = '';
        if (_path.isNotEmpty)
          Navigator.of(context).pushNamedAndRemoveUntil(
              '/$_path', (Route<dynamic> route) => false);
      },
      child: _scaffoldWidget(),
    );
  }

  Widget _scaffoldWidget() {
    return Scaffold(
      body: Center(
        child: BlocBuilder<AccessBloc, AccessState>(
            builder: (BuildContext context, AccessState accessState) {
          if (accessState is InitialAccessState)
            return Text('Initial...');
          else if (accessState is GettingAccessState)
            return Text('Waiting...');
          else if (accessState is FailureAccessState)
            return Text('Failure');
          else
            return Text('Unexpected error');
        }),
      ),
    );
  }
}
