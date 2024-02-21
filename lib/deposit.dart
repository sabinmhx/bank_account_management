import 'package:flutter/material.dart';

class DepositDialog extends StatefulWidget {
  final TextEditingController depositController;
  final Function(double) onDeposit;

  const DepositDialog({
    super.key,
    required this.depositController,
    required this.onDeposit,
  });

  @override
  State<DepositDialog> createState() => _DepositDialogState();
}

class _DepositDialogState extends State<DepositDialog> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Enter Deposit Amount'),
      content: Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: TextFormField(
          controller: widget.depositController,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
          ),
          validator: _validateDeposit,
        ),
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              double depositAmount =
                  double.parse(widget.depositController.text);
              widget.onDeposit(depositAmount);
              Navigator.of(context).pop();
            }
          },
          child: const Text('Deposit'),
        ),
      ],
    );
  }

  // Method to validate entered deposit amount
  String? _validateDeposit(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a deposit amount';
    }
    double depositAmount = double.parse(value);
    if (depositAmount <= 0) {
      return 'Invalid deposit amount';
    }
    return null;
  }
}
