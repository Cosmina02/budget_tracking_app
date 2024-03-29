import 'package:budget_tracker/controllers/db_helper.dart';
import 'package:budget_tracker/pages/homepage.dart';
import 'package:flutter/material.dart';
import 'package:budget_tracker/static.dart' as Static;

class AddName extends StatefulWidget {
  const AddName({Key? key}) : super(key: key);

  @override
  _AddNameState createState() => _AddNameState();
}

class _AddNameState extends State<AddName> {
  //
  DbHelper dbHelper = DbHelper();

  String name = "";

  //
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0.0,
      ),
      //
      backgroundColor: Color(0xffe2e7ef),
      //
      body: Center(
        child: Container(
          width: 400,
          child: Padding(
            padding: const EdgeInsets.all(
              12.0,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white70,
                    borderRadius: BorderRadius.circular(
                      12.0,
                    ),
                  ),
                  padding: const EdgeInsets.all(
                    16.0,
                  ),
                  child: const Icon(
                    Icons.account_balance_wallet_rounded,
                    size: 64,
                    color: Static.PrimaryColor,
                  ),
                ),
                //
                const SizedBox(
                  height: 20.0,
                ),
                //
                const Text(
                  "What should we Call You ?",
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                //
                const SizedBox(
                  height: 20.0,
                ),
                //
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white70,
                    borderRadius: BorderRadius.circular(
                      12.0,
                    ),
                  ),
                  padding: const EdgeInsets.symmetric(
                    vertical: 8.0,
                    horizontal: 16.0,
                  ),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      hintText: "Your Name",
                      border: InputBorder.none,
                    ),
                    style: const TextStyle(
                      fontSize: 20.0,
                    ),
                    maxLength: 12,
                    onChanged: (val) {
                      name = val;
                    },
                  ),
                ),
                //
                const SizedBox(
                  height: 20.0,
                ),
                //
                SizedBox(
                  height: 50.0,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (name.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            action: SnackBarAction(
                              label: "OK",
                              onPressed: () {
                                ScaffoldMessenger.of(context)
                                    .hideCurrentSnackBar();
                              },
                            ),
                            backgroundColor: Colors.white,
                            content: const Text(
                              "Please Enter a name",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18.0,
                              ),
                            ),
                          ),
                        );
                      } else {
                        DbHelper dbHelper = DbHelper();
                        await dbHelper.addName(name);
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => HomePage(),
                          ),
                        );
                      }
                    },
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            12.0,
                          ),
                        ),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          "Let's Start",
                          style: TextStyle(
                            fontSize: 20.0,
                          ),
                        ),
                        SizedBox(
                          width: 8.0,
                        ),
                        Icon(
                          Icons.arrow_right_alt,
                          size: 24.0,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
