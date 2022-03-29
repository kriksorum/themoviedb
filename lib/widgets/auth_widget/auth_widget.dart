import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:themoviedb/theme/app_button_style.dart';
import 'package:themoviedb/widgets/auth_widget/auth_model.dart';

class AuthWidget extends StatelessWidget {
  const AuthWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Войдите в свою учетную запись'),
      ),
      body: ListView(
        children: [
          _HeaderWidget(),
        ],
      ),
    );
  }
}

class _HeaderWidget extends StatelessWidget {
  const _HeaderWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textStyle = const TextStyle(
      fontSize: 16,
      color: Colors.black,
    );
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 25),
          _FormWidget(),
          SizedBox(height: 25),
          Text(
            'Чтобы пользоваться правкой и возможностями рейтинга TMDB, а также получить персональные рекомендации, необходимо войти в свою учётную запись. Если у вас нет учётной записи,'
            ' её регистрация является бесплатной и простой. Нажмите здесь, чтобы начать.',
            style: textStyle,
          ),
          SizedBox(height: 5),
          TextButton(
            onPressed: () {},
            child: Text('Регистрация'),
            style: AppButtonStyle.linkButton,
          ),
          SizedBox(height: 5),
          Text(
            'Если Вы зарегистрировались, но не получили письмо для подтверждения, нажмите здесь, чтобы отправить письмо повторно.',
            style: textStyle,
          ),
          TextButton(
              onPressed: () {},
              child: Text('Подтверждение email'),
              style: AppButtonStyle.linkButton),
        ],
      ),
    );
  }
}

class _FormWidget extends StatelessWidget {
  const _FormWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.read<AuthViewModel>();

    final textStyle = const TextStyle(
      fontSize: 16,
      color: Color(0xFF212529),
    );

    final textFieldDecorator = const InputDecoration(
      border: OutlineInputBorder(),
      contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      isCollapsed: true, //
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _ErrorMessageWidget(),
        Text(
          'Имя пользователя',
          style: textStyle,
        ),
        SizedBox(height: 5),
        TextField(
          decoration: textFieldDecorator,
          controller: model.loginTextController,
        ),
        SizedBox(height: 20),
        Text(
          'Пароль',
          style: textStyle,
        ),
        TextField(
          controller: model.passwordTextController,
          decoration: textFieldDecorator,
          obscureText: true,
        ),
        SizedBox(height: 20),
        Row(
          children: [
            _AuthButtonWidget(),
            SizedBox(width: 30),
            TextButton(
                onPressed: () {},
                style: AppButtonStyle.linkButton,
                child: Text('Сбросить пароль')),
          ],
        )
      ],
    );
  }
}

class _AuthButtonWidget extends StatelessWidget {
  const _AuthButtonWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.watch<AuthViewModel>();
    final color = const Color(0xFF01b4e4);
    final onPressed =
        model.canStartAuth ? () => model.auth(context) : null;
    final child = model.isAuthProgress
        ? SizedBox(width: 15, height: 15, child: CircularProgressIndicator(strokeWidth: 2)) 
        : const Text('Войти');
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(color),
        foregroundColor: MaterialStateProperty.all(Colors.white),
        textStyle: MaterialStateProperty.all(
          TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
        padding: MaterialStateProperty.all(
            EdgeInsets.symmetric(horizontal: 15, vertical: 8)),
      ),
      child: child,
    );
  }
}

class _ErrorMessageWidget extends StatelessWidget {
  const _ErrorMessageWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final errorMessage = context.select((AuthViewModel m) => m.errorMassge);

    if (errorMessage == null) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Text(
        errorMessage,
        style: TextStyle(
          fontSize: 17,
          color: Colors.red,
        ),
      ),
    );
  }
}
