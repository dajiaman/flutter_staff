import 'package:flutter/material.dart';
import 'package:flutter_stuff/pages/community/index.dart';
import 'package:flutter_stuff/pages/home/home.dart';
import 'package:flutter_stuff/pages/message/message.dart';
import 'package:flutter_stuff/pages/mine/mine.dart';

import '../../common/values/colors.dart';
import '../../common/widgets/load_image.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final PageController _pageController = PageController();
  // bottom bar 图标大小
  static const double _imageSize = 25.0;

  int _currentIndex = 0;

  // 页面列表
  List<Widget> _pageList = [];

  final List<String> _appBarTitles = ['首页', '社区', '消息', '个人'];

  List<BottomNavigationBarItem>? _list;
  // dark mode
  List<BottomNavigationBarItem>? _listDark;

  @override
  void initState() {
    super.initState();
    initData();
  }

  void initData() {
    _pageList = [
      HomePage(),
      CommunityPage(),
      MessagePage(),
      MinePage(),
    ];
  }

  List<BottomNavigationBarItem> _buildBottomNavigationBarItem() {
    if (_list == null) {
      const tabImages = [
        [
          LoadAssetImage(
            'tabbar/home_unselected',
            width: _imageSize,
          ),
          LoadAssetImage(
            'tabbar/home_selected',
            width: _imageSize,
          ),
        ],
        [
          LoadAssetImage(
            'tabbar/group_unselected',
            width: _imageSize,
          ),
          LoadAssetImage(
            'tabbar/group_selected',
            width: _imageSize,
          ),
        ],
        [
          LoadAssetImage(
            'tabbar/message_unselected',
            width: _imageSize,
          ),
          LoadAssetImage(
            'tabbar/message_selected',
            width: _imageSize,
          ),
        ],
        [
          LoadAssetImage(
            'tabbar/mine_unselected',
            width: _imageSize,
          ),
          LoadAssetImage(
            'tabbar/mine_selected',
            width: _imageSize,
          )
        ]
      ];

      // 构造
      _list = List.generate(tabImages.length, (i) {
        return BottomNavigationBarItem(
          icon: tabImages[i][0],
          activeIcon: tabImages[i][1],
          label: _appBarTitles[i],
        );
      });
    }

    if (_list != null && _list!.length == 4) {
      BottomNavigationBarItem middleIcon = BottomNavigationBarItem(
        label: '',
        activeIcon: Container(
          width: 36,
          height: 36,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: AppColors.app_main,
            borderRadius: BorderRadius.circular(100),
          ),
          child: Text(
            '+',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        icon: Container(
          width: 36,
          height: 36,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: AppColors.app_main,
            borderRadius: BorderRadius.circular(100),
          ),
          child: Text(
            '+',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      );

      _list?.insert(2, middleIcon);
    }

    return _list!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        physics: const NeverScrollableScrollPhysics(), // 禁止滑动
        controller: _pageController,
        onPageChanged: (int index) => {
          setState(() {
            _currentIndex = index;
          })
        },
        children: _pageList,
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  // bottomBar
  BottomNavigationBar _buildBottomNavigationBar() {
    return BottomNavigationBar(
      items: _buildBottomNavigationBarItem(),
      type: BottomNavigationBarType.fixed,
      elevation: 5.0,
      iconSize: 21.0,
      backgroundColor: Colors.white,
      selectedItemColor: AppColors.app_main,
      unselectedItemColor: AppColors.unselected_item_color,
      currentIndex: _currentIndex,
      onTap: (int index) {
        if (index > 2) {
          _pageController.jumpToPage(index - 1);
        } else if (index < 2) {
          _pageController.jumpToPage(index);
        }

        setState(() {
          _currentIndex = index;
        });
      },
    );
  }
}
