import 'package:flutter/material.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 79, 129, 154),
        title: const Text('Daily Spend Tracker'),
      ),
      body: SpendEntryForm(),
    );
  }
}

class SpendEntryForm extends StatefulWidget {
  const SpendEntryForm({Key? key}) : super(key: key);

  @override
  _SpendEntryFormState createState() => _SpendEntryFormState();
}

class _SpendEntryFormState extends State<SpendEntryForm> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();

  void _saveSpend() {
    // Get current date and time
    DateTime now = DateTime.now();

    // Get the entered title and amount
    String title = _titleController.text;
    double amount = double.tryParse(_amountController.text) ?? 0.0;

    // Save the spend entry with the current date and time
    // You can replace this with your actual saving logic
    print('Title: $title, Amount: $amount, Date: $now');

    // Clear the text fields after saving
    _titleController.clear();
    _amountController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextField(
            controller: _titleController,
            decoration: InputDecoration(labelText: 'Title'),
          ),
          SizedBox(height: 10),
          TextField(
            controller: _amountController,
            decoration: InputDecoration(labelText: 'Amount'),
            keyboardType: TextInputType.numberWithOptions(decimal: true),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: _saveSpend,
            child: Text('Save'),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }
}

void main() {
  runApp(MaterialApp(
    home: MyHomePage(),
  ));
}
