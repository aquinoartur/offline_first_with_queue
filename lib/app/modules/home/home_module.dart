import 'package:flutter_modular/flutter_modular.dart';
import 'package:offline_first/app/modules/home/domain/usecases/add_attendance_usecase.dart';
import 'package:offline_first/app/modules/home/domain/usecases/get_attendances_usecase.dart';
import 'package:offline_first/app/modules/home/external/datasources/attendances_remote_datasource.dart';
import 'package:offline_first/app/modules/home/infra/repository/attedances_repository.dart';
import 'package:offline_first/app/modules/home/presenter/pages/dash/dash_page.dart';
import 'package:offline_first/app/modules/home/presenter/pages/home/blocs/connectivity_bloc/connectivity_bloc.dart';
import 'package:offline_first/app/modules/home/presenter/pages/home/blocs/home_bloc/home_bloc.dart';

import 'domain/usecases/update_local_attendances_usecase.dart';
import 'domain/usecases/update_remote_attendances_usecase.dart';
import 'external/datasources/attendances_local_datasource.dart';
import 'presenter/pages/register/blocs/register_bloc/register_bloc.dart';

class HomeModule extends Module {
  @override
  List<Bind<Object>> get binds => [
        Bind((i) => ConnectivityBloc(connectivityService: i())),
        Bind(
          (i) => RegisterBloc(
            addAttendanceUsecase: i(),
            updateRemoteAttendanceUsecase: i(),
            updateLocalAttendanceUsecase: i(),
          ),
        ),
        Bind((i) => HomeBloc(getAttendancesUsecase: i(), registerBloc: i())),
        Bind((i) => GetAttendancesUsecaseImpl(i())),
        Bind((i) => AddAttendanceUsecaseImpl(i())),
        Bind((i) => UpdateRemoteAttendancesUsecaseImpl(i())),
        Bind((i) => UpdateLocalAttendancesUsecaseImpl(i())),
        Bind((i) => AttendancesRepositoryImpl(i(), i(), i())),
        Bind((i) => AttendancesRemoteDatasourceImpl(i())),
        Bind((i) => AttendancesLocalDatasourceImpl(i())),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          '/',
          child: (context, args) => DashPage(
            registerBloc: Modular.get<RegisterBloc>(),
            homeBloc: Modular.get<HomeBloc>(),
            connectivityBloc: Modular.get<ConnectivityBloc>(),
          ),
        ),
      ];
}
