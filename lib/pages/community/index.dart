import 'package:bruno/bruno.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stuff/common/widgets/app_bar.dart';
import 'package:flutter_stuff/common/widgets/my_button.dart';
import 'package:flutter_stuff/pages/community/create.dart';
import 'package:flutter_stuff/pages/community/my.dart';
import 'package:flutter_stuff/pages/community/plaza.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../common/values/colors.dart';

class CommunityPage extends StatefulWidget {
  const CommunityPage({super.key});

  @override
  State<CommunityPage> createState() => _CommunityPageState();
}

class _CommunityPageState extends State<CommunityPage>
    with SingleTickerProviderStateMixin {
  List _tabList = ['我的社区', '广场'];
  List<Widget> _tabs = [];

  PageController _pageController = PageController();
  TabController? _tabController;

  @override
  void initState() {
    super.initState();
    _tabController =
        TabController(initialIndex: 0, length: _tabList.length, vsync: this);
    List<Widget> tabs = [];
    for (var item in _tabList) {
      _tabs.add(Tab(text: item));
    }
  }

  _buildAppBar() {
    return MyAppBar(
      automaticallyImplyLeading: false,
      centerTitle: false,
      actions: [
        Container(
          padding: EdgeInsets.symmetric(vertical: 5),
          child: GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return CommunityCreatePage();
              }));
            },
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: Color(0xffF1F3F6), // 朝上; 其他的全部透明transparent或者不设置
                  width: 2,
                  style: BorderStyle.solid,
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(Icons.edit, color: Colors.black, size: 15),
                  "创建社区".text.black.size(15).make(),
                ],
              ),
            ),
          ),
        ),
      ],
      title: Container(
        width: 250,
        child: TabBar(
          onTap: (int index) {
            if (!mounted) {
              return;
            }
            _pageController.jumpToPage(index);
          },
          overlayColor: MaterialStateProperty.all<Color>(Colors.transparent),
          controller: _tabController,
          unselectedLabelColor: (AppColors.unselected_item_color),
          unselectedLabelStyle: TextStyle(
            fontSize: 16,
          ),
          labelColor: Colors.black,
          labelStyle: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w800,
          ),
          tabs: _tabs,
          indicator: CustomWidthUnderlineTabIndicator(
            borderSide: BorderSide(
              width: 3,
              color: AppColors.app_main,
            ),
          ),
        ),
      ),
    );
  }

  _onPageChange(int index) {
    _tabController?.animateTo(index);
  }

  @override
  void dispose() {
    _tabController?.dispose();
    _pageController.dispose();
    super.dispose();
  }

  Widget _buildMainView() {
    return PageView(
      onPageChanged: _onPageChange,
      controller: _pageController,
      physics: NeverScrollableScrollPhysics(),
      children: [MyCommunityPage(), PlazaPage()],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildMainView(),
    );
  }
}
