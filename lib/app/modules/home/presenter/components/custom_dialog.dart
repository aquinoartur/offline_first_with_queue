import 'package:flutter/cupertino.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:offline_first/app/modules/home/presenter/components/styles/text_style.dart';

class CustomDialog extends StatelessWidget {
  final VoidCallback onAccept;
  const CustomDialog({Key? key, required this.onAccept}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      content: Text(
        'Você possui conexão com a internet. Deseja sincronizar os seus dados?',
        style: defaultStyle.copyWith(fontSize: 14),
      ),
      actions: [
        CupertinoDialogAction(
          child: const Text('Não'),
          onPressed: Modular.to.pop,
        ),
        CupertinoDialogAction(
          child: const Text('Sim'),
          onPressed: onAccept,
        ),
      ],
    );
  }
}
