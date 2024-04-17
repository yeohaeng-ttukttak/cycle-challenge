import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:yeohaeng_ttukttak/data/repositories/member_repository.dart';
import 'package:yeohaeng_ttukttak/presentation/auth/auth_event.dart';
import 'package:yeohaeng_ttukttak/presentation/auth/auth_ui_event.dart';
import 'package:yeohaeng_ttukttak/presentation/auth/local_sign_in_ui_event.dart';
import 'package:yeohaeng_ttukttak/presentation/auth/local_sign_up_ui_event.dart';
import 'package:yeohaeng_ttukttak/presentation/auth/states/local_sign_in_state.dart';
import 'package:yeohaeng_ttukttak/presentation/auth/states/local_sign_up_state.dart';

class AuthViewModel with ChangeNotifier {
  final MemberRepository repository;

  AuthViewModel(this.repository);

  final StreamController<AuthUIEvent> _eventController =
      StreamController.broadcast();

  final StreamController<LocalSignUpUIEvent> _signUpEventController =
      StreamController.broadcast();

  final StreamController<LocalSignInUIEvent> _signInEventController =
      StreamController.broadcast();

  Stream<AuthUIEvent> get stream => _eventController.stream;
  Stream<LocalSignUpUIEvent> get signUpStream => _signUpEventController.stream;
  Stream<LocalSignInUIEvent> get signInStream => _signInEventController.stream;

  LocalSignInState _signInState = LocalSignInState(errorMessages: []);
  LocalSignInState get signInState => _signInState;

  LocalSignUpState _signUpState = LocalSignUpState(errorMessages: []);
  LocalSignUpState get signUpState => _signUpState;

  void onEvent(AuthEvent event) {
    event.when(signUp: _onSignUp, signIn: _onSignIn);
  }

  void _onSignUp(String email, String password, String repeatPassword,
      String nickname) async {
    _signUpEventController.add(const LocalSignUpUIEvent.loading(true));
    final result = await repository.signUp(email, password, nickname);
    _signUpEventController.add(const LocalSignUpUIEvent.loading(false));

    _signUpState = _signUpState.copyWith(errorMessages: []);

    result.when(
        success: (member) => _signUpEventController
            .add(LocalSignUpUIEvent.success(member.nickname)),
        error: (errors) {
          final List<String> errorMessages = [];

          errors.forEach((error) {
            String? target = error.target;

            if (target == null) {
              errorMessages.add(error.message);
              return;
            }

            _signUpEventController
                .add(LocalSignUpUIEvent.showInputError(target, error.message));
          });

          if (errorMessages.isEmpty) return;
          _signUpState = _signUpState.copyWith(errorMessages: errorMessages);
          notifyListeners();
        },
        unhandledError: (message) => {
              _signUpState = _signUpState.copyWith(errorMessages: [message])
            });
  }

  void _onSignIn(String email, String password) async {
    _signInEventController.add(const LocalSignInUIEvent.loading(true));
    final result = await repository.signIn(email, password);
    _signInEventController.add(const LocalSignInUIEvent.loading(false));

    _signInState = _signInState.copyWith(errorMessages: []);

    result.when(success: (_) {
      _signInEventController.add(const LocalSignInUIEvent.success());
    }, error: (errors) {
      final errorMessages = errors.map((e) => e.message).toList();
      _signInState = _signInState.copyWith(errorMessages: errorMessages);
      notifyListeners();
    }, unhandledError: (message) {
      _signInState = _signInState.copyWith(errorMessages: [message]);
      notifyListeners();
    });
  }
}