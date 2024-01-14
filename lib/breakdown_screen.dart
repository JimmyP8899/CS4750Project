import 'package:flutter/material.dart';

class BreakdownScreen extends StatefulWidget {
  final double salary;

  BreakdownScreen({required this.salary});

  @override
  _BreakdownScreenState createState() => _BreakdownScreenState();
}

class _BreakdownScreenState extends State<BreakdownScreen> {
  bool isMonthlySelected = false;

  @override
  Widget build(BuildContext context) {
    double needs = calculateNeeds();
    double wants = calculateWants();
    double savings = calculateSavings();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Breakdown',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.only(bottom: 300),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '50-30-20 Rule',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Text(
                'Total Salary: \$${widget.salary.toStringAsFixed(2)}',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 20),
              DropdownButton<bool>(
                value: isMonthlySelected,
                items: [
                  DropdownMenuItem<bool>(
                    value: false,
                    child: Text('Yearly'),
                  ),
                  DropdownMenuItem<bool>(
                    value: true,
                    child: Text('Monthly'),
                  ),
                ],
                onChanged: (value) {
                  setState(() {
                    isMonthlySelected = value!;
                  });
                },
              ),
              SizedBox(height: 20),
              Text(
                'Needs: \$${formatAmount(needs)}',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 10),
              Text(
                'Wants: \$${formatAmount(wants)}',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 10),
              Text(
                'Savings: \$${formatAmount(savings)}',
                style: TextStyle(fontSize: 18),
              ),
            ],
          ),
        ),
      ),
    );
  }

  double calculateNeeds() {
    return isMonthlySelected ? (widget.salary * 0.50 / 12).roundToDouble() : (widget.salary * 0.50).roundToDouble();
  }

  double calculateWants() {
    return isMonthlySelected ? (widget.salary * 0.30 / 12).roundToDouble() : (widget.salary * 0.30).roundToDouble();
  }

  double calculateSavings() {
    return isMonthlySelected ? (widget.salary * 0.20 / 12).roundToDouble() : (widget.salary * 0.20).roundToDouble();
  }

  String formatAmount(double amount) {
    return amount.toStringAsFixed(2);
  }
}
