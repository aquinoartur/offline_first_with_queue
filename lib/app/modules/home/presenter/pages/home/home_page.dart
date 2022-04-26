import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:offline_first/app/modules/home/presenter/components/list_tile_item.dart';
import '../../components/styles/text_style.dart';
import '../../utils.dart';

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
          CupertinoSliverNavigationBar(
            largeTitle: Text(
              'Atendimentos',
              style: defaultStyle.copyWith(fontSize: 26),
            ),
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
                      child: Text('Hoje',
                          style: defaultStyle.copyWith(fontSize: 20)),
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      height: 80,
                      width: double.infinity,
                      child: ListView.separated(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: attendances.length,
                        separatorBuilder: (_, __) => const SizedBox(width: 20),
                        itemBuilder: (context, index) {
                          var attendance = attendances[index];
                          return SizedBox(
                            height: 56,
                            child: Column(
                              children: [
                                CircleAvatar(
                                  backgroundColor: attendance.isUrgency
                                      ? const Color(0XFFffccbc)
                                      : Colors.greenAccent,
                                ),
                                const SizedBox(height: 12),
                                Text(
                                  'CID: ${attendance.cid}',
                                  style: defaultStyle,
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 32),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text('Última atualização',
                          style: defaultStyle.copyWith(fontSize: 20)),
                    ),
                    const SizedBox(height: 24),
                    ListView.separated(
                      shrinkWrap: true,
                      itemCount: attendances.length,
                      padding: EdgeInsets.zero,
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
