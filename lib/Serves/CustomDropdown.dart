// ignore_for_file: sized_box_for_whitespace, library_private_types_in_public_api, use_super_parameters, file_names

import 'package:flutter/material.dart';

class CustomDropdownButtonFormField extends StatefulWidget {
  final String labelText;
  final String? value;
  final List<String> items;
  final Function(String?)? onChanged;
  final bool enabled;

  const CustomDropdownButtonFormField({
    required this.labelText,
    required this.value,
    required this.items,
    this.onChanged,
    this.enabled = true, // Default to enabled
    Key? key,
  }) : super(key: key);

  @override
  _CustomDropdownButtonFormFieldState createState() =>
      _CustomDropdownButtonFormFieldState();
}

// labelText: widget.labelText,
//           floatingLabelAlignment: FloatingLabelAlignment.center,
//           alignLabelWithHint: true, // Align the label with the hint

class _CustomDropdownButtonFormFieldState
    extends State<CustomDropdownButtonFormField> {
  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: !widget.enabled,
      child: TextFormField(
        readOnly: true,
        decoration: InputDecoration(hintText: widget.labelText),
        controller: TextEditingController(text: widget.value),
        textAlign: TextAlign.right,
        onTap: widget.enabled
            ? () {
                showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return Container(
                      height: 450,
                      child: ListView.builder(
                        itemCount: widget.items.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text(
                              widget.items[index],
                              textAlign: TextAlign.right,
                            ),
                            onTap: () {
                              widget.onChanged?.call(widget.items[index]);
                              Navigator.pop(context);
                            },
                          );
                        },
                      ),
                    );
                  },
                );
              }
            : null,
      ),
    );
  }
}
