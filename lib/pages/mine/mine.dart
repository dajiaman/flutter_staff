import 'dart:ui';

import 'package:bruno/bruno.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stuff/common/res/gaps.dart';
import 'package:flutter_stuff/common/widgets/click_item.dart';
import 'package:flutter_stuff/pages/setting/setting.dart';
import 'package:flutter_swipe/flutter_swipe.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../common/widgets/load_image.dart';

class MinePage extends StatefulWidget {
  const MinePage({super.key});

  @override
  State<MinePage> createState() => _MinePageState();
}

class _MinePageState extends State<MinePage>
    with SingleTickerProviderStateMixin {
  // 标题
  String _title = '';
  TabController? _tabController;
  List _tabList = ['帖子', '社区', "赞过", "足迹"];
  List<int?> _nums = List.filled(4, null);
  List<Widget> _tabs = [];

  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    setState(() {
      _nums[0] = 111;
    });

    _tabController = TabController(
      initialIndex: 1,
      length: 4,
      vsync: this,
    );

    _tabList.forEachIndexed((index, item) {
      var str = "${_nums[index] != null ? (_nums[index]) : ''}";
      _tabs.add(Tab(
        text: "$item $str",
      ));
    });

    _scrollController.addListener(() {
      if (_scrollController.position.pixels > 40) {
        setState(() {
          _title = '变化效果';
        });
      } else {
        setState(() {
          _title = '';
        });
      }
    });
  }

  // 构建用户信息块
  Widget _buildProfileBoxView() {
    return Container(
      height: 200,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
            'assets/images/mine/bg1.png',
          ),
          fit: BoxFit.contain,
        ),
      ),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 10),
        child: Container(
          padding: EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 0.0),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.white.withOpacity(0.6),
                Colors.white.withOpacity(0.6),
                Colors.white.withOpacity(0.7),
                Colors.white,
              ],
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: LoadAssetImage('mine/avatar1', width: 60, height: 60),
              ),
              Gaps.hGap16,
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      '木木子'.text.size(20).make(),
                      LoadAssetImage('mine/badge2'),
                      LoadAssetImage('mine/badge'),
                    ],
                  ),
                  "美国帝国理工大学".text.size(10).hexColor('#8D93A6').make(),
                  Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
                    "登船200天"
                        .text
                        .hexColor('#5F2AFF')
                        .size(10)
                        .make()
                        .centered(),
                    "里程200海里"
                        .text
                        .hexColor('#FF8C28')
                        .size(10)
                        .make()
                        .centered(),
                  ])
                ],
              ),
              Spacer(),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  LoadAssetImage('mine/edit-icon', width: 36, height: 36),
                  Gaps.hGap10,
                  LoadAssetImage('mine/like-icon', width: 36, height: 36),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileData() {
    return VxBox(
      child: HStack(
        [
          VStack(
            [
              "145".text.size(20).bold.make(),
              "关注".text.size(12).hexColor('#B1B4C3').make(),
            ],
            crossAlignment: CrossAxisAlignment.center,
            alignment: MainAxisAlignment.center,
          ).centered(),
          VStack(
            [
              "145".text.size(20).bold.make(),
              "粉丝".text.size(12).hexColor('#B1B4C3').make(),
            ],
            crossAlignment: CrossAxisAlignment.center,
            alignment: MainAxisAlignment.center,
          ).centered(),
          VStack(
            [
              "145".text.size(20).bold.make(),
              "获赞".text.size(12).hexColor('#B1B4C3').make(),
            ],
            crossAlignment: CrossAxisAlignment.center,
            alignment: MainAxisAlignment.center,
          ).centered(),
        ],
        crossAlignment: CrossAxisAlignment.center,
        alignment: MainAxisAlignment.spaceAround,
        axisSize: MainAxisSize.max,
      ).pOnly(bottom: 17),
    ).alignCenter.white.make();
  }

  Widget _buildTabView() {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(16),
      child: TabBar(
        onTap: (int index) {
          if (!mounted) {
            return;
          }
        },
        overlayColor: MaterialStateProperty.all<Color>(Colors.transparent),
        controller: _tabController,
        unselectedLabelColor: Color(0xff8D93A6),
        unselectedLabelStyle: TextStyle(
          fontSize: 14,
        ),
        labelColor: Colors.black,
        labelStyle: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w800,
        ),
        indicator: CustomWidthUnderlineTabIndicator(
          width: 20,
          borderSide: BorderSide(
            width: 3,
            color: Color(0xff5F2AFF),
          ),
        ),
        tabs: _tabs,
      ),
    );
  }

  Widget _buildBody() {
    return Column(
      children: [
        _buildProfileBoxView(),
        _buildProfileData(),
        _buildTabView(),
        Gaps.vGap16,
        Gaps.vGap50,
        Gaps.vGap50,
        Gaps.vGap50,
      ],
    );
  }

  Widget _buildMainView() {
    return CustomScrollView(
      controller: _scrollController,
      slivers: [
        SliverToBoxAdapter(
          child: _buildBody(),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          title: Text('$_title' ?? ''),
          backgroundColor: Colors.transparent,
          elevation: 0.0,
        ),
        body: _buildMainView());
  }
}
