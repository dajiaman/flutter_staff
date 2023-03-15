import 'package:flutter/material.dart';
import 'package:flutter_stuff/common/res/gaps.dart';
import 'package:flutter_stuff/common/widgets/empty_widget.dart';
import 'package:flutter_stuff/common/widgets/load_image.dart';
import 'package:flutter_stuff/pages/home/widgets/follow_card.dart';
import 'package:velocity_x/velocity_x.dart';

class FollowPage extends StatefulWidget {
  const FollowPage({super.key});

  @override
  State<FollowPage> createState() => _FollowPageState();
}

class _FollowPageState extends State<FollowPage> {
  @override
  Widget build(BuildContext context) {
    return VStack(
      [
        Container(
          color: Colors.white,
          padding: EdgeInsets.symmetric(vertical: 50, horizontal: 20),
          child: EmptyWidget(
            title: '暂无关注',
            content: '去关注更多志同道合的朋友吧~',
            image: LoadAssetImage(
              'home/no_follow',
            ),
          ),
        ),
        HStack(
          [
            "可能感兴趣的人".text.size(20).bold.make(),
            HStack(
              [
                "全部".text.size(10).gray600.make(),
              ],
              crossAlignment: CrossAxisAlignment.center,
              alignment: MainAxisAlignment.end,
            ),
          ],
          axisSize: MainAxisSize.max,
          alignment: MainAxisAlignment.spaceBetween,
        ).p(16),
        VxScrollHorizontal(
          child: HStack(
            [
              FollowCard(),
              FollowCard(),
              FollowCard(),
              FollowCard(),
              FollowCard(),
            ],
          ),
          padding: EdgeInsets.only(left: 16),
          physics: const BouncingScrollPhysics(),
        ),
      ],
    );
  }
}
