import 'package:flutter/material.dart';
import 'package:ledge/providers/expense_provider.dart';
import 'package:ledge/screens/add_expense_screen.dart';
import 'package:ledge/screens/settings_screen.dart';
import 'package:ledge/widgets/expense_chart.dart';
import 'package:ledge/widgets/expense_list.dart';
import 'package:ledge/widgets/month_selector.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DashboardScreen extends StatefulWidget {
  final VoidCallback onThemeToggle;

  const DashboardScreen({super.key, required this.onThemeToggle});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  DateTime _selectedMonth = DateTime.now();
  String _currencySymbol = '₹'; // Default to Rupee

  @override
  void initState() {
    super.initState();
    _loadCurrencyPreference();
  }

  void _loadCurrencyPreference() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _currencySymbol = prefs.getString('currencySymbol') ?? '₹';
    });
  }

  void _saveCurrencyPreference(String symbol) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('currencySymbol', symbol);
    setState(() {
      _currencySymbol = symbol;
    });
  }

  void _onMonthChanged(DateTime newMonth) {
    setState(() {
      _selectedMonth = newMonth;
    });
  }

  @override
  Widget build(BuildContext context) {
    final expenseProvider = Provider.of<ExpenseProvider>(context);
    final monthlyExpenses = expenseProvider.getExpensesForMonth(_selectedMonth);
    final totalExpenses = expenseProvider.getTotalExpensesForMonth(_selectedMonth);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Ledge'),
        centerTitle: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SettingsScreen(
                    currentCurrency: _currencySymbol,
                    onCurrencyChanged: _saveCurrencyPreference,
                    onThemeToggle: widget.onThemeToggle,
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MonthSelector(
                selectedMonth: _selectedMonth,
                onMonthChanged: _onMonthChanged,
              ),
              const SizedBox(height: 24),
              _buildTotalCard(totalExpenses, _selectedMonth),
              const SizedBox(height: 24),
              ExpenseChart(
                expenses: monthlyExpenses,
                selectedMonth: _selectedMonth,
                currencySymbol: _currencySymbol,
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Recent Transactions',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      // TODO: Implement view all transactions
                    },
                    child: const Text('View All'),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              ExpenseList(
                expenses: monthlyExpenses,
                onExpenseDeleted: (id) {
                  expenseProvider.deleteExpense(id);
                },
                currencySymbol: _currencySymbol,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddExpenseScreen(currencySymbol: _currencySymbol),
            ),
          );
          
          if (result == true) {
            // Refresh the UI if an expense was added
            setState(() {});
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildTotalCard(double total, DateTime month) {
    return Card(
      elevation: 4,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Theme.of(context).brightness == Brightness.light
                  ? Colors.black
                  : const Color(0xFF262626),
              Theme.of(context).brightness == Brightness.light
                  ? const Color(0xFF262626)
                  : Colors.black,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Total Expenses',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.white70,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              NumberFormat.currency(symbol: _currencySymbol).format(total),
              style: const TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              DateFormat.yMMMM().format(month),
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.white70,
              ),
            ),
          ],
        ),
      ),
    );
  }
}