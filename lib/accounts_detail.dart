import 'package:flutter/material.dart';
import 'package:account_management/calculate_interest.dart';
import 'package:account_management/accounts_list.dart';
import 'package:account_management/accounts.dart';
import 'package:account_management/deposit.dart';
import 'package:account_management/withdraw.dart';
import 'package:account_management/update_name.dart';

class AccountDetailPage extends StatefulWidget {
  final Account account;

  const AccountDetailPage({super.key, required this.account});

  @override
  State<AccountDetailPage> createState() => _AccountDetailPageState();
}

class _AccountDetailPageState extends State<AccountDetailPage> {
  final _depositController = TextEditingController();
  final _withdrawController = TextEditingController();
  final _updateNameController = TextEditingController();
  final AccountManager _accountManager = AccountManager();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Account Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Your Account Details',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            // Displays account information
            Text('Account Number: ${widget.account.accountNumber}'),
            Text('Account Holder: ${widget.account.accountHolder}'),
            Text('Balance: ${widget.account.balance}'),
            Text('Interest Rate: ${widget.account.interestRate} %'),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () => _deleteAccount(),
                  child: const Text('Delete'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => CalculateInterestPage(
                          interest: widget.account.interestRate,
                        ),
                      ),
                    );
                  },
                  child: const Text('Calculate Interest'),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () => _showDepositDialog(),
                  child: const Text('Deposit'),
                ),
                ElevatedButton(
                  onPressed: () => _showWithdrawDialog(),
                  child: const Text('Withdraw'),
                ),
                ElevatedButton(
                  onPressed: () => _showUpdateNameDialog(),
                  child: const Text('Update'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// Dialog to confirmation for deleting account
  void _deleteAccount() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirm Account Deletion'),
        content: const Text('Are you sure you want to delete this account?'),
        actions: [
          TextButton(
            onPressed: () {
              _accountManager.remove(widget.account.accountNumber);
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                  builder: (context) => const AccountListPage(),
                ),
                (route) => false,
              );
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Account deleted successfully'),
                ),
              );
            },
            child: const Text('Yes'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('No'),
          ),
        ],
      ),
    );
  }

  /// Dialog to show field for depositing amount
  void _showDepositDialog() {
    showDialog(
      context: context,
      builder: (context) => DepositDialog(
        depositController: _depositController,
        onDeposit: (amount) {
          setState(() {
            widget.account.deposit(amount);
          });
          _depositController.clear();
        },
      ),
    );
  }

  /// Dialog to show field for withdrawing amount

  void _showWithdrawDialog() {
    showDialog(
      context: context,
      builder: (context) => WithdrawDialog(
        withdrawController: _withdrawController,
        balance: widget.account.balance,
        onWithdraw: (amount) {
          setState(() {
            widget.account.withdraw(amount);
          });
        },
      ),
    );
  }

  /// Dialog to show field for updating name

  void _showUpdateNameDialog() {
    showDialog(
      context: context,
      builder: (context) => UpdateNameDialog(
        updateNameController: _updateNameController,
        onUpdateName: (newName) {
          setState(() {
            widget.account.updateName(newName);
          });
        },
      ),
    );
  }
}
