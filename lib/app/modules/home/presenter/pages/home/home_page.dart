import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../../components/list_tile_item.dart';
import 'blocs/connectivity_bloc/connectivity_bloc.dart';
import 'blocs/connectivity_bloc/states/connectivity_state.dart';
import 'blocs/home_bloc/states/home_state.dart';
import '../../components/custom_dialog.dart';
import '../../components/loading.dart';
import '../../components/styles/text_style.dart';
import 'blocs/connectivity_bloc/events/connectivity_event.dart';
import 'blocs/home_bloc/events/home_event.dart';
import 'blocs/home_bloc/home_bloc.dart';

class HomePage extends StatefulWidget {
  final HomeBloc homeBloc;
  final ConnectivityBloc connectivityBloc;
  const HomePage({Key? key, required this.homeBloc, required this.connectivityBloc}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final HomeBloc _homeBloc;
  late final ConnectivityBloc _connectivityBloc;

  @override
  void initState() {
    super.initState();
    _homeBloc = widget.homeBloc;
    _connectivityBloc = widget.connectivityBloc;

    if (_connectivityBloc.connectivityService.isOnline) {
      _connectivityBloc.add(ShowSyncRemoteDialogEvent());
    } else {
      _connectivityBloc.add(ShowSyncLocalDialogEvent());
    }

    _homeBloc.add(GetAttendanceListEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: CustomScrollView(
        slivers: <Widget>[
          CupertinoSliverNavigationBar(
            largeTitle: Text('Atendimentos', style: defaultStyle.copyWith(fontSize: 26)),
          ),
          SliverSafeArea(
            top: false,
            sliver: SliverToBoxAdapter(
              child: BlocListener<ConnectivityBloc, ConnectivityState>(
                bloc: _connectivityBloc,
                listener: (context, state) {
                  if (state is ConnectedState) {
                    showDialog(
                      context: context,
                      builder: (context) => CustomDialog(onAccept: _onAcceptSync, isConnected: true),
                    );
                  }

                  if (state is DisconnectedState) {
                    showDialog(
                      context: context,
                      builder: (context) => const CustomDialog(isConnected: false),
                    );
                  }
                },
                child: BlocBuilder<HomeBloc, HomeState>(
                  bloc: _homeBloc,
                  builder: (context, state) {
                    if (state is LoadingHomeState || state is InitialHomeState) {
                      return const Loading();
                    }

                    if (state is ErrorHomeState) {
                      return Center(child: Text('Error: ${state.error}'));
                    }

                    return Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Hoje', style: defaultStyle.copyWith(fontSize: 20)),
                              const SizedBox(height: 24),
                              SizedBox(
                                height: 80,
                                child: ListView.separated(
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  itemCount: state.todayAttendances!.length,
                                  separatorBuilder: (_, __) => const SizedBox(width: 20),
                                  itemBuilder: (context, index) {
                                    var attendance = state.todayAttendances![index];
                                    return Column(
                                      children: [
                                        Stack(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(right: 16),
                                              child: CircleAvatar(
                                                child: Icon(
                                                  attendance.isUrgency ? Icons.local_hospital : Icons.healing_outlined,
                                                  color: Colors.white,
                                                ),
                                                backgroundColor: attendance.isUrgency ? Colors.red : Colors.green,
                                              ),
                                            ),
                                            const Positioned(
                                              top: 0,
                                              right: 0,
                                              child: Icon(Icons.sync, color: Colors.blueAccent),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 12),
                                        Text('CID: ${attendance.cid}', style: defaultStyle),
                                      ],
                                    );
                                  },
                                ),
                              ),
                              const SizedBox(height: 32),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text('Todos', style: defaultStyle.copyWith(fontSize: 20)),
                              ),
                              const SizedBox(height: 24),
                              ListView.separated(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: (state).attendances!.length,
                                padding: EdgeInsets.zero,
                                separatorBuilder: (_, __) => const SizedBox(height: 4),
                                itemBuilder: (context, index) {
                                  var attendance = (state).attendances![index];
                                  return ListTileItem(attendance: attendance);
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ) // END OF NEW CONTENT
        ],
      ),
    );
  }

  void _onAcceptSync() {
    _homeBloc.add(GetAttendanceListEvent(syncData: true));

    Modular.to.pop();
  }
}
