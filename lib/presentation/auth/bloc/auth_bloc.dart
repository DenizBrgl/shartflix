import 'package:bloc/bloc.dart';
import 'package:shartflix/core/error/failure_message_mapper.dart';
import 'package:shartflix/core/error/failures.dart';
import 'package:shartflix/domain/usecases/auth/register_usecase.dart';
import 'package:shartflix/presentation/auth/bloc/auth_event.dart';
import 'package:shartflix/presentation/auth/bloc/auth_state.dart';
import '../../../domain/usecases/auth/login_usecase.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUseCase loginUseCase;
  final RegisterUseCase registerUseCase;

  AuthBloc({required this.loginUseCase, required this.registerUseCase})
    : super(AuthInitial()) {
    on<LoginRequested>(_onLoginRequested);
    on<RegisterRequested>(_onRegisterRequested);
  }

  Future<void> _onLoginRequested(
    LoginRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());

    final result = await loginUseCase(
      LoginParams(email: event.email, password: event.password),
    );

    result.fold(
      (failure) => emit(AuthFailure(FailureMessageMapper.map(failure))),
      (user) => emit(AuthSuccess(user)),
    );
  }

  Future<void> _onRegisterRequested(
    RegisterRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());

    final result = await registerUseCase(
      RegisterParams(
        name: event.name,
        email: event.email,
        password: event.password,
      ),
    );
    result.fold((failure) {
      String userMessage = _mapFailureToMessage(failure);
      emit(AuthFailure(userMessage));
    }, (user) => emit(AuthSuccess(user)));
  }

  String _mapFailureToMessage(Failure failure) {
    if (failure is ConnectionFailure) return failure.message;
    return "Bir şeyler yanlış gitti. Lütfen tekrar deneyin.";
  }
}
