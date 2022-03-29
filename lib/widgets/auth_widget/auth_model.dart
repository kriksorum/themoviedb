import 'package:flutter/material.dart';
import 'package:themoviedb/domain/api_client/api_client_exception.dart';
import 'package:themoviedb/domain/services/auth_service.dart';
import 'package:themoviedb/ui/navigation/main_navigation.dart';

class AuthViewModel  extends ChangeNotifier {
  final _authService = AuthService();

  final loginTextController = TextEditingController();
  final passwordTextController = TextEditingController();

  String? _errorMessage;
  String? get errorMassge => _errorMessage;

  bool _isAuthProgress = false;
  bool get canStartAuth => !_isAuthProgress;
  bool get isAuthProgress => _isAuthProgress;

  bool _isValid(String login, String password){
    return login.isNotEmpty || password.isNotEmpty;
  }

  Future<String?> _login(String login, String password) async {
    try {
      await _authService.login(login, password);
    } on ApiClientException catch (e){
      switch (e.type){
        case ApiClientExceptionType.network:
          return 'Сервер недоступен. Проверьте подключение к интернету.';
        case ApiClientExceptionType.auth:
          return 'Неправильный логин или пароль!';
        case ApiClientExceptionType.other:
          return 'Произошла ошибка. Попробуйте снова';
        case ApiClientExceptionType.sessionExpired:
          return 'Произошла ошибка. Попробуйте снова';
      }
    } catch (e) {
      return 'Неизвестная ошибка повторите попытку';
    }
    return null;
  }

  void _updateState(String? errorMessage, bool isAuthProgress){
    if (_errorMessage == errorMassge && _isAuthProgress == isAuthProgress){
      return;
    }
    _errorMessage = errorMassge;
    _isAuthProgress = isAuthProgress;
    notifyListeners();
  }

  Future<void> auth(BuildContext context) async{
    final login = loginTextController.text;
    final password = passwordTextController.text;

    if (!_isValid(login, password)){
      _updateState('Заполните поля', false);
      return;
    }
    
    _updateState(null, true);

    _errorMessage = await _login(login, password);  

    if (_errorMessage == null){
      MainNavigation.resetNavigation(context);
    } else {
      _updateState(_errorMessage, false);
    }
    
  }

}


