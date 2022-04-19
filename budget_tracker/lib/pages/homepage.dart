import 'package:budget_tracker/pages/add_transaction.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 0.0,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => AddTransaction()));
          },
          backgroundColor: Color.fromRGBO(165, 127, 186, 1),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
          child: Icon(
            Icons.add,
            size: 50.0,
          ),
        ),
        body: Center(
          child: Text("No Data!"),
        ));
  }
}
