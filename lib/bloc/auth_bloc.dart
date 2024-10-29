import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<AuthLoginRequest>((event, emit)  async{
      try {
        final email = event.email;
        final password = event.password;

        if (password.length < 6) {
          return emit(
            AuthFailure(failure: 'Password cannot be less than 6 character'),
          );
        }

        await Future.delayed(Duration(seconds: 2), () {
          return emit(AuthSuccess(uid: '$email- $password'));
        },);
      } catch (e) {
        return emit(AuthFailure(failure: e.toString()));
      }
    });
  }
}
