import 'package:bruno/bruno.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stuff/common/widgets/app_bar.dart';

class SelectCityPage extends StatefulWidget {
  const SelectCityPage({super.key});

  @override
  State<SelectCityPage> createState() => _SelectCityPageState();
}

class _SelectCityPageState extends State<SelectCityPage> {
  Widget _buildMainView() {
    return BrnSingleSelectCityPage(
      hotCityList: [],
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildMainView();
  }
}
