import 'package:budget_tracker/controllers/db_helper.dart';
import 'package:budget_tracker/pages/add_transaction.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:budget_tracker/static.dart' as Static;

class HomePage2 extends StatefulWidget {
  const HomePage2({Key? key}) : super(key: key);

  @override
  State<HomePage2> createState() => _HomePage2State();
}

DbHelper dbHelper = DbHelper();
int totalBalance = 0;
int totalIncome = 0;
int totalExpenses = 0;
String category = "Bills";
bool changedCat = false;
bool changedMon = false;
List<String> categories = ["Bills", "Groceries", "Entertainment", "Other"];
int choosenMonth = DateTime.now().month;
List<String> months = [
  "Jan",
  "Feb",
  "Mar",
  "Apr",
  "May",
  "Jun",
  "Jul",
  "Aug",
  "Sep",
  "Oct",
  "Nov",
  "Dec"
];

class _HomePage2State extends State<HomePage2> {
  getTotalBalance(Map entireData) {
    totalBalance = 0;
    totalIncome = 0;
    totalExpenses = 0;
    entireData.forEach((key, value) {
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
    final currentWidth = MediaQuery.of(context).size.width;
    print(currentWidth);
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

              if (currentWidth > 700) {
                return ListView(
                  children: [
                    welcomeCard(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Column(
                          children: [
                            balanceCard(currentWidth, totalBalance, totalIncome,
                                totalExpenses),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: const [
                                Padding(
                                    padding: EdgeInsets.all(12.0),
                                    child: Text("Recent Transactions",
                                        style: TextStyle(
                                          fontSize: 32.0,
                                          color: Colors.black87,
                                          fontWeight: FontWeight.w900,
                                        ))),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: const [
                                Padding(
                                    padding: EdgeInsets.all(12.0),
                                    child: Text("Filter by:",
                                        style: TextStyle(
                                          fontSize: 25.0,
                                          fontWeight: FontWeight.w500,
                                        ))),
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              textDirection: TextDirection.ltr,
                              children: [
                                Row(
                                  children: [
                                    const SizedBox(width: 15.0),
                                    const Text(
                                      "Category: ",
                                      style: TextStyle(fontSize: 23.0),
                                    ),
                                    SizedBox(width: 15.0),
                                    SizedBox(
                                      height: 24.0,
                                      width: 200.0,
                                      child: DropdownButton<String>(
                                        isExpanded: true,
                                        // style: const TextStyle(fontSize: 6),
                                        value: category,
                                        icon: const Icon(
                                            Icons.keyboard_arrow_down),
                                        items: categories
                                            .map<DropdownMenuItem<String>>(
                                                (String category) {
                                          return DropdownMenuItem<String>(
                                            value: category,
                                            child: Text(
                                              category,
                                              style:
                                                  const TextStyle(fontSize: 22),
                                            ),
                                          );
                                        }).toList(),
                                        onChanged: (String? newValue) {
                                          setState(() {
                                            category = newValue!;
                                            changedCat = true;
                                          });
                                        },
                                      ),
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 15.0,
                                ),
                                Row(
                                  children: [
                                    const SizedBox(width: 15.0),
                                    const Text(
                                      "Month: ",
                                      style: TextStyle(fontSize: 23.0),
                                    ),
                                    SizedBox(width: 15.0),
                                    SizedBox(
                                      height: 24.0,
                                      width: 200.0,
                                      child: DropdownButton<String>(
                                        isExpanded: true,
                                        value: months[choosenMonth - 1],
                                        icon: const Icon(
                                            Icons.keyboard_arrow_down),
                                        items: months
                                            .map<DropdownMenuItem<String>>(
                                                (String month) {
                                          return DropdownMenuItem<String>(
                                            value: month,
                                            child: Text(
                                              month,
                                              style:
                                                  const TextStyle(fontSize: 22),
                                            ),
                                          );
                                        }).toList(),
                                        onChanged: (String? newValue) {
                                          setState(() {
                                            choosenMonth =
                                                months.indexOf(newValue!) + 1;
                                            changedMon = true;
                                          });
                                        },
                                      ),
                                    )
                                  ],
                                ),
                                Container(
                                  padding: EdgeInsets.only(
                                      left: 20.0, right: 180.0, top: 10.0),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8.0)),
                                  child: TextButton(
                                    style: TextButton.styleFrom(
                                      primary: Colors.black87,
                                      backgroundColor:
                                          Color.fromARGB(203, 200, 168, 216),
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        changedCat = false;
                                        changedMon = false;
                                      });
                                    },
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: const [
                                        Text(
                                          "Remove filter",
                                          style: TextStyle(fontSize: 22.0),
                                        ),
                                        SizedBox(
                                          width: 8.0,
                                        ),
                                        Icon(
                                          Icons.cancel_outlined,
                                          size: 24.0,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                    ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: snapshot.data!.length,
                        itemBuilder: ((context, index) {
                          Map dataAtIndex = snapshot.data![index];
                          return verify(dataAtIndex, changedCat, category,
                              changedMon, choosenMonth);
                        }))
                  ],
                );
              } else {
                return ListView(
                  children: [
                    welcomeCard(),
                    balanceCard(
                        currentWidth, totalBalance, totalIncome, totalExpenses),
                    const Padding(
                        padding: EdgeInsets.all(12.0),
                        child: Text("Recent Transactions",
                            style: TextStyle(
                              fontSize: 32.0,
                              color: Colors.black87,
                              fontWeight: FontWeight.w900,
                            ))),
                    const Padding(
                        padding: EdgeInsets.all(12.0),
                        child: Text("Filter by:",
                            style: TextStyle(
                              fontSize: 25.0,
                              fontWeight: FontWeight.w500,
                            ))),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      textDirection: TextDirection.ltr,
                      children: [
                        Row(
                          children: [
                            const SizedBox(width: 15.0),
                            const Text(
                              "Category: ",
                              style: TextStyle(fontSize: 23.0),
                            ),
                            SizedBox(width: 15.0),
                            SizedBox(
                              height: 24.0,
                              width: 200.0,
                              child: DropdownButton<String>(
                                isExpanded: true,
                                // style: const TextStyle(fontSize: 6),
                                value: category,
                                icon: const Icon(Icons.keyboard_arrow_down),
                                items: categories.map<DropdownMenuItem<String>>(
                                    (String category) {
                                  return DropdownMenuItem<String>(
                                    value: category,
                                    child: Text(
                                      category,
                                      style: const TextStyle(fontSize: 22),
                                    ),
                                  );
                                }).toList(),
                                onChanged: (String? newValue) {
                                  setState(() {
                                    category = newValue!;
                                    changedCat = true;
                                  });
                                },
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        Row(
                          children: [
                            const SizedBox(width: 15.0),
                            const Text(
                              "Month: ",
                              style: TextStyle(fontSize: 23.0),
                            ),
                            SizedBox(width: 15.0),
                            SizedBox(
                              height: 24.0,
                              width: 200.0,
                              child: DropdownButton<String>(
                                isExpanded: true,
                                value: months[choosenMonth - 1],
                                icon: const Icon(Icons.keyboard_arrow_down),
                                items: months.map<DropdownMenuItem<String>>(
                                    (String month) {
                                  return DropdownMenuItem<String>(
                                    value: month,
                                    child: Text(
                                      month,
                                      style: const TextStyle(fontSize: 22),
                                    ),
                                  );
                                }).toList(),
                                onChanged: (String? newValue) {
                                  setState(() {
                                    choosenMonth =
                                        months.indexOf(newValue!) + 1;
                                    changedMon = true;
                                  });
                                },
                              ),
                            )
                          ],
                        ),
                        Container(
                          padding: EdgeInsets.only(
                              left: 20.0, right: 180.0, top: 10.0),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.0)),
                          child: TextButton(
                            style: TextButton.styleFrom(
                              primary: Colors.black87,
                              backgroundColor:
                                  Color.fromARGB(203, 200, 168, 216),
                            ),
                            onPressed: () {
                              setState(() {
                                changedCat = false;
                                changedMon = false;
                              });
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: const [
                                Text(
                                  "Remove filter",
                                  style: TextStyle(fontSize: 22.0),
                                ),
                                SizedBox(
                                  width: 8.0,
                                ),
                                Icon(
                                  Icons.cancel_outlined,
                                  size: 24.0,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: snapshot.data!.length,
                        itemBuilder: ((context, index) {
                          Map dataAtIndex = snapshot.data![index];
                          return verify(dataAtIndex, changedCat, category,
                              changedMon, choosenMonth);
                        }))
                  ],
                );
              }
            } else {
              return Center(child: Text('Unexpected error!'));
            }
          },
        ));
  }
}

Widget welcomeCard() {
  return Padding(
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
  );
}

Widget balanceCard(
    double currentWidth, int totalBalance, int totalIncome, int totalExpense) {
  return Container(
    width: currentWidth > 700 ? currentWidth * 0.3 : currentWidth * 0.9,
    margin: const EdgeInsets.all(12.0),
    child: Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Static.PrimaryColor, Colors.blueAccent],
          ),
          borderRadius: BorderRadius.all(Radius.circular(24.0))),
      padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 8.0),
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
              fontSize: 22.0, fontWeight: FontWeight.w700, color: Colors.white),
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
                cardExpense(totalExpense.toString())
              ],
            ))
      ]),
    ),
  );
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

Widget expenseTile(int value, String category) {
  return Container(
      margin: const EdgeInsets.all(8.0),
      padding: const EdgeInsets.all(18.0),
      decoration: BoxDecoration(
          color: Color.fromARGB(94, 165, 127, 186),
          borderRadius: BorderRadius.circular(8.0)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Row(
                children: [
                  Icon(
                    Icons.arrow_circle_up_outlined,
                    size: 28.0,
                    color: Colors.red[700],
                  ),
                  const SizedBox(
                    width: 4.0,
                  ),
                  const Text(
                    "Expense",
                    style: TextStyle(fontSize: 20.0),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(3.0),
                child: Text(
                  category,
                  style: const TextStyle(fontSize: 15.0),
                ),
              )
            ],
          ),
          Text(
            "- $value lei",
            style: const TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.w700,
            ),
          )
        ],
      ));
}

