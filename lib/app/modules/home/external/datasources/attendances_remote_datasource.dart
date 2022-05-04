import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:offline_first/app/modules/home/domain/entity/attendance_entity.dart';
import 'package:offline_first/app/modules/home/external/mappers/attendance_mapper.dart';
import 'package:offline_first/app/modules/home/infra/datasources/attendances_remote_datasource.dart';

class AttendancesRemoteDatasourceImpl implements AttendancesRemoteDatasource {
  final FirebaseFirestore firebase;

  AttendancesRemoteDatasourceImpl(this.firebase);

  @override
  Future<List<AttendanceEntity>> getAttendances() async {
    var path = 'attendances';
    try {
      final result = await firebase.collection(path).orderBy('title').limitToLast(10).get();
      var mapList = result.docs.map((item) => item.data()).toList();
      return AttendanceMapper().fromMapList(mapList).reversed.toList();
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<void> addAttendances(List<AttendanceEntity> attendances) async {
    var path = 'attendances';
    try {
      for (var attendance in attendances) {
        var item = AttendanceMapper().toMap(attendance);
        final result = await firebase.collection(path).add(item);
        debugPrint(result.toString());
      }
    } catch (_) {
      rethrow;
    }
  }
}
