import 'package:bruno/bruno.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stuff/common/values/colors.dart';
import 'package:flutter_stuff/common/widgets/app_bar.dart';
import 'package:flutter_stuff/common/widgets/load_image.dart';
import 'package:flutter_stuff/pages/home/recommend.dart';
import 'package:flutter_stuff/pages/selectcity/index.dart';
import 'package:velocity_x/velocity_x.dart';

import 'follow.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;
  // tabs切换
  PageController _pageController = PageController(initialPage: 1);

  @override
  initState() {
    super.initState();
    _tabController = TabController(
      initialIndex: 1,
      length: 3,
      vsync: this,
    );
  }

  _buildAppBar() {
    return MyAppBar(
      backgroundColor: Colors.white,
      elevation: 0.0,
      leadingWidth: 100,
      leading: Container(
        padding: EdgeInsets.only(left: 16),
        child: GestureDetector(
          onTap: () {
            // go to select city page
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return SelectCityPage();
            }));
          },
          child: Row(children: [
            "北京".text.black.make(),
            Icon(
              Icons.arrow_drop_down,
              color: Colors.black,
            ),
          ]),
        ),
      ),
      title: Container(
        width: 220,
        child: TabBar(
          padding: EdgeInsets.zero,
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
            fontSize: 20,
            fontWeight: FontWeight.w800,
          ),
          tabs: <Widget>[
            Tab(text: '关注'),
            Tab(text: '推荐'),
            Tab(text: '附近'),
          ],
          indicator: CustomWidthUnderlineTabIndicator(
            width: 20,
            borderSide: BorderSide(
              width: 3,
              color: AppColors.app_main,
            ),
          ),
        ),
      ),
      actions: [
        LoadAssetImage(
          'icon-search',
          width: 20,
          height: 20,
        ),
      ],
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
      physics: BouncingScrollPhysics(),
      children: [FollowPage(), RecommendPage(), Container()],
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
