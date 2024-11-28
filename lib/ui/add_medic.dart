import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:medapp/ui/functions.dart';
import 'package:medapp/ui/models/fields.dart';
import 'package:medapp/ui/models/task_controller.dart';
import 'package:medapp/ui/models/tasks.dart';

class AddMedicationPage extends StatefulWidget {
  const AddMedicationPage({super.key});

  @override
  State<AddMedicationPage> createState() => _AddMedicationPageState();
}

class _AddMedicationPageState extends State<AddMedicationPage> {
  final TaskController _taskController = Get.put(TaskController());
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _dosageController = TextEditingController();
  final TextEditingController _miliController = TextEditingController();
  String _recurrence = 'Daily';
  final DateTime _selectedDate = DateTime.now();
  final String _CurrentTime =
      DateFormat("hh:mm a").format(DateTime.now()).toString();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Center(
              child: Text(
        "Add medication",
        style: headingStyle,
      ))),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Container(
        height: 50,
        margin: const EdgeInsets.all(10),
        child: ElevatedButton(
          style: const ButtonStyle(
            backgroundColor: WidgetStatePropertyAll<Color>(Color(0xFFB4D84C)),
          ),
          onPressed: () => _validateData(),
          child: const Center(
            child: Text('Next'),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Column(
          children: [
            InputField(
                title: "Medication Name",
                hint: "e.g.",
                controller: _nameController),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                    child: InputField(
                  title: "Dosage",
                  hint: "1",
                  controller: _dosageController,
                )),
                const SizedBox(
                  width: 15,
                ),
                Expanded(
                  child: DropdownButtonFormField(
                    value: _recurrence,
                    items: ['Daily', 'Weekly', 'Monthly'].map((recurrence) {
                      return DropdownMenuItem(
                        value: recurrence,
                        child: Text(recurrence),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _recurrence = value!;
                      });
                    },
                    decoration: const InputDecoration(
                      filled: true,
                    ),
                  ),
                ),
              ],
            ),
            InputField(
              title: "Miligram",
              hint: "4 m.g.",
              controller: _miliController,
            ),
            InputField(
                title: "EndDate", hint: DateFormat.yMd().format(_selectedDate)),
            InputField(title: "Time(s) for Medication", hint: _CurrentTime),
          ],
        ),
      ),
    );
  }

  _validateData() {
    if (_nameController.text.isNotEmpty &&
        _dosageController.text.isNotEmpty &&
        _miliController.text.isNotEmpty) {
      _addTaskToDb();
      Get.back();
    } else if (_nameController.text.isNotEmpty ||
        _dosageController.text.isNotEmpty ||
        _miliController.text.isNotEmpty) {
      Get.snackbar(
        "Required",
        "All fields are required !",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.white,
      );
    }
  }

  _addTaskToDb() async {
    await _taskController.addTask(
        task: Task(
      dosage: _dosageController.text,
      name: _nameController.text,
      miligram: _miliController.text,
      enddate: DateFormat.yMd().format(_selectedDate),
      recurrence: _recurrence,
      dosetime: _CurrentTime,
      isCompleted: 0,
    ));
  }
}
