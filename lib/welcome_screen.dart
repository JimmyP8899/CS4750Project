import 'package:flutter/material.dart';
import 'breakdown_screen.dart';
import 'selections_screen.dart';
import 'projected_growth_screen.dart';

class Variables {
  static double salary = 0.0;
  static double expectedPercentReturn = 0.0;
}

class WelcomeScreen extends StatelessWidget {
  TextEditingController salaryController = TextEditingController();
  TextEditingController percentReturnController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Welcome!',
          style: TextStyle(color: Colors.white),
        ),
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            );
          },
        ),
        backgroundColor: Colors.blue,
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            Container(
              color: Colors.blueAccent,
              child: DrawerHeader(
                child: Center(
                  child: Text(
                    'Menu',
                    style: TextStyle(fontSize: 24, color: Colors.white),
                  ),
                ),
                decoration: BoxDecoration(),
              ),
            ),
            ListTile(
              title: Center(
                child: Text(
                  'Home',
                  style: TextStyle(fontSize: 18),
                ),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Center(
                child: Text(
                  'Breakdown',
                  style: TextStyle(fontSize: 18),
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => BreakdownScreen(salary: Variables.salary)),
                );
              },
            ),
            ListTile(
              title: Center(
                child: Text(
                  'Selections',
                  style: TextStyle(fontSize: 18),
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SelectionsScreen(salary: Variables.salary, expectedPercentReturn: Variables.expectedPercentReturn)),
                );
              },
            ),
            ListTile(
              title: Center(
                child: Text(
                  'Projected Growth',
                  style: TextStyle(fontSize: 18),
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProjectedGrowthScreen(expectedPercentReturn: Variables.expectedPercentReturn),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: salaryController,
              decoration: InputDecoration(
                labelText: 'Enter Salary (\$)',
                labelStyle: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 30),
            TextField(
              controller: percentReturnController,
              decoration: InputDecoration(
                labelText: 'Expected Percent Return (%)',
                labelStyle: TextStyle(fontSize: 18, fontStyle: FontStyle.italic),
              ),
              style: TextStyle(fontSize: 18, fontStyle: FontStyle.italic),
            ),
            SizedBox(height: 60),
            ElevatedButton(
              onPressed: () {
                Variables.salary = double.tryParse(salaryController.text) ?? 0.0;
                Variables.expectedPercentReturn = double.tryParse(percentReturnController.text) ?? 0.0;

                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => BreakdownScreen(salary: Variables.salary)),
                );
              },
              child: Text('Calculate', style: TextStyle(fontSize: 18, color: Colors.blue)),
            ),
          ],
        ),
      ),
    );
  }
}
