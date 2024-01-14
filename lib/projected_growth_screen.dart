import 'dart:math'; // Add import for the 'pow' function

import 'package:flutter/material.dart';
import 'welcome_screen.dart';

class ProjectedGrowthScreen extends StatefulWidget {
  final double expectedPercentReturn;
  final double initialSalaryMultiplier = 0.2; // Set your desired multiplier here

  ProjectedGrowthScreen({required this.expectedPercentReturn});

  @override
  _ProjectedGrowthScreenState createState() => _ProjectedGrowthScreenState();
}

class _ProjectedGrowthScreenState extends State<ProjectedGrowthScreen> {
  int selectedDuration = 10; // Default duration is 10 years
  List<DataRow> tableData = [];

  @override
  void initState() {
    super.initState();
    _updateTableData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Projected Growth',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildDurationDropdown(),
              DataTable(
                headingRowHeight: 40,
                dataRowHeight: 60,
                columns: [
                  DataColumn(
                    label: Text(
                      'Year',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Future Value',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
                rows: tableData,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDurationDropdown() {
    return DropdownButton<int>(
      value: selectedDuration,
      items: [5, 10, 20].map((duration) {
        return DropdownMenuItem<int>(
          value: duration,
          child: Text('$duration Y'),
        );
      }).toList(),
      onChanged: (value) {
        setState(() {
          selectedDuration = value!;
          _updateTableData();
        });
      },
    );
  }

  void _updateTableData() {
    setState(() {
      tableData = generateTableData(selectedDuration);
    });
  }

  List<DataRow> generateTableData(int years) {
    List<DataRow> data = [];
    double initialSalary = widget.initialSalaryMultiplier * Variables.salary;
    int step = (years == 5) ? 1 : (years == 10) ? 2 : 4;

    for (int year = 0; year <= years; year += step) {
      double futureValue = initialSalary * pow((1 + widget.expectedPercentReturn / 100), year.toDouble());
      data.add(DataRow(
        cells: [
          DataCell(
            Text(
              year.toString(),
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          DataCell(
            Text(
              futureValue.toStringAsFixed(2),
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ));
    }

    return data;
  }
}
