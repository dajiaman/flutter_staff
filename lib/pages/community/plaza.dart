import 'package:flutter/material.dart';
import 'package:flutter_stuff/pages/community/widgets/community_big_card.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../common/widgets/search_bar.dart';

class PlazaPage extends StatefulWidget {
  const PlazaPage({super.key});

  @override
  State<PlazaPage> createState() => _PlazaPageState();
}

class _PlazaPageState extends State<PlazaPage> {
  @override
  Widget build(BuildContext context) {
    return VxScrollVertical(
        physics: BouncingScrollPhysics(),
        child: VStack(
          [
            Container(
              color: Colors.white,
              padding: EdgeInsets.all(16),
              child: MySearchInputWidget(
                hint: "搜索你想搜索的吧",
                readOnly: true,
              ),
            ),
            VStack([
              CommunityBigCardWidget(),
              CommunityBigCardWidget(),
              CommunityBigCardWidget(),
              CommunityBigCardWidget(),
              CommunityBigCardWidget(),
              CommunityBigCardWidget(),
              CommunityBigCardWidget(),
            ]),
          ],
        ));
  }
}
