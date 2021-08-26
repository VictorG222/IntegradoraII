import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:time_chart/time_chart.dart';


void main() => runApp(const Dashboard());

/// This is the main application widget.
class Dashboard extends StatelessWidget {
  const Dashboard({Key? key}) : super(key: key);

  static const String _title = 'Monitoreo';

  @override
  Widget build(BuildContext context) {
    final _mediaSize = MediaQuery.of(context).size.height;
    return Material(
      child: Stack(
        children: [
          MyStatefulWidget(),
          Movimientos(),
        ],
      ),
    );
  }
}

class Movimientos extends StatelessWidget{

  final data = [
    DateTimeRange(
      start: DateTime(2021,2,24,23,15),
      end: DateTime(2021,2,25,7,30),
    ),
    DateTimeRange(
      start: DateTime(2021,2,22,1,55),
      end: DateTime(2021,2,22,9,12),
    ),
    DateTimeRange(
      start: DateTime(2021,2,20,0,25),
      end: DateTime(2021,2,20,7,34),
    ),
    DateTimeRange(
      start: DateTime(2021,2,17,21,23),
      end: DateTime(2021,2,18,4,52),
    ),
    DateTimeRange(
      start: DateTime(2021,2,13,6,32),
      end: DateTime(2021,2,13,13,12),
    ),
    DateTimeRange(
      start: DateTime(2021,2,1,9,32),
      end: DateTime(2021,2,1,15,22),
    ),
    DateTimeRange(
      start: DateTime(2021,1,22,12,10),
      end: DateTime(2021,1,22,16,20),
    ),
  ];

  get sizedBox => null;


 @override
  Widget build(BuildContext context) {
    final sizedBox = const SizedBox(height: 16);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Center(
        child: Scaffold(
          appBar: AppBar(title: Center(child: const Text('Registro de Actividad'),),
          backgroundColor:  Colors.cyan[900],),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  const Text('Monitoreo semanal de Sensor de Movimiento'),
                  TimeChart(
                    data: data,
                    viewMode: ViewMode.monthly,
                    barColor: Colors.cyan[800],
                  ),
                  sizedBox,


                  const Text('Monitoreo Mensual de Sensor de Movimiento'),
                  TimeChart(
                    data: data,
                    viewMode: ViewMode.weekly,
                    barColor: Colors.cyan[800],
                  ),
                  
                  
                  sizedBox,
                
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// This is the stateful widget that the main application instantiates.
class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

/// This is the private State class that goes with MyStatefulWidget.
class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  int _selectedIndex = 1;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    if (index == 2) {
      Navigator.pushNamed(context, '/login');
    }
    if (index == 1) {
      Navigator.pushNamed(context, '/dashboard');
    }
  }

  @override
  Widget build(BuildContext context) {
    final _mediaSize = MediaQuery.of(context).size.height;
    return Scaffold(
      bottomNavigationBar: SizedBox(
        height: 0.1 * _mediaSize,
        child: BottomNavigationBar(
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined, size: 0.05 * _mediaSize),
              label: 'Home',
              backgroundColor: Colors.blue,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.bar_chart_outlined, size: 0.05 * _mediaSize),
              label: 'Movimientos',
              backgroundColor: Colors.blue,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.logout_outlined, size: 0.05 * _mediaSize),
              label: 'Logout',
              backgroundColor: Colors.blue,
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.blue,
          onTap: _onItemTapped,
          selectedLabelStyle:
              TextStyle(fontSize: 0.02 * _mediaSize),
          unselectedLabelStyle:
              TextStyle(fontSize: 0.02 * _mediaSize),
        ),
      ),
    );
  }
}
