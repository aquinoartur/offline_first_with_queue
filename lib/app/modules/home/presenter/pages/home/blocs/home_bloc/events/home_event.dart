abstract class HomeEvent {}

class GetAttendanceListEvent extends HomeEvent {
  final bool syncData;

  GetAttendanceListEvent({
    this.syncData = false,
  });
}
