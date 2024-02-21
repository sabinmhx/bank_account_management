import 'package:flutter/material.dart';
import 'package:account_management/accounts.dart';

class AddAccountPage extends StatefulWidget {
  final AccountManager accountManager;

  const AddAccountPage({super.key, required this.accountManager});

  @override
  State<AddAccountPage> createState() => _AddAccountPageState();
}

class _AddAccountPageState extends State<AddAccountPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  /// Controller for account holder, account number and balance
  final _accountHolderController = TextEditingController();
  final _accountNumberController = TextEditingController();
  final _balanceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Account'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Enter your account information',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10.0),
              // Text form field for account holder name
              TextFormField(
                controller: _accountHolderController,
                decoration: const InputDecoration(
                  labelText: 'Account Name',
                  border: OutlineInputBorder(),
                ),
                validator: _validateAccountHolder,
              ),
              const SizedBox(height: 10.0),
              // Text form field for account number
              TextFormField(
                controller: _accountNumberController,
                decoration: const InputDecoration(
                  labelText: 'Enter account number',
                  border: OutlineInputBorder(),
                ),
                maxLength: 16,
                keyboardType: TextInputType.number,
                validator: _validateAccountNumber,
              ),
              const SizedBox(height: 10.0),
              // Text form field for account balance
              TextFormField(
                controller: _balanceController,
                decoration: const InputDecoration(
                  labelText: 'Enter your balance',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                validator: _validateBalance,
              ),
              const SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
                  _submitForm();
                },
                child: const Text('Add'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Method to validate and submit the form
  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Add account to account manager
      widget.accountManager.add(
        Account(
          _accountHolderController.text,
          int.parse(_accountNumberController.text),
          double.parse(_balanceController.text),
        ),
      );
      // Navigate back to previous screen(=>accounts_list)
      Navigator.pop(context, true);
    }
  }

  /// Method to validate account holder name
  String? _validateAccountHolder(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter account name';
    }
    return null;
  }

  /// Method to validate account number
  String? _validateAccountNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter account number';
    }
    if (value.length != 16) {
      return 'Account number should be 16 digits long';
    }
    if (int.tryParse(value) == null) {
      return 'Please enter a valid number';
    }
    return null;
  }

  /// Method to validate account balance
  String? _validateBalance(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter balance';
    }
    if (double.tryParse(value) == null) {
      return 'Please enter a valid balance';
    }
    return null;
  }
}
