import 'package:flutter/material.dart';

// Đối tượng và biến mô tả
class User {
  final int id;
  String name;
  String email;
  String password;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'email': email,
        'password': password,
      };

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json['id'],
        name: json['name'],
        email: json['email'],
        password: json['password'],
      );
}

class Income {
  final int id;
  String description;
  double amount;
  DateTime date;

  Income({
    required this.id,
    required this.description,
    required this.amount,
    required this.date,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'description': description,
        'amount': amount,
        'date': date.toIso8601String(),
      };

  factory Income.fromJson(Map<String, dynamic> json) => Income(
        id: json['id'],
        description: json['description'],
        amount: (json['amount'] as num).toDouble(),
        date: DateTime.parse(json['date']),
      );
}

class Expense {
  final int id;
  String description;
  double amount;
  DateTime date;

  Expense({
    required this.id,
    required this.description,
    required this.amount,
    required this.date,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'description': description,
        'amount': amount,
        'date': date.toIso8601String(),
      };

  factory Expense.fromJson(Map<String, dynamic> json) => Expense(
        id: json['id'],
        description: json['description'],
        amount: (json['amount'] as num).toDouble(),
        date: DateTime.parse(json['date']),
      );
}

class IncomeCategory {
  final int id;
  String name;

  IncomeCategory({
    required this.id,
    required this.name,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
      };

  factory IncomeCategory.fromJson(Map<String, dynamic> json) => IncomeCategory(
        id: json['id'],
        name: json['name'],
      );
}

class ExpenseCategory {
  final int id;
  String name;

  ExpenseCategory({
    required this.id,
    required this.name,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
      };

  factory ExpenseCategory.fromJson(Map<String, dynamic> json) => ExpenseCategory(
        id: json['id'],
        name: json['name'],
      );
}

// Dữ liệu mẫu
List<User> users = [
  User(id: 1, name: 'Quan', email: 'quan@gmail.com', password: '12345'),
  User(id: 2, name: 'Hieu', email: 'hieu@gmail.com', password: '12345'),
  User(id: 3, name: 'Cuong', email: 'cuong@gmail.com', password: '12345'),
];

List<IncomeCategory> incomeCategories = [
  IncomeCategory(id: 1, name: 'Lương'),
  IncomeCategory(id: 2, name: 'Làm thêm'),
];

List<ExpenseCategory> expenseCategories = [
  ExpenseCategory(id: 1, name: 'Ăn uống'),
  ExpenseCategory(id: 2, name: 'Xăng xe'),
  ExpenseCategory(id: 3, name: 'Du lịch'),
];

List<Income> incomes = [
  Income(id: 1, description: 'Sinh hoạt phí', amount: 1000000, date: DateTime.now()),
];

List<Expense> expenses = [
  Expense(id: 1, description: 'Ăn uống', amount: 30000, date: DateTime.now()),
  Expense(id: 2, description: 'Xăng xe', amount: 100000, date: DateTime.now()),
];

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'App của Quan, Hieu và Cuong'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int counter = 0;

  double get totalIncome => incomes.fold(0.0, (sum, income) => sum + income.amount);
  double get totalExpense => expenses.fold(0.0, (sum, expense) => sum + expense.amount);

  void incrementCounter() {
    setState(() {
      counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ListView(
          children: [
            const Text('Users:', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 6),
            ...users.map((u) => Text('• ${u.name} — ${u.email}')).toList(),
            const Divider(),

            const Text('Income Categories:', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 6),
            ...incomeCategories.map((c) => Text('• ${c.name}')).toList(),
            const Divider(),

            const Text('Expense Categories:', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 6),
            ...expenseCategories.map((c) => Text('• ${c.name}')).toList(),
            const Divider(),

            Text('Incomes (Tổng: ${totalIncome.toStringAsFixed(0)}):', style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 6),
            ...incomes.map((i) => Text('• [${i.id}] ${i.description} — ${i.amount.toStringAsFixed(0)} — ${i.date.toLocal().toString().split(".")[0]}')).toList(),
            const Divider(),

            Text('Expenses (Tổng: ${totalExpense.toStringAsFixed(0)}):', style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 6),
            ...expenses.map((e) => Text('• [${e.id}] ${e.description} — ${e.amount.toStringAsFixed(0)} — ${e.date.toLocal().toString().split(".")[0]}')).toList(),
            const SizedBox(height: 24),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Thêm dữ liệu',
        onPressed: () {
          setState(() {
            final newId = expenses.isEmpty ? 1 : expenses.last.id + 1;
            expenses.add(Expense(
              id: newId,
              description: 'Chi thử $newId',
              amount: 5000.0 + newId,
              date: DateTime.now(),
            ));
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
