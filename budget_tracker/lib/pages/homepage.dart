import 'package:budget_tracker/controllers/db_helper.dart';
import 'package:budget_tracker/pages/add_transaction.dart';
import 'package:flutter/material.dart';
import 'package:budget_tracker/static.dart' as Static;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DbHelper dbHelper = DbHelper();
  int totalBalance = 0;
  int totalIncome = 0;
  int totalExpenses = 0;

  getTotalBalance(Map entireData) {
    totalBalance = 0;
    totalIncome = 0;
    totalExpenses = 0;
    entireData.forEach((key, value) {
      print(key);
      if (value['type'] == 'Income') {
        totalBalance += (value['amount'] as int);
        totalIncome += (value['amount'] as int);
      } else {
        totalBalance -= (value['amount'] as int);
        totalExpenses += (value['amount'] as int);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 0.0,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(
                  builder: (context) => AddTransaction(),
                ))
                .whenComplete(() => {setState(() {})});
          },
          backgroundColor: Color.fromRGBO(165, 127, 186, 1),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
          child: const Icon(
            Icons.add,
            size: 50.0,
          ),
        ),
        body: FutureBuilder<Map>(
          future: dbHelper.fetch(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Center(
                  child: Text(
                "Unexpected error!",
                style: TextStyle(
                  fontSize: 24.0,
                ),
              ));
            }
            if (snapshot.hasData) {
              if (snapshot.data!.isEmpty) {
                return const Center(
                    child: Text(
                  "Unexpected error!",
                  style: TextStyle(
                    fontSize: 24.0,
                  ),
                ));
              }
              getTotalBalance(snapshot.data!);
              return ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12.0),
                                  color: Colors.white70,
                                ),
                                padding: const EdgeInsets.all(12.0),
                                child: const CircleAvatar(
                                  maxRadius: 32.0,
                                  child: Icon(
                                    Icons.person,
                                    size: 32.0,
                                    color: Color(0xff3E454C),
                                  ),
                                )),
                            const SizedBox(
                              width: 8.0,
                            ),
                            Text(
                              "Welcome",
                              style: TextStyle(
                                fontSize: 24.0,
                                fontWeight: FontWeight.w700,
                                color: Static.PrimaryMaterialColor[800],
                              ),
                            )
                          ],
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.0),
                            color: Colors.white70,
                          ),
                          padding: const EdgeInsets.all(12.0),
                          child: const Icon(
                            Icons.settings,
                            size: 32.0,
                            color: Color(0xff3E454C),
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    margin: const EdgeInsets.all(12.0),
                    child: Container(
                      decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Static.PrimaryColor, Colors.blueAccent],
                          ),
                          borderRadius:
                              BorderRadius.all(Radius.circular(24.0))),
                      padding:
                          EdgeInsets.symmetric(vertical: 20.0, horizontal: 8.0),
                      child: Column(children: [
                        const Text(
                          'Total Balance',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 22.0, color: Colors.white),
                        ),
                        const SizedBox(
                          height: 12.0,
                        ),
                        Text(
                          '$totalBalance lei',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontSize: 22.0,
                              fontWeight: FontWeight.w700,
                              color: Colors.white),
                        ),
                        const SizedBox(
                          height: 12.0,
                        ),
                        Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                cardIncome(totalIncome.toString()),
                                cardExpense(totalExpenses.toString())
                              ],
                            ))
                      ]),
                    ),
                  )
                ],
              );
            } else {
              return Center(child: Text('Unexpected error!'));
            }
          },
        ));
  }
}

Widget cardIncome(String value) {
  return Row(
    children: [
      Container(
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(20.0)),
          padding: const EdgeInsets.all(6.0),
          child: Icon(
            Icons.arrow_downward,
            size: 28.0,
            color: Colors.green[700],
          ),
          margin: EdgeInsets.only(right: 8.0)),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Income',
            style: TextStyle(
              fontSize: 14.0,
              color: Colors.white,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          )
        ],
      )
    ],
  );
}

Widget cardExpense(String value) {
  return Row(
    children: [
      Container(
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(20.0)),
          padding: const EdgeInsets.all(6.0),
          child: Icon(
            Icons.arrow_upward,
            size: 28.0,
            color: Colors.red[700],
          ),
          margin: EdgeInsets.only(right: 8.0)),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Expense',
            style: TextStyle(
              fontSize: 14.0,
              color: Colors.white,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          )
        ],
      )
    ],
  );
}
