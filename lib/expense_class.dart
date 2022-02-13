class Expense_class {
  String? date, category, amt;
  num? amount;

  Expense_class(this.date, amt, this.category) {
    amount = int.parse(amt);  // parsing amount string text into int(already taken from numerical keyboard)
    print(date);
    print(amount);
    print(category);
    print("data stored in a Expense_class object");
  }
}