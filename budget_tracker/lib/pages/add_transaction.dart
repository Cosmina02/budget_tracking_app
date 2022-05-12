import 'package:budget_tracker/controllers/db_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:budget_tracker/static.dart' as Static;

class AddTransaction extends StatefulWidget {
  const AddTransaction({Key? key}) : super(key: key);

  @override
  State<AddTransaction> createState() => _AddTransactionState();
}

class _AddTransactionState extends State<AddTransaction> {
  int? amount;
  String type = "Income";
  String category = 'Category';
  DateTime selectedDate = DateTime.now();
  List<String> categories = [
    'Category',
    "Bills",
    "Groceries",
    "Entertainment",
    "Other"
  ];
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

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2021, 12),
        lastDate: DateTime(2100, 01));
    if (picked != null && picked != selectedDate) {
      selectedDate = picked;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 0.0,
        ),
        body: ListView(
          padding: EdgeInsets.all(12.0),
          children: [
            const SizedBox(
              height: 20.0,
            ),
            const Text(
              "Add Transaction",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 32.0,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: Static.PrimaryColor,
                      borderRadius: BorderRadius.circular(16.0)),
                  padding: const EdgeInsets.all(12.0),
                  child: const Icon(
                    Icons.attach_money,
                    size: 24.0,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(
                  width: 12.0,
                ),
                Expanded(
                  child: TextField(
                    decoration: const InputDecoration(
                      hintText: "0",
                      border: InputBorder.none,
                    ),
                    style: const TextStyle(
                      fontSize: 24.0,
                    ),
                    onChanged: (val) {
                      try {
                        amount = int.parse(val);
                      } catch (e) {}
                    },
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    keyboardType: TextInputType.number,
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 20.0,
            ),
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: Static.PrimaryColor,
                      borderRadius: BorderRadius.circular(16.0)),
                  padding: const EdgeInsets.all(12.0),
                  child: const Icon(
                    Icons.category_rounded,
                    size: 24.0,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(
                  width: 12.0,
                ),
                SizedBox(
                  height: 24.0,
                  width: 200.0,
                  child: DropdownButton<String>(
                    isExpanded: true,
                    // style: const TextStyle(fontSize: 6),
                    value: category,
                    icon: const Icon(Icons.keyboard_arrow_down),
                    items: categories
                        .map<DropdownMenuItem<String>>((String category) {
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
                      });
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20.0,
            ),
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: Static.PrimaryColor,
                      borderRadius: BorderRadius.circular(16.0)),
                  padding: const EdgeInsets.all(12.0),
                  child: const Icon(
                    Icons.moving_sharp,
                    size: 24.0,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(
                  width: 12.0,
                ),
                ChoiceChip(
                  label: Text(
                    "Income",
                    style: TextStyle(
                        fontSize: 18.0,
                        color: type == "Income" ? Colors.black : Colors.grey),
                  ),
                  selectedColor: Color.fromRGBO(165, 127, 186, 1),
                  selected: type == "Income" ? true : false,
                  onSelected: (val) {
                    if (val) {
                      setState(() {
                        type = "Income";
                      });
                    }
                  },
                ),
                const SizedBox(
                  width: 12.0,
                ),
                ChoiceChip(
                  label: Text(
                    "Expense",
                    style: TextStyle(
                        fontSize: 18.0,
                        color: type == "Expense" ? Colors.black : Colors.grey),
                  ),
                  selectedColor: Color.fromRGBO(165, 127, 186, 1),
                  selected: type == "Expense" ? true : false,
                  onSelected: (val) {
                    if (val) {
                      setState(() {
                        type = "Expense";
                      });
                    }
                  },
                ),
              ],
            ),
            const SizedBox(
              height: 20.0,
            ),
            SizedBox(
              height: 50.0,
              child: TextButton(
                  onPressed: () {
                    _selectDate(context);
                  },
                  style: ButtonStyle(
                      padding: MaterialStateProperty.all(EdgeInsets.zero)),
                  child: Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: Static.PrimaryColor,
                            borderRadius: BorderRadius.circular(16.0)),
                        padding: const EdgeInsets.all(12.0),
                        child: const Icon(
                          Icons.date_range,
                          size: 24.0,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(
                        width: 12.0,
                      ),
                      Text(
                        "${selectedDate.day} ${months[selectedDate.month - 1]}",
                        style: const TextStyle(
                          fontSize: 20.0,
                          color: Color.fromARGB(255, 92, 86, 86),
                        ),
                      ),
                    ],
                  )),
            ),
            const SizedBox(
              height: 20.0,
            ),
            SizedBox(
              height: 50.0,
              child: ElevatedButton(
                onPressed: () async {
                  if (amount != null) {
                    DbHelper dbHelper = DbHelper();
                    await dbHelper.addData(
                        amount!, selectedDate, category, type);
                    Navigator.of(context).pop();
                  } else {
                    print("Not all values provided!");
                  }
                },
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Static.PrimaryColor),
                ),
                child: const Text(
                  "Add",
                  style: TextStyle(
                    fontSize: 20.0,
                  ),
                ),
              ),
            )
          ],
        ));
  }
}
