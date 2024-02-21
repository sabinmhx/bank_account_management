import 'package:flutter/material.dart';
import 'package:account_management/accounts_list.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      // Displays accounts list page as home page for app
      home: AccountListPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
