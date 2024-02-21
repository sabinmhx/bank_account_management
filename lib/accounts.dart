/// Account class to hold account number, account holder's name
class Account {
  late int accountNumber;
  late String accountHolder;
  late double balance;
  double interestRate = 6.0;

  Account(this.accountHolder, this.accountNumber, this.balance);

  void deposit(double depositAmount) {
    balance += depositAmount;
  }

  void withdraw(double withdrawAmount) {
    balance -= withdrawAmount;
  }

  void updateName(String newAccountHolder) {
    accountHolder = newAccountHolder;
  }
}

/// Singleton for Account Class
class AccountManager {
  static final AccountManager _instance = AccountManager._internal();

  factory AccountManager() {
    return _instance;
  }

  AccountManager._internal();

  final List<Account> accountList = [];

  /// add the account to the list
  void add(Account account) {
    accountList.add(account);
  }

  /// remove the account from the list
  void remove(int accountNumber) {
    accountList
        .removeWhere((element) => element.accountNumber == accountNumber);
  }
}

/// class to calculate the interest
class InterestCalculator {
  static double calculateInterest({
    required double amount,
    required int year,
    required double interestRate,
  }) {
    return (amount * year * interestRate) / 100;
  }
}
