import 'package:flutter/material.dart';
import 'package:flutter_stuff/common/res/gaps.dart';
import 'package:flutter_stuff/common/widgets/search_bar.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../common/widgets/search_app_bar.dart';
import '../home/widgets/follow_card.dart';
import 'widgets/community_card.dart';

class MyCommunityPage extends StatefulWidget {
  const MyCommunityPage({super.key});

  @override
  State<MyCommunityPage> createState() => _MyCommunityPageState();
}

class _MyCommunityPageState extends State<MyCommunityPage> {
  Widget _buildMyCreateCommunity() {
    return VxScrollHorizontal(
      physics: BouncingScrollPhysics(),
      child: HStack([
        CommunityCardWidget(),
        CommunityCardWidget(),
        CommunityCardWidget(),
        CommunityCardWidget(),
        CommunityCardWidget(),
      ]),
    ).color(Colors.white);
  }

  @override
  Widget build(BuildContext context) {
    return VxScrollVertical(
      physics: BouncingScrollPhysics(),
      child: VStack([
        Container(
          color: Colors.white,
          padding: EdgeInsets.all(16),
          child: MySearchInputWidget(
            hint: "搜索你想搜索的吧",
            readOnly: true,
          ),
        ),
        HStack(
          [
            '我创建的'.text.bold.size(16).make(),
          ],
          axisSize: MainAxisSize.max,
        ).p(16).color(Colors.white),
        _buildMyCreateCommunity(),
        HStack(
          [
            '我加入的'.text.bold.size(16).make(),
          ],
          axisSize: MainAxisSize.max,
        ).p(16).color(Colors.white),
        _buildMyCreateCommunity(),
        HStack(
          [
            '可能认识的人'.text.bold.size(16).make(),
          ],
          axisSize: MainAxisSize.max,
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
      ]),
    );
  }
}
