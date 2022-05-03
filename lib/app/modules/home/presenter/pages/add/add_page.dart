import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:offline_first/app/modules/home/domain/entity/attendance_entity.dart';
import 'package:offline_first/app/modules/home/presenter/components/loading.dart';
import 'package:offline_first/app/modules/home/presenter/pages/add/blocs/add_bloc/states/add_state.dart';
import '../../components/styles/text_style.dart';
import 'blocs/add_bloc/add_bloc.dart';
import 'blocs/add_bloc/events/add_event.dart';

class AddPage extends StatefulWidget {
  final AddBloc addBloc;
  const AddPage({Key? key, required this.addBloc}) : super(key: key);

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  late final GlobalKey<FormState> _formKey;
  late final TextEditingController _titleController;
  late final TextEditingController _descriptionController;
  late final TextEditingController _cidController;
  late final ValueNotifier<bool> _isUrgency;
  late final AddBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = widget.addBloc;
    _isUrgency = ValueNotifier(false);
    _formKey = GlobalKey<FormState>();
    _titleController = TextEditingController();
    _descriptionController = TextEditingController();
    _cidController = TextEditingController();
  }

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
                child: BlocBuilder<AddBloc, AddState>(
                  bloc: _bloc,
                  builder: (context, state) {
                    if (state is LoadingAddState) {
                      return const Loading();
                    }

                    if (state is ErrorAddState) {
                      return Center(
                        child: Text('Error: ${state.error}'),
                      );
                    }

                    return SingleChildScrollView(
                      padding: const EdgeInsets.all(16),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: CupertinoColors.systemGrey5,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: CupertinoTextFormFieldRow(
                                onChanged: (text) => _titleController.text = text,
                                prefix: const Text('Título:'),
                                validator: _validator,
                                autovalidateMode: AutovalidateMode.onUserInteraction,
                              ),
                            ),
                            const SizedBox(height: 24),
                            Container(
                              decoration: BoxDecoration(
                                color: CupertinoColors.systemGrey5,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: CupertinoTextFormFieldRow(
                                onChanged: (text) => _descriptionController.text = text,
                                prefix: const Text('Descrição:'),
                                validator: _validator,
                                autovalidateMode: AutovalidateMode.onUserInteraction,
                              ),
                            ),
                            const SizedBox(height: 24),
                            Container(
                              decoration: BoxDecoration(
                                color: CupertinoColors.systemGrey5,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: CupertinoTextFormFieldRow(
                                onChanged: (text) => _cidController.text = text,
                                prefix: const Text('CID:'),
                                keyboardType: TextInputType.number,
                                validator: _validator,
                                autovalidateMode: AutovalidateMode.onUserInteraction,
                              ),
                            ),
                            const SizedBox(height: 24),
                            AnimatedBuilder(
                              animation: _isUrgency,
                              builder: (context, _) {
                                return CheckboxListTile(
                                  value: _isUrgency.value,
                                  controlAffinity: ListTileControlAffinity.leading,
                                  onChanged: (v) => _isUrgency.value = v ?? false,
                                  title: const Text('Urgência'),
                                );
                              },
                            ),
                            const SizedBox(height: 24),
                            CupertinoButton(
                              padding: EdgeInsets.zero,
                              child: const Text('Registrar'),
                              onPressed: () {
                                if (_formKey.currentState?.validate() ?? false) {
                                  _bloc.add(
                                    AddAttendanceEvent(
                                      attendance: AttendanceEntity(
                                        cid: int.parse(_cidController.text),
                                        description: _descriptionController.text,
                                        title: _titleController.text,
                                        createdTime: DateTime.now(),
                                        isUrgency: _isUrgency.value,
                                      ),
                                    ),
                                  );
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ) // END OF NEW CONTENT
          ],
        ),
      ),
    );
  }

  String? _validator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Dígite um valor válido';
    }
    return null;
  }
}
