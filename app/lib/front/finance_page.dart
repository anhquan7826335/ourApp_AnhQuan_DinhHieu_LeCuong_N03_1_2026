import 'package:flutter/material.dart';

class FinancePage extends StatefulWidget {
  const FinancePage({super.key});

  @override
  State<FinancePage> createState() => _FinancePageState();
}

class _FinancePageState extends State<FinancePage> {
  // Dữ liệu mẫu
  final List<Map<String, dynamic>> _transactions = [
    {'id': 1, 'type': 'income', 'title': 'Lương tháng 4', 'amount': 15000000, 'date': DateTime(2026, 4, 1), 'category': 'Lương'},
    {'id': 2, 'type': 'expense', 'title': 'Tiền thuê nhà', 'amount': 3000000, 'date': DateTime(2026, 4, 5), 'category': 'Nhà cửa'},
    {'id': 3, 'type': 'expense', 'title': 'Ăn trưa', 'amount': 50000, 'date': DateTime(2026, 4, 10), 'category': 'Ăn uống'},
    {'id': 4, 'type': 'expense', 'title': 'Xăng xe', 'amount': 200000, 'date': DateTime(2026, 4, 12), 'category': 'Di chuyển'},
    {'id': 5, 'type': 'income', 'title': 'Làm thêm', 'amount': 2000000, 'date': DateTime(2026, 4, 15), 'category': 'Thu nhập phụ'},
    {'id': 6, 'type': 'expense', 'title': 'Mua sắm', 'amount': 500000, 'date': DateTime(2026, 4, 20), 'category': 'Mua sắm'},
  ];

  double get totalIncome => _transactions
      .where((t) => t['type'] == 'income')
      .fold(0.0, (sum, t) => sum + (t['amount'] as double));

  double get totalExpense => _transactions
      .where((t) => t['type'] == 'expense')
      .fold(0.0, (sum, t) => sum + (t['amount'] as double));

  double get balance => totalIncome - totalExpense;

  void _showAddTransactionDialog(bool isIncome) {
    final titleController = TextEditingController();
    final amountController = TextEditingController();
    String selectedCategory = isIncome ? 'Lương' : 'Ăn uống';

    final incomeCategories = ['Lương', 'Thu nhập phụ', 'Đầu tư', 'Khác'];
    final expenseCategories = ['Ăn uống', 'Di chuyển', 'Nhà cửa', 'Mua sắm', 'Giải trí', 'Khác'];

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(isIncome ? 'Thêm thu' : 'Thêm chi'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: const InputDecoration(
                  labelText: 'Mô tả',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: amountController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Số tiền',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: selectedCategory,
                decoration: const InputDecoration(
                  labelText: 'Danh mục',
                  border: OutlineInputBorder(),
                ),
                items: (isIncome ? incomeCategories : expenseCategories)
                    .map((c) => DropdownMenuItem(value: c, child: Text(c)))
                    .toList(),
                onChanged: (value) {
                  selectedCategory = value!;
                },
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Hủy'),
          ),
          ElevatedButton(
            onPressed: () {
              if (titleController.text.isNotEmpty && amountController.text.isNotEmpty) {
                setState(() {
                  _transactions.add({
                    'id': _transactions.length + 1,
                    'type': isIncome ? 'income' : 'expense',
                    'title': titleController.text,
                    'amount': double.parse(amountController.text),
                    'date': DateTime.now(),
                    'category': selectedCategory,
                  });
                });
                Navigator.pop(context);
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: isIncome ? Colors.green : Colors.red,
            ),
            child: Text(isIncome ? 'Thêm thu' : 'Thêm chi'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quản lý Thu Chi'),
        backgroundColor: Colors.indigo,
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Tổng quan tài chính
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.indigo, Colors.indigo[700]!],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Column(
                children: [
                  const Text(
                    'Số dư hiện tại',
                    style: TextStyle(color: Colors.white70, fontSize: 16),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '${balance.toStringAsFixed(0)} đ',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildSummaryItem('Thu', totalIncome, Colors.green[100]!, Colors.green[700]!),
                      _buildSummaryItem('Chi', totalExpense, Colors.red[100]!, Colors.red[700]!),
                    ],
                  ),
                ],
              ),
            ),

            // Nút thêm thu/chi
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () => _showAddTransactionDialog(true),
                      icon: const Icon(Icons.add),
                      label: const Text('Thu'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () => _showAddTransactionDialog(false),
                      icon: const Icon(Icons.remove),
                      label: const Text('Chi'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Danh sách giao dịch
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Lịch sử giao dịch',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const Text('Xem tất cả'),
                  ),
                ],
              ),
            ),

            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _transactions.length,
              itemBuilder: (context, index) {
                final transaction = _transactions[index];
                final isIncome = transaction['type'] == 'income';
                return _buildTransactionTile(transaction, isIncome);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryItem(String label, double amount, Color bgColor, Color textColor) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Text(
            label,
            style: TextStyle(color: textColor, fontSize: 14),
          ),
          const SizedBox(height: 4),
          Text(
            '${amount.toStringAsFixed(0)} đ',
            style: TextStyle(
              color: textColor,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTransactionTile(Map<String, dynamic> transaction, bool isIncome) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: ListTile(
        leading: Container(
          width: 45,
          height: 45,
          decoration: BoxDecoration(
            color: isIncome ? Colors.green[100] : Colors.red[100],
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            isIncome ? Icons.arrow_upward : Icons.arrow_downward,
            color: isIncome ? Colors.green[700] : Colors.red[700],
          ),
        ),
        title: Text(
          transaction['title'],
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        subtitle: Text(
          '${transaction['category']} • ${_formatDate(transaction['date'])}',
          style: TextStyle(color: Colors.grey[600], fontSize: 12),
        ),
        trailing: Text(
          '${isIncome ? '+' : '-'}${transaction['amount'].toStringAsFixed(0)} đ',
          style: TextStyle(
            color: isIncome ? Colors.green[700] : Colors.red[700],
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}