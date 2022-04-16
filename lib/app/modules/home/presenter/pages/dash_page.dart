import 'package:flutter/cupertino.dart';
import 'package:offline_first/app/modules/home/presenter/pages/home_page.dart';

class DashPage extends StatelessWidget {
  const DashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        height: 56,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.add),
            label: 'Add',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.info),
            label: 'About',
          ),
        ],
      ),
      tabBuilder: (ctx, index) {
        late final CupertinoTabView returnValue;
        switch (index) {
          case 0:
            returnValue = CupertinoTabView(builder: (ctx) => const HomePage());
            break;
          case 1:
            returnValue = CupertinoTabView(builder: (ctx) => const HomePage());
            break;
          case 2:
            returnValue = CupertinoTabView(builder: (ctx) => const HomePage());
            break;
        }
        return returnValue;
      },
    );
  }
}
