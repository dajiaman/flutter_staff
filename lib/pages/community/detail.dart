import 'dart:ui';

import 'package:bruno/bruno.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stuff/common/res/gaps.dart';
import 'package:flutter_stuff/common/widgets/app_bar.dart';
import 'package:flutter_stuff/common/widgets/load_image.dart';
import 'package:flutter_stuff/entity/feed_item.dart';
import 'package:flutter_stuff/pages/community/widgets/water_feed_item.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:waterfall_flow/waterfall_flow.dart';

import '../../common/values/colors.dart';
import '../../common/widgets/my_button.dart';

class CommunityDetailPage extends StatefulWidget {
  const CommunityDetailPage({super.key});

  @override
  State<CommunityDetailPage> createState() => _CommunityDetailPageState();
}

class _CommunityDetailPageState extends State<CommunityDetailPage>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;

  List<String> _titles = ['最新', '最热'];
  List<Widget> _tabs = [];

  List<FeedItemModel> _list = [];

  List<Map<String, dynamic>> _jsonData = [
    {
      "id": 1,
      "title": "本科研究生如何通过规划时间斩获大厂Offer",
      "author": "王若瑄Jimmy",
      "likes": 1444,
      "cover": "cover",
      "avatar": "",
    },
    {
      "id": 2,
      "title": "谈薪水时不要怂，3个谈判技巧轻松让你拿高薪",
      "author": "黄先生",
      "likes": 44,
      "cover": "cover2",
    },
    {
      "id": 3,
      "title": "很多人说年纪超过30岁的设计师找不到工作，很多公司都不会要，真的是这样吗",
      "author": "校园大使mary",
      "likes": 775,
      "cover": "cover3",
    },
    {
      "id": 4,
      "title": "面试时到底什么不能说？百场面试经验分享给你",
      "author": "张三😀了一下",
      "likes": 6786756765,
      "cover": "cover",
    },
    {
      "id": 5,
      "title": "本科研究生如何通过规划时间斩获大厂Offer",
      "author": "王若瑄Jimmy",
      "likes": 32423,
      "cover": "cover2",
    },
    {
      "id": 6,
      "title": "本科研究生如何通过规划时间斩获大厂Offer",
      "author": "王若瑄Jimmy",
      "likes": 566,
      "cover": "cover3",
    }
  ];

  @override
  initState() {
    super.initState();

    for (var title in _titles) {
      _tabs.add(Tab(text: title));
    }
    for (var _json in _jsonData) {
      FeedItemModel model = FeedItemModel.fromJson(_json);
      _list.add(model);
    }

    _tabController = TabController(
      length: 2,
      vsync: this,
    );
  }

  @override
  void dispose() {
    _tabController?.dispose();

    super.dispose();
  }

  // build tabbar ui
  _buildTabBar() {
    return PreferredSize(
      preferredSize: Size(0, 0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          ),
          color: Colors.white,
        ),
        child: Row(children: [
          Container(
            width: 200,
            child: TabBar(
              padding: EdgeInsets.zero,
              onTap: (int index) {
                if (!mounted) {
                  return;
                }
              },
              overlayColor:
                  MaterialStateProperty.all<Color>(Colors.transparent),
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
              tabs: _tabs,
              indicator: CustomWidthUnderlineTabIndicator(
                width: 20,
                borderSide: BorderSide(
                  width: 3,
                  color: AppColors.app_main,
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }

  Widget _buildTop() {
    return Container(
      height: 120,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
            'assets/images/community/bg.png',
          ),
          fit: BoxFit.cover,
        ),
      ),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 10),
        child: Container(
          padding: EdgeInsets.fromLTRB(15.0, 20.0, 15.0, 0.0),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.black.withOpacity(0.2),
                Colors.black.withOpacity(0.4),
                Colors.black.withOpacity(0.5),
              ],
            ),
          ),
          child: Container(
            width: MediaQuery.of(context).size.width,
            child: HStack(
              [
                LoadAssetImage(
                  'community/cover1',
                  width: 64,
                  height: 64,
                ),
                Gaps.hGap10,
                Expanded(
                  child: HStack(
                    [
                      VStack([
                        "纽约大学交友群".text.size(16).white.make(),
                        "ID:1212".text.white.make(),
                        HStack([
                          "233人".text.white.make(),
                          "美国纽约大学".text.white.make(),
                        ])
                      ]),
                      MyButton(
                        minHeight: 21,
                        minWidth: 48,
                        fontSize: 14,
                        onPressed: () {},
                        text: "+订阅",
                      )
                    ],
                    crossAlignment: CrossAxisAlignment.center,
                    alignment: MainAxisAlignment.spaceBetween,
                    axisSize: MainAxisSize.min,
                  ),
                ),
              ],
              crossAlignment: CrossAxisAlignment.center,
              alignment: MainAxisAlignment.spaceBetween,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildWaterFall() {
    return SliverWaterfallFlow.count(
      crossAxisCount: 2,
      crossAxisSpacing: 5.0,
      mainAxisSpacing: 15.0,
      children: [for (var item in _list) WaterFeedItemWidget(item)],
    );
  }

  Widget _buildContent() {
    return Container(
      padding: EdgeInsets.only(left: 16, top: 20, bottom: 0),
      color: Colors.white,
      child: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: [
          // SliverToBoxAdapter(
          //   child: Padding(
          //     padding: EdgeInsets.only(left: 16, top: 10, right: 0, bottom: 20),
          //     child: _buildWaterFall(),
          //   ),
          // ),

          _buildWaterFall()
        ],
      ),
    );
  }

  Widget _buildMainView() {
    return NestedScrollView(
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return [
          SliverAppBar(
            automaticallyImplyLeading: false,
            pinned: true,
            expandedHeight: 180.0,
            backgroundColor: Colors.white,
            flexibleSpace: FlexibleSpaceBar(
              background: _buildTop(),
            ),
            bottom: _buildTabBar(),
          )
        ];
      },
      body: _buildContent(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: MyAppBar(
        backgroundColor: Colors.transparent,
        title: '',
      ),
      body: _buildMainView(),
    );
  }
}
