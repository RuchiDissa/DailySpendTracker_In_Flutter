import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: MyHomePage(),
  ));
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<SpendEntry> _spendEntries = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 79, 129, 154),
        title: const Text('Daily Spend Tracker'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _spendEntries.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_spendEntries[index].title),
                  subtitle: Text(
                      '\$${_spendEntries[index].amount.toStringAsFixed(2)}'),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      setState(() {
                        _spendEntries.removeAt(index);
                      });
                    },
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SpendEntryForm(
              onSave: (entry) {
                setState(() {
                  _spendEntries.add(entry);
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}

class SpendEntry {
  final String title;
  final double amount;
  final DateTime dateTime;

  SpendEntry(
      {required this.title, required this.amount, required this.dateTime});
}

class SpendEntryForm extends StatefulWidget {
  final Function(SpendEntry) onSave;

  const SpendEntryForm({Key? key, required this.onSave}) : super(key: key);

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

    // Create a SpendEntry object
    SpendEntry entry = SpendEntry(title: title, amount: amount, dateTime: now);

    // Call the onSave callback to pass the entry to the parent widget
    widget.onSave(entry);

    // Clear the text fields after saving
    _titleController.clear();
    _amountController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
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
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }
}
