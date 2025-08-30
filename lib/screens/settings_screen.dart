import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  final String currentCurrency;
  final Function(String) onCurrencyChanged;
  final VoidCallback onThemeToggle;

  const SettingsScreen({
    super.key,
    required this.currentCurrency,
    required this.onCurrencyChanged,
    required this.onThemeToggle,
  });

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  late String _selectedCurrency;

  @override
  void initState() {
    super.initState();
    _selectedCurrency = widget.currentCurrency;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Appearance',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: isDarkMode ? const Color(0xFF171717) : const Color(0xFFF8F8F8),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Dark Mode',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  Switch(
                    value: isDarkMode,
                    onChanged: (value) {
                      widget.onThemeToggle();
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Currency',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            _buildCurrencyOption('₹', 'Indian Rupee'),
            const SizedBox(height: 12),
            _buildCurrencyOption('\$', 'US Dollar'),
            const SizedBox(height: 12),
            _buildCurrencyOption('€', 'Euro'),
            const SizedBox(height: 12),
            _buildCurrencyOption('£', 'British Pound'),
          ],
        ),
      ),
    );
  }

  Widget _buildCurrencyOption(String symbol, String name) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final isSelected = _selectedCurrency == symbol;

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedCurrency = symbol;
        });
        widget.onCurrencyChanged(symbol);
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.only(bottom: 8),
        decoration: BoxDecoration(
          color: isSelected
              ? (isDarkMode ? const Color(0xFF404040) : const Color(0xFFE5E5E5))
              : (isDarkMode ? const Color(0xFF171717) : const Color(0xFFF8F8F8)),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected
                ? (isDarkMode ? Colors.white : Colors.black)
                : Colors.transparent,
            width: 1.5,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                color: isDarkMode ? const Color(0xFF404040) : const Color(0xFFE5E5E5),
                shape: BoxShape.circle,
              ),
              alignment: Alignment.center,
              child: Text(
                symbol,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                name,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  color: isDarkMode ? Colors.white : Colors.black,
                ),
              ),
            ),
            if (isSelected)
              const Icon(
                Icons.check,
                color: Color(0xFF10B981),
              ),
          ],
        ),
      ),
    );
  }
}