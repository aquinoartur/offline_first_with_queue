import 'package:flutter/cupertino.dart';
import 'package:offline_first/app/modules/home/presenter/components/list_tile_item.dart';

import '../styles/text_style.dart';
import '../utils.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: CupertinoColors.white,
      child: CustomScrollView(
        slivers: <Widget>[
          const CupertinoSliverNavigationBar(
            largeTitle: Text('Attendance Page'),
          ),
          SliverSafeArea(
            top: false,
            sliver: SliverToBoxAdapter(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text('Today',
                          style: defaultStyle.copyWith(fontSize: 24)),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 75,
                          height: 75,
                          color: CupertinoColors.activeGreen,
                        ),
                        Container(
                          width: 75,
                          height: 75,
                          color: CupertinoColors.activeBlue,
                        ),
                        Container(
                          width: 75,
                          height: 75,
                          color: CupertinoColors.activeOrange,
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text('Last uptade',
                          style: defaultStyle.copyWith(fontSize: 24)),
                    ),
                    const SizedBox(height: 12),
                    ListView.separated(
                      shrinkWrap: true,
                      itemCount: attendances.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 4),
                      itemBuilder: (context, index) {
                        var attendance = attendances[index];
                        return ListTileItem(attendance: attendance);
                      },
                    ),
                    const SizedBox(height: 12),
                  ],
                ),
              ),
            ),
          ) // END OF NEW CONTENT
        ],
      ),
    );
  }
}
