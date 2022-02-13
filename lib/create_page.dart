import 'dart:math';
import 'expense_class.dart'; //custom defined

import 'package:flutter/material.dart';
import 'dart:async';
import 'package:fake_async/fake_async.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/services.dart';

//void main() => runApp(MyApp());

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final appTitle = 'Flutter Form Demo';
//     return MaterialApp(
//       title: appTitle,
//       home: Scaffold(
//         appBar: AppBar(
//           title: Text(appTitle),
//         ),
//         body: MyCustomForm(),
//       ),
//     );
//   }
// }

// Create a Form widget.
class MyCustomForm extends StatefulWidget {
  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
    State<StatefulWidget> createState() => new MyCustomFormState();
  }
}

// Create a corresponding State class, which holds data related to the form.
class MyCustomFormState extends State<MyCustomForm> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  final _formKey = GlobalKey<FormState>();
  final items = ['category1', 'category2', 'category3'];
  String? value;

  TextEditingController amountController = TextEditingController();   //add class and object to store this variables
  TextEditingController dateController = TextEditingController();   //store the terminal info in object
  //TextEditingController categoryController = TextEditingController(); //store selected category

  @override
  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
        value: item,
        child: Text(
          item,
          style: TextStyle(
              //fontWeight: FontWeight.bold,
              color: Colors.black87),
        ),
      );

  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          //Date
          Container(
            margin: EdgeInsets.fromLTRB(10, 30, 50, 0),
            child: TextFormField(
              controller: dateController,
              decoration: const InputDecoration(
                icon: const Icon(Icons.calendar_view_day_rounded),
                hintText: 'Enter Date',
                labelText: 'Date',
              ),
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter valid date';
                }
                return null;
              },
            ),
          ),

          //Kharcha
          Container(
            margin: EdgeInsets.fromLTRB(10, 10, 50, 0),
            child: TextFormField(
              controller: amountController,
              decoration: const InputDecoration(
                fillColor: Colors.brown,
                focusColor: Colors.black,
                icon: const Icon(Icons.money),
                hintText: 'Enter amount',
                labelText: 'Amount',
              ),

              // next 3 lines of code are to open numerical keyboard, and not character keyboard
              // so that parsing amount input(text) into num wont throw exception
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly],

              validator: (String? value) {
                if (value!.isEmpty) {
                  return 'Please enter valid amount';
                }
                return null;

              },
            ),
          ),

          //category
          Container(
            margin: EdgeInsets.fromLTRB(50, 20, 50, 0),
            padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.blueAccent,
                width: 2,
              ),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Center(
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  hint: Text("Select Category"),
                  isExpanded: true,
                  value: value,
                  items: items.map(buildMenuItem).toList(),
                  onChanged: (value) => setState(
                    () => this.value = value,
                  ),
                ),
              ),
            ),
          ),

          //Save button
          Container(
            //height: 50,
            // decoration: BoxDecoration(
            //     border: Border.all(color: Colors.blueAccent, width: 2,),
            //     borderRadius: BorderRadius.circular(50)
            // ),
            margin: EdgeInsets.fromLTRB(120, 50, 120, 0),
            //padding: EdgeInsets.fromLTRB(50, 0, 10, 0),
            //padding: EdgeInsets.only(left: 220, top: 20),
            child: Center(
              child: TextButton(
                child: Text("Save", style: TextStyle(fontSize: 15)),
                style: ButtonStyle(
                  // margin: EdgeInsets.all(100),
                  padding:
                      MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(15)),
                  foregroundColor: MaterialStateProperty.all<Color>(Colors.red),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          side: BorderSide(color: Colors.red))),
                ),
                onPressed: () async {

                  var data1 = Expense_class(dateController.text, amountController.text, value);

                  // print(dateController.text);
                  // print(amountController.text);
                  // print(value);

                  // It returns true if the form is valid, otherwise returns false
                  if (_formKey.currentState!.validate()) {
                    // await Future<String>.delayed(const Duration(seconds: 2));
                    // If the form is valid, display a Snackbar.
                    Scaffold.of(context).showSnackBar(
                        SnackBar(content: Text('Data is in processing.')));
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}