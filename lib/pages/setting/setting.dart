import 'package:flutter/material.dart';
import 'package:flutter_stuff/common/utils/app_cache.dart';
import 'package:flutter_stuff/common/utils/device.dart';
import 'package:flutter_stuff/common/widgets/click_item.dart';

import '../../common/res/gaps.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  void initState() {
    super.initState();

    initCache();
  }

  // 缓存大小
  String? _cacheSize = '';

  Future<void> initCache() async {
    /// 获取缓存大小
    int size = await AppCache.total();
    String sizeStr = AppCache.renderSize(size);
    setState(() {
      _cacheSize = sizeStr;
    });
  }

  Widget _buildMainView() {
    return Column(
      children: <Widget>[
        Gaps.vGap5,
        ClickItem(
          title: '账号管理',
        ),
        if (Device.isMobile)
          ClickItem(
            title: '清除缓存',
            content: _cacheSize != null && _cacheSize != '0.00B'
                ? '$_cacheSize'
                : '',
            onTap: () {},
          ),
        ClickItem(title: '夜间模式'),
        ClickItem(
          title: '多语言',
          onTap: () {},
        ),
        if (Device.isMobile) ClickItem(title: '检查更新'),
        ClickItem(title: '关于我们'),
        Gaps.vGap15,
        ClickItem(title: '退出登录')
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('设置'),
        ),
        body: _buildMainView());
  }
}
