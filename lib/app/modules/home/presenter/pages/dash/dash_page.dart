import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:offline_first/app/modules/home/presenter/pages/add/add_page.dart';
import 'package:offline_first/app/modules/home/presenter/components/loading.dart';
import 'package:offline_first/app/modules/home/presenter/pages/add/blocs/add_bloc/add_bloc.dart';
import 'package:offline_first/app/modules/home/presenter/pages/home/blocs/home_bloc/home_bloc.dart';
import 'package:offline_first/app/modules/home/presenter/pages/home/home_page.dart';

class DashPage extends StatelessWidget {
  final HomeBloc homeBloc;
  final AddBloc addBloc;
  const DashPage({Key? key, required this.homeBloc, required this.addBloc}) : super(key: key);

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
            returnValue = CupertinoTabView(
              builder: (ctx) {
                return HomePage(
                  homeBloc: homeBloc,
                );
              },
            );
            break;
          case 1:
            returnValue = CupertinoTabView(
              builder: (ctx) => AddPage(
                addBloc: addBloc,
              ),
            );
            break;
          case 2:
            returnValue = CupertinoTabView(builder: (ctx) => const Scaffold(body: Loading()));
            break;
        }
        return returnValue;
      },
    );
  }
}
