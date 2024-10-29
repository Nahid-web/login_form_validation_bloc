import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<AuthLoginRequest>(_onAuthLoginRequested);

    on<AuthLogOutRequest>(_onAuthLogoutRequested);
  }

  @override
  void onChange(Change<AuthState> change) {
    // TODO: implement onChange
    super.onChange(change);
    print('AuthBloc - change - $change');
  }

  @override
  void onTransition(Transition<AuthEvent, AuthState> transition) {
    // TODO: implement onTransition
    super.onTransition(transition);
    print('AuthBloc - Transition - $transition');
  }

  void _onAuthLoginRequested(
    AuthLoginRequest event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      final email = event.email;
      final password = event.password;

      if (password.length < 6) {
        return emit(
          AuthFailure(failure: 'Password cannot be less than 6 character'),
        );
      }

      await Future.delayed(
        const Duration(seconds: 1),
        () {
          return emit(AuthSuccess(uid: '$email- $password'));
        },
      );
    } catch (e) {
      return emit(AuthFailure(failure: e.toString()));
    }
  }

  void _onAuthLogoutRequested(
    AuthLogOutRequest event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());

    try {
      await Future.delayed(const Duration(seconds: 1), () {
        return emit(AuthInitial());
      });
    } catch (e) {
      return emit(AuthFailure(failure: e.toString()));
    }
  }
}
