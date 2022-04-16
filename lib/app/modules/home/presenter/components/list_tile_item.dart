import 'package:flutter/cupertino.dart';
import 'package:offline_first/app/modules/home/presenter/styles/text_style.dart';
import 'package:offline_first/model/attendance.dart';

class ListTileItem extends StatelessWidget {
  const ListTileItem({
    required this.attendance,
    Key? key,
  }) : super(key: key);

  final Attendance attendance;
  @override
  Widget build(BuildContext context) {
    final row = SafeArea(
      top: false,
      bottom: false,
      minimum: const EdgeInsets.only(
        left: 16,
        top: 8,
        bottom: 8,
        right: 8,
      ),
      child: Row(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: Image.network(
              attendance.isUrgency
                  ? 'https://cdn-icons-png.flaticon.com/512/5846/5846173.png'
                  : 'https://cdn-icons.flaticon.com/png/512/3802/premium/3802177.png?token=exp=1650136518~hmac=2ce97f2fd6feb1dc3f5cb0e729a28de1',
              width: 76,
              height: 76,
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
