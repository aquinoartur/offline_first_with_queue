import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../domain/entity/attendance_entity.dart';
import 'styles/text_style.dart';

class ListTileItem extends StatelessWidget {
  const ListTileItem({
    required this.attendance,
    Key? key,
  }) : super(key: key);

  final AttendanceEntity attendance;
  @override
  Widget build(BuildContext context) {
    final row = SafeArea(
      top: false,
      bottom: false,
      minimum: const EdgeInsets.only(
        left: 16,
        top: 8,
        bottom: 8,
      ),
      child: Row(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: CircleAvatar(
              child: Icon(
                attendance.isUrgency
                    ? Icons.local_hospital
                    : Icons.healing_outlined,
                color: Colors.white,
              ),
              backgroundColor: attendance.isUrgency ? Colors.red : Colors.green,
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    attendance.title,
                    style: defaultStyle.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const Padding(padding: EdgeInsets.only(top: 8)),
                  Text(attendance.description,
                      style: defaultStyle.copyWith(
                        color: CupertinoColors.systemGrey,
                      ))
                ],
              ),
            ),
          ),
          CupertinoButton(
            padding: EdgeInsets.zero,
            onPressed: () {},
            child: const Icon(
              CupertinoIcons.forward,
            ),
          ),
        ],
      ),
    );

    return row;
  }
}
