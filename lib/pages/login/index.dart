import 'package:flutter/material.dart';
import 'package:flutter_stuff/color_schemes.g.dart';
import 'package:flutter_stuff/pages/login/widgets/text_field.dart';

import '../../common/res/gaps.dart';
import '../../common/style/text.dart';
import '../../common/utils/change_notifier_manager.dart';
import '../../common/widgets/my_button.dart';
import '../../generated/l10n.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with ChangeNotifierMixin<LoginPage> {
  TextEditingController _usernameEditController = TextEditingController();
  TextEditingController _passwordEditController = TextEditingController();
  final FocusNode _nodeText1 = FocusNode();
  final FocusNode _nodeText2 = FocusNode();

  // 登录按钮是否可点击
  bool _clickable = false;

  @override
  Map<ChangeNotifier, List<VoidCallback>?>? changeNotifier() {
    final List<VoidCallback> callbacks = <VoidCallback>[_verify];
    return <ChangeNotifier, List<VoidCallback>?>{
      _usernameEditController: callbacks,
      _passwordEditController: callbacks,
      _nodeText1: null,
      _nodeText2: null,
    };
  }

  void _verify() {
    final String name = _usernameEditController.text;
    final String password = _passwordEditController.text;
    bool clickable = true;

    // 计算登录按钮是否可点击
    if (name.isEmpty || name.length < 11) {
      clickable = false;
    }
    if (password.isEmpty || password.length < 6) {
      clickable = false;
    }

    /// 状态不一样再刷新，避免不必要的setState
    if (clickable != _clickable) {
      setState(() {
        _clickable = clickable;
      });
    }
  }

  // 登录逻辑
  void _login() {}

  // Widget _buildContryCode() {
  //   return SizedBox(
  //     height: 1,
  //     child: Padding(
  //       padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
  //       child: Row(
  //         mainAxisSize: MainAxisSize.min,
  //         mainAxisAlignment: MainAxisAlignment.center,
  //         crossAxisAlignment: CrossAxisAlignment.center,
  //         children: [
  //           FittedBox(
  //             child: Text(
  //               '+86',
  //               style: TextStyle(
  //                 color: _color,
  //                 fontSize: 16,
  //                 fontWeight: FontWeight.w400,
  //               ),
  //             ),
  //           ),
  //           Icon(
  //             Icons.arrow_drop_down_outlined,
  //             color: _color,
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  List<Widget> get _buildBody => <Widget>[
        Text(
          S.of(context).passwordLogin,
          style: TextStyles.textBold26,
        ),
        Gaps.vGap16,
        MyTextField(
          key: const Key('phone'),
          focusNode: _nodeText1,
          controller: _usernameEditController,
          hintText: S.of(context).inputUsernameHint,
        ),
        Gaps.vGap8,
        MyTextField(
          key: const Key('password'),
          focusNode: _nodeText2,
          keyName: 'password',
          isInputPwd: true,
          controller: _passwordEditController,
          keyboardType: TextInputType.visiblePassword,
          hintText: S.of(context).inputPasswordHint,
        ),
        Gaps.vGap24,
        MyButton(
          key: const Key('login'),
          onPressed: _clickable ? _login : null,
          text: S.of(context).login,
        ),
        Container(
          height: 40.0,
          alignment: Alignment.centerRight,
          child: GestureDetector(
            child: Text(
              S.of(context).forgotPasswordLink,
              key: const Key('forgotPassword'),
              style: Theme.of(context).textTheme.titleSmall,
            ),
            onTap: () {
              // go to reset password
            },
          ),
        ),
        Container(
          alignment: Alignment.center,
          child: GestureDetector(
            child: Text(
              S.of(context).noAccountRegisterLink,
              key: const Key('noAccountRegister'),
              style: TextStyle(color: Theme.of(context).primaryColor),
            ),
            onTap: () {},
            // go to register page
          ),
        ),
      ];

  Widget _buildMain() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: SingleChildScrollView(
        padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: _buildBody,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text('登录'),
          // backgroundColor: Colors.transparent,
          elevation: 0.0,
        ),
        body: _buildMain());
  }
}
