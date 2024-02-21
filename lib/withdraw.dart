import 'package:flutter/material.dart';

class WithdrawDialog extends StatefulWidget {
  final TextEditingController withdrawController;
  final double balance;
  final Function(double) onWithdraw;

  const WithdrawDialog({
    super.key,
    required this.withdrawController,
    required this.balance,
    required this.onWithdraw,
  });

  @override
  State<WithdrawDialog> createState() => _WithdrawDialogState();
}

class _WithdrawDialogState extends State<WithdrawDialog> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Enter Withdraw Amount'),
      content: Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: TextFormField(
          controller: widget.withdrawController,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
          ),
          validator: _validateWithdrawal,
        ),
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              double withdrawAmount =
                  double.parse(widget.withdrawController.text);
              widget.onWithdraw(withdrawAmount);
              Navigator.of(context).pop();
            }
          },
          child: const Text('Withdraw'),
        ),
      ],
    );
  }

  /// Method to validate entered with amount
  String? _validateWithdrawal(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a withdrawal amount';
    }
    double withdrawAmount = double.parse(value);
    if (withdrawAmount <= 0) {
      return 'Invalid withdrawal amount';
    }
    if (withdrawAmount > widget.balance) {
      return 'You do not have enough balance';
    }
    return null;
  }
}
