import 'package:flutter/material.dart';
import 'package:account_management/accounts.dart';
import 'package:account_management/accounts_detail.dart';
import 'package:account_management/add_accounts.dart';

class AccountListPage extends StatefulWidget {
  const AccountListPage({Key? key}) : super(key: key);

  @override
  State<AccountListPage> createState() => _AccountListPageState();
}

class _AccountListPageState extends State<AccountListPage> {
  /// Instance of AccountManager to manage accounts
  final _accountManager = AccountManager();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('List of Accounts'),
        centerTitle: true,
      ),
      body: _buildAccountList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // Navigate to AddAccountPage
          final result = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  AddAccountPage(accountManager: _accountManager),
            ),
          );

          // Update UI if account is added
          if (result != null) {
            setState(() {});
          }
        },
        backgroundColor: Colors.teal[400],
        child: const Icon(Icons.add),
      ),
    );
  }

  /// Widget to build the list of accounts
  Widget _buildAccountList() {
    return _accountManager.accountList.isEmpty
        ? _emptyAccountMessage()
        : _listViewBuild();
  }

  Widget _emptyAccountMessage() {
    return const Center(
      child: Text(
        'No accounts available',
        style: TextStyle(fontSize: 18.0),
      ),
    );
  }

  Widget _listViewBuild() {
    return ListView.builder(
      itemCount: _accountManager.accountList.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(_accountManager.accountList[index].accountHolder),
          subtitle:
              Text(_accountManager.accountList[index].accountNumber.toString()),
          onTap: () {
            // Navigate to AccountDetailPage when account is tapped
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => AccountDetailPage(
                  account: _accountManager.accountList[index],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
