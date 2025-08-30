import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:ledge/models/expense.dart';
import 'package:intl/intl.dart';

class ExpenseChart extends StatelessWidget {
  final List<Expense> expenses;
  final DateTime selectedMonth;
  final String currencySymbol;

  const ExpenseChart({
    super.key,
    required this.expenses,
    required this.selectedMonth,
    required this.currencySymbol,
  });

  // Vibrant colors for data visualization
  static const List<Color> chartColors = [
    Color(0xFF10B981), // Emerald Green
    Color(0xFF3B82F6), // Electric Blue
    Color(0xFFF59E0B), // Warm Orange
    Color(0xFF8B5CF6), // Purple
    Color(0xFFF97316), // Coral Red
    Color(0xFFEAB308), // Golden Yellow
    Color(0xFFEC4899), // Pink
    Color(0xFF06B6D4), // Cyan
  ];

  @override
  Widget build(BuildContext context) {
    if (expenses.isEmpty) {
      return _buildEmptyChart();
    }

    final categoryTotals = <String, double>{};
    double totalAmount = 0;

    // Calculate totals by category
    for (final expense in expenses) {
      final categoryName = expense.category.name;
      if (categoryTotals.containsKey(categoryName)) {
        categoryTotals[categoryName] = categoryTotals[categoryName]! + expense.amount;
      } else {
        categoryTotals[categoryName] = expense.amount;
      }
      totalAmount += expense.amount;
    }

    // Convert to list and sort by amount (descending)
    final sortedCategories = categoryTotals.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Spending by Category',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 250,
          child: Row(
            children: [
              Expanded(
                flex: 3,
                child: _buildPieChart(sortedCategories, totalAmount),
              ),
              const SizedBox(width: 20),
              Expanded(
                flex: 2,
                child: _buildLegend(sortedCategories),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildEmptyChart() {
    return Builder(
      builder: (context) {
        final isDarkMode = Theme.of(context).brightness == Brightness.dark;
        
        return Container(
          height: 250,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: isDarkMode ? const Color(0xFF262626) : const Color(0xFFF8F8F8),
            borderRadius: BorderRadius.circular(16),
          ),
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.pie_chart,
                size: 48,
                color: Color(0xFFD4D4D4),
              ),
              SizedBox(height: 16),
              Text(
                'No data to display',
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xFFA3A3A3),
                ),
              ),
            ],
          ),
        );
      }
    );
  }

  Widget _buildPieChart(List<MapEntry<String, double>> categories, double totalAmount) {
    return PieChart(
      PieChartData(
        sectionsSpace: 2,
        centerSpaceRadius: 50,
        sections: _showingSections(categories, totalAmount),
        // Make the chart start from the top
        startDegreeOffset: -90,
      ),
    );
  }

  Widget _buildLegend(List<MapEntry<String, double>> categories) {
    return ListView.builder(
      itemCount: categories.length,
      itemBuilder: (context, index) {
        final categoryEntry = categories[index];
        final categoryName = categoryEntry.key;
        final categoryAmount = categoryEntry.value;
        
        // Get color for this index (cycle through colors if more categories than colors)
        final colorIndex = index % chartColors.length;
        final color = chartColors[colorIndex];

        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          child: Row(
            children: [
              Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  color: color,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  categoryName,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Text(
                NumberFormat.currency(symbol: currencySymbol).format(categoryAmount),
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  List<PieChartSectionData> _showingSections(
      List<MapEntry<String, double>> categories, double totalAmount) {
    return List.generate(categories.length, (i) {
      final categoryEntry = categories[i];
      final categoryAmount = categoryEntry.value;
      final percentage = totalAmount > 0 ? (categoryAmount / totalAmount) * 100 : 0;

      // Get color for this index (cycle through colors if more categories than colors)
      final colorIndex = i % chartColors.length;
      final color = chartColors[colorIndex];

      return PieChartSectionData(
        color: color,
        value: categoryAmount,
        title: '${percentage.toStringAsFixed(0)}%',
        radius: 50,
        titleStyle: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      );
    });
  }
}