import 'package:flutter/material.dart';
import 'package:flutter_stuff/color_schemes.g.dart';
import 'package:flutter_stuff/pages/login/index.dart';
import 'package:flutter_stuff/pages/login/widgets/text_field.dart';

import '../../common/res/gaps.dart';
import '../../common/style/text.dart';
import '../../common/widgets/my_button.dart';
import '../../generated/l10n.dart';

class SmsLoginPage extends StatefulWidget {
  final String title;
  const SmsLoginPage({super.key, required this.title});

  @override
  State<SmsLoginPage> createState() => _SmsLoginPageState();
}

class _SmsLoginPageState extends State<SmsLoginPage> {
  TextEditingController _usernameEditController = TextEditingController();
  TextEditingController _passwordEditController = TextEditingController();
  // 登录按钮是否可点击
  bool _clickable = false;

  final String username = '';
  final String password = '';

  // 登录逻辑
  void _login() {}

  List<Widget> get _buildBody => <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              S.of(context).verificationCodeLogin,
              style: TextStyles.textBold26,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return LoginPage();
                }));
              },
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    S.of(context).passwordLogin,
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    size: 20,
                    color: Colors.black,
                  )
                ],
              ),
            )
          ],
        ),
        Gaps.vGap16,
        MyTextField(
          key: const Key('phone'),
          controller: _usernameEditController,
          hintText: S.of(context).inputPhoneHint,
        ),
        Gaps.vGap8,
        MyTextField(
          key: const Key('vcode'),
          keyName: 'vcode',
          isInputPwd: false,
          controller: _passwordEditController,
          keyboardType: TextInputType.visiblePassword,
          hintText: S.of(context).inputVerificationCodeHint,
          getVCode: () {
            return Future<bool>.value(true);
          },
        ),
        Gaps.vGap24,
        MyButton(
          key: const Key('login'),
          onPressed: _clickable ? _login : null,
          text: S.of(context).login,
        ),
        Gaps.vGap16,
      ];

  Widget _buildMain() {
    return SingleChildScrollView(
      padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _buildBody,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        // extendBodyBehindAppBar: true,
        appBar: AppBar(
          title: const Text('手机登录'),
          // backgroundColor: Colors.transparent,
          elevation: 0.0,
        ),
        body: _buildMain());
  }
}
