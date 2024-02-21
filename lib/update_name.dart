import 'package:flutter/material.dart';

class UpdateNameDialog extends StatefulWidget {
  final TextEditingController updateNameController;
  final Function(String) onUpdateName;

  const UpdateNameDialog({
    super.key,
    required this.updateNameController,
    required this.onUpdateName,
  });

  @override
  State<UpdateNameDialog> createState() => _UpdateNameDialogState();
}

class _UpdateNameDialogState extends State<UpdateNameDialog> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Enter New Name'),
      content: Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: TextFormField(
          controller: widget.updateNameController,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
          ),
          validator: _validateName,
        ),
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              String newName = widget.updateNameController.text;
              widget.onUpdateName(newName);
              Navigator.of(context).pop();
            }
          },
          child: const Text('Update Name'),
        ),
      ],
    );
  }

  /// Method to validate new entered name
  String? _validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a new name';
    }
    return null;
  }
}
