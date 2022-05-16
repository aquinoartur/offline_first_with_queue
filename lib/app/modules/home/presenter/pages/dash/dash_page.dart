import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:offline_first/app/modules/home/presenter/components/loading.dart';
import 'package:offline_first/app/modules/home/presenter/pages/home/blocs/connectivity_bloc/connectivity_bloc.dart';
import 'package:offline_first/app/modules/home/presenter/pages/home/blocs/home_bloc/home_bloc.dart';
import 'package:offline_first/app/modules/home/presenter/pages/home/home_page.dart';

import '../register/blocs/register_bloc/register_bloc.dart';
import '../register/register_page.dart';

class DashPage extends StatelessWidget {
  final HomeBloc homeBloc;
  final RegisterBloc registerBloc;
  final ConnectivityBloc connectivityBloc;
  const DashPage({
    Key? key,
    required this.homeBloc,
    required this.registerBloc,
    required this.connectivityBloc,
  }) : super(key: key);

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
                  connectivityBloc: connectivityBloc,
                );
              },
            );
            break;
          case 1:
            returnValue = CupertinoTabView(
              builder: (ctx) => RegisterPage(
                registerBloc: registerBloc,
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