Widget incomeTile(int value, String category) {
  return Container(
      margin: EdgeInsets.all(8.0),
      padding: EdgeInsets.all(18.0),
      decoration: BoxDecoration(
          color: Color.fromARGB(94, 165, 127, 186),
          borderRadius: BorderRadius.circular(8.0)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Row(
                children: [
                  Icon(
                    Icons.arrow_circle_down_outlined,
                    size: 28.0,
                    color: Colors.green[700],
                  ),
                  const SizedBox(
                    width: 4.0,
                  ),
                  const Text(
                    "Income",
                    style: TextStyle(fontSize: 20.0),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(3.0),
                child: Text(
                  category,
                  style: const TextStyle(fontSize: 15.0),
                ),
              )
            ],
          ),
          Text(
            "+ $value lei",
            style: const TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.w700,
            ),
          )
        ],
      ));
}

Widget verify(
    data, bool changedCat, String category, bool changedMon, int choosenMonth) {
  if (changedCat == true && data['category'] == category) {
    if (data['type'] == 'Income') {
      return incomeTile(data['amount'], data['category']);
    } else {
      return expenseTile(data['amount'], data['category']);
    }
  } else if (changedMon == true && data['date'].month == choosenMonth) {
    if (data['type'] == 'Income') {
      return incomeTile(data['amount'], data['category']);
    } else {
      return expenseTile(data['amount'], data['category']);
    }
  } else if (changedCat == false && changedMon == false) {
    if (data['type'] == 'Income') {
      return incomeTile(data['amount'], data['category']);
    } else {
      return expenseTile(data['amount'], data['category']);
    }
  } else {
    bool isVisible = false;
    return Visibility(visible: isVisible, child: Text("Data not valid"));
  }
}
