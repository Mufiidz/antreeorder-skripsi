import 'package:antreeorder/components/export_components.dart';
import 'package:antreeorder/utils/export_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class AddSeatScreen extends StatelessWidget {
  const AddSeatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AntreeAppBar("Add Seat"),
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: ListView.separated(
                itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      child: Text(_contents[index]),
                    ),
                separatorBuilder: (context, index) => const Divider(),
                itemCount: _contents.length),
          ),
          Container(
              width: context.mediaSize.width,
              padding: const EdgeInsets.symmetric(vertical: 8),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16)),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black12,
                      blurRadius: 2,
                      offset: Offset(0, -2))
                ],
              ),
              child: FormBuilder(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Column(
                    children: [
                      const AntreeTextField(
                        'title',
                        label: "Title",
                      ),
                      const AntreeSpacer(),
                      Row(
                        children: const [
                          Expanded(
                            child: AntreeTextField(
                              'capacity',
                              label: "Capacity",
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Padding(
                              padding: EdgeInsets.only(left: 8.0),
                              child: AntreeTextField(
                                'quantity',
                                label: "Quantity",
                              ),
                            ),
                          ),
                        ],
                      ),
                      const AntreeSpacer(),
                      AntreeButton(
                        'Add Seat',
                        width: context.mediaSize.width,
                      )
                    ],
                  ),
                ),
              ))
        ],
      ),
    );
  }

  List<String> get _contents => List.generate(10, (index) => 'Seat $index');
}
