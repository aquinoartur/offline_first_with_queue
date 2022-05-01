import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:offline_first/app/modules/home/presenter/components/list_tile_item.dart';
import 'package:offline_first/app/modules/home/presenter/pages/home/blocs/home_bloc/states/home_state.dart';
import '../../components/loading.dart';
import '../../components/styles/text_style.dart';
import 'blocs/home_bloc/events/home_event.dart';
import 'blocs/home_bloc/home_bloc.dart';

class HomePage extends StatefulWidget {
  final HomeBloc homeBloc;
  const HomePage({Key? key, required this.homeBloc}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final HomeBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = widget.homeBloc;
    _bloc.add(GetAttendanceListEvent());
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
              child: BlocBuilder<HomeBloc, HomeState>(
                bloc: _bloc,
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
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text('Hoje', style: defaultStyle.copyWith(fontSize: 20)),
                            ),
                            const SizedBox(height: 24),
                            SizedBox(
                              height: 80,
                              width: double.infinity,
                              child: ListView.separated(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemCount: (state as LoadedHomeState).attendances.length,
                                separatorBuilder: (_, __) => const SizedBox(width: 20),
                                itemBuilder: (context, index) {
                                  var attendance = (state).attendances[index];
                                  return SizedBox(
                                    height: 56,
                                    child: Column(
                                      children: [
                                        CircleAvatar(
                                          child: Icon(
                                            attendance.isUrgency ? Icons.local_hospital : Icons.healing_outlined,
                                            color: Colors.white,
                                          ),
                                          backgroundColor: attendance.isUrgency
                                              ? Colors.red.withOpacity(0.7)
                                              : Colors.green.withOpacity(0.7),
                                        ),
                                        const SizedBox(height: 12),
                                        Text('CID: ${attendance.cid}', style: defaultStyle),
                                      ],
                                    ),
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
                              itemCount: (state).attendances.length,
                              padding: EdgeInsets.zero,
                              separatorBuilder: (_, __) => const SizedBox(height: 4),
                              itemBuilder: (context, index) {
                                var attendance = (state).attendances[index];
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
          ) // END OF NEW CONTENT
        ],
      ),
    );
  }
}
