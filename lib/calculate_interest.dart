import 'package:flutter/material.dart';
import 'package:account_management/accounts.dart';

class CalculateInterestPage extends StatefulWidget {
  final double interest;

  const CalculateInterestPage({super.key, required this.interest});

  @override
  State<CalculateInterestPage> createState() => _CalculateInterestPageState();
}

class _CalculateInterestPageState extends State<CalculateInterestPage> {
  /// Initialize interestAmount and totalAmount
  double _interestAmount = 0.0;
  double _totalAmount = 0.0;

  /// Controllers for amount and time
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _amountController.dispose();
    _timeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Calculate Interest"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _amountController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  hintText: 'Enter your amount',
                  labelText: 'Amount',
                  border: OutlineInputBorder(),
                ),
                validator: _validateAmount,
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: _timeController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  hintText: 'Enter number of years',
                  labelText: 'Time',
                  border: OutlineInputBorder(),
                ),
                validator: _validateTime,
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: _calculateInterest,
                child: const Text('Calculate'),
              ),
              const SizedBox(height: 16.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Display interest amount and amount after interest after calculation
                  Text("Total Interest Amount: $_interestAmount"),
                  Text("Total amount after adding interest: $_totalAmount"),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Method to validate amount
  String? _validateAmount(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter the amount';
    }
    double amount = double.parse(value);
    if (amount <= 0) {
      return 'Invalid amount';
    }
    return null;
  }

  /// Method to validate time
  String? _validateTime(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter the time';
    }
    int? time = int.tryParse(value);
    if (time == null || time <= 0) {
      return 'Invalid time';
    }
    return null;
  }

  /// Method to calculate interest
  void _calculateInterest() {
    if (_formKey.currentState!.validate()) {
      final amount = double.parse(_amountController.text);
      final time = int.parse(_timeController.text);

      setState(() {
        _interestAmount = InterestCalculator.calculateInterest(
          amount: amount,
          year: time,
          interestRate: widget.interest,
        );
        _totalAmount = amount + _interestAmount;
      });
    }
  }
}
