import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AddTransaction extends StatefulWidget {
  const AddTransaction({Key? key}) : super(key: key);

  @override
  State<AddTransaction> createState() => _AddTransactionState();
}

class _AddTransactionState extends State<AddTransaction> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 0.0,
        ),
        body: ListView(
          padding: EdgeInsets.all(12.0),
          children: [
            Text(
              "Add Transaction",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 32.0,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: Color.fromRGBO(165, 127, 186, 1),
                      borderRadius: BorderRadius.circular(16.0)),
                  padding: EdgeInsets.all(12.0),
                  child: Icon(
                    Icons.attach_money,
                    size: 24.0,
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  width: 12.0,
                ),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "0",
                      border: InputBorder.none,
                    ),
                    style: TextStyle(
                      fontSize: 24.0,
                    ),
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    keyboardType: TextInputType.number,
                  ),
                )
              ],
            ),
            SizedBox(
              height: 20.0,
            ),
            Row(
              //TODO:un selector pentru categorie in loc de nota pentru tranzactie
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: Color.fromRGBO(165, 127, 186, 1),
                      borderRadius: BorderRadius.circular(16.0)),
                  padding: EdgeInsets.all(12.0),
                  child: Icon(
                    Icons.description,
                    size: 24.0,
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  width: 12.0,
                ),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Note on Transaction",
                      border: InputBorder.none,
                    ),
                    style: TextStyle(
                      fontSize: 24.0,
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 20.0,
            ),
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: Color.fromRGBO(165, 127, 186, 1),
                      borderRadius: BorderRadius.circular(16.0)),
                  padding: EdgeInsets.all(12.0),
                  child: Icon(
                    Icons.moving_sharp,
                    size: 24.0,
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  width: 12.0,
                ),
                ChoiceChip(
                  label: Text("Income"),
                  selectedColor: Color.fromRGBO(165, 127, 186, 1),
                  selected: true,
                ),
                SizedBox(
                  width: 12.0,
                ),
                ChoiceChip(
                  label: Text("Expense"),
                  selected: false,
                )
              ],
            )
          ],
        ));
  }
}
