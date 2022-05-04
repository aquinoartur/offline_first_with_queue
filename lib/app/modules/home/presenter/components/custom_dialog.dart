import 'package:flutter/cupertino.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:offline_first/app/modules/home/presenter/components/styles/text_style.dart';

class CustomDialog extends StatelessWidget {
  final VoidCallback? onAccept;
  final bool isConnected;

  const CustomDialog({
    Key? key,
    this.onAccept,
    required this.isConnected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      content: Text(
        isConnected
            ? 'Conexão com a internet. Deseja sincronizar os seus dados?'
            : 'Não há conexão com a internet. Os dados serão sincronizados quando a conexão for estabelecida.',
        style: defaultStyle.copyWith(fontSize: 14),
      ),
      actions: [
        if (isConnected) ...{
          CupertinoDialogAction(
            child: const Text('Não'),
            onPressed: Modular.to.pop,
          ),
          CupertinoDialogAction(
            child: const Text('Sim'),
            onPressed: onAccept,
          ),
        } else ...{
          CupertinoDialogAction(
            child: const Text('Ok'),
            onPressed: Modular.to.pop,
          )
        }
      ],
    );
  }
}
