import 'package:bloc/bloc.dart';
import 'package:coderz1/bloc/services/auth_api_service.dart';
import 'package:coderz1/bloc/auth/auth_event.dart';
import 'package:coderz1/bloc/auth/auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthApiService _authApiService = AuthApiService();

  AuthBloc() : super(AuthInitial()) {
    // ====================== تسجيل الدخول ======================
    on<LoginEvent>((event, emit) async {
      // تحقق من الحقول الفارغة
      if (event.email.isEmpty || event.password.isEmpty) {
        emit(
          const AuthFailure(
            error: 'البريد وكلمة المرور لا يمكن أن تكون فارغة.',
          ),
        );
        return;
      }

      // تحقق من صيغة البريد الإلكتروني
      if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(event.email)) {
        emit(const AuthFailure(error: 'صيغة البريد الإلكتروني غير صحيحة.'));
        return;
      }

      emit(AuthLoading());

      try {
        final result = await _authApiService.login(event.email, event.password);

        final token = result['token'] ?? '';
        final role = result['role'] ?? 'User';

        if (token.isEmpty) {
          emit(const AuthFailure(error: 'استجابة غير صالحة من السيرفر.'));
          return;
        }
        emit(AuthSuccess(token: token, role: role));
      } catch (e) {
        emit(AuthFailure(error: 'حدث خطأ: ${e.toString()}'));
      }
    });

    // ====================== تسجيل حساب جديد ======================
    on<RegisterEvent>((event, emit) async {
      // تحقق من الحقول الفارغة
      if (event.email.isEmpty || event.password.isEmpty || event.role.isEmpty) {
        emit(
          const AuthFailure(
            error: 'البريد وكلمة المرور والدور لا يمكن أن تكون فارغة.',
          ),
        );
        return;
      }

      // تحقق من صيغة البريد الإلكتروني
      if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(event.email)) {
        emit(const AuthFailure(error: 'صيغة البريد الإلكتروني غير صحيحة.'));
        return;
      }

      emit(AuthLoading());

      try {
        final result = await _authApiService.register(
          event.email,
          event.password,
          event.role,
        );

        final message = result['message'] ?? 'Registration successful';
        final role = result['role'] ?? 'User';

        emit(AuthRegistrationSuccess(message: message, role: role));
      } catch (e) {
        emit(AuthFailure(error: 'حدث خطأ: ${e.toString()}'));
      }
    });
  }
}
