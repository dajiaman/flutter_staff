import 'package:flutter/material.dart';
import 'package:flutter_stuff/common/widgets/app_bar.dart';

class CommunityCreatePage extends StatefulWidget {
  const CommunityCreatePage({super.key});

  @override
  State<CommunityCreatePage> createState() => _CommunityCreatePageState();
}

class _CommunityCreatePageState extends State<CommunityCreatePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: "创建社区"),
    );
  }
}
