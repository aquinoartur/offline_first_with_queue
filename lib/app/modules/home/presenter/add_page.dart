import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'components/styles/text_style.dart';

class AddPage extends StatefulWidget {
  const AddPage({Key? key}) : super(key: key);

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: CupertinoPageScaffold(
        backgroundColor: CupertinoColors.white,
        child: CustomScrollView(
          slivers: <Widget>[
            CupertinoSliverNavigationBar(
              largeTitle: Text(
                'Registrar atendimento',
                style: defaultStyle.copyWith(fontSize: 26),
              ),
            ),
            SliverSafeArea(
              top: false,
              sliver: SliverToBoxAdapter(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: CupertinoColors.systemGrey5,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: CupertinoTextFormFieldRow(
                          onChanged: (text) {},
                          prefix: const Text('Título:'),
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return 'Dígite um título válido';
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(height: 24),
                      Container(
                        decoration: BoxDecoration(
                          color: CupertinoColors.systemGrey5,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: CupertinoTextFormFieldRow(
                          onChanged: (text) {},
                          prefix: const Text('Descrição:'),
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return 'Dígite uma descrição válida';
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(height: 24),
                      Container(
                        decoration: BoxDecoration(
                          color: CupertinoColors.systemGrey5,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: CupertinoTextFormFieldRow(
                          onChanged: (text) {},
                          prefix: const Text('CID:'),
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return 'Dígite um CID válido';
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(height: 24),
                      CheckboxListTile(
                        value: false,
                        controlAffinity: ListTileControlAffinity.leading,
                        onChanged: (value) {},
                        title: const Text('Urgência'),
                      ),
                      const SizedBox(height: 24),
                      CupertinoButton(
                        padding: EdgeInsets.zero,
                        child: const Text('Registrar'),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
              ),
            ) // END OF NEW CONTENT
          ],
        ),
      ),
    );
  }
}
