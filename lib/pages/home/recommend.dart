import 'package:bruno/bruno.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stuff/common/widgets/load_image.dart';
import 'package:flutter_stuff/pages/home/widgets/feed_item.dart';
import 'package:flutter_stuff/pages/home/widgets/image_feed_item.dart';
import 'package:flutter_swipe/flutter_swipe.dart';

import '../../entity/feed_item.dart';

class RecommendPage extends StatefulWidget {
  const RecommendPage({super.key});

  @override
  State<RecommendPage> createState() => _RecommendPageState();
}

class _RecommendPageState extends State<RecommendPage>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;

  List _tabList = ['推荐', '生活', "学术", "求职", "直播", "热门"];
  List<Widget> _tabs = [];

  // feed文章
  List<FeedItemModel> _feedList = [];
  // 横向
  List<FeedItemModel> _hFeedList = [];

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
  void initState() {
    super.initState();
    List<Widget> tabs = [];
    for (var item in _tabList) {
      _tabs.add(Text(item));
    }

    for (var _json in _jsonData) {
      FeedItemModel model = FeedItemModel.fromJson(_json);
      _feedList.add(model);
      _hFeedList.add(model);
    }

    _tabController =
        TabController(initialIndex: 0, length: _tabList.length, vsync: this);
  }

  Widget _buildMainView() {
    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        SliverToBoxAdapter(
          child: Column(
            children: [
              _buildBanner(),
              _buildTabView(),
              _buildFeedList(),
              _buildHorizotalFeed(),
              _buildFeedList(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildHorizotalFeed() {
    return Container(
      color: Colors.white,
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.all(16),
        child: Row(
          children: [
            for (var feed in _hFeedList) ImageFeedItemWidget(feed),
          ],
        ),
      ),
    );
  }

  Widget _buildFeedList() {
    return Container(
      child: Column(
        children: [
          for (var feed in _feedList) FeedItemWidget(feed),
        ],
      ),
    );
  }

  Widget _buildBanner() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(16.0),
      child: Container(
        height: 120,
        child: Swiper(
          itemBuilder: (BuildContext context, int index) {
            return LoadAssetImage('home/banner');
          },
          itemCount: 10,
          containerHeight: 100,
        ),
      ),
    );
  }

  Widget _buildTabView() {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            child: TabBar(
              onTap: (int index) {
                if (!mounted) {
                  return;
                }
              },
              isScrollable: true,
              overlayColor:
                  MaterialStateProperty.all<Color>(Colors.transparent),
              controller: _tabController,
              unselectedLabelColor: Color(0xff8D93A6),
              unselectedLabelStyle: TextStyle(
                fontSize: 16,
              ),
              labelColor: Colors.black,
              labelStyle: TextStyle(
                fontSize: 20,
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
          ),
          // more
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: LoadAssetImage(
              'more',
              width: 20,
              height: 20,
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildMainView();
  }
}
