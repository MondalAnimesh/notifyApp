import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medapp/ui/add_medic.dart';
import 'package:medapp/ui/models/task_controller.dart';
import 'package:medapp/ui/models/tasktile.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _taskController = Get.put(TaskController());

  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () async {
            await Get.to(() => const AddMedicationPage());
            _taskController.getTasks();
          },
          label: const Text("+ Add Medication")),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            _showTimeline(),
            _showTasks(),
          ],
        ),
      ),
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        indicatorColor: const Color(0xFFB4D84C),
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[
          NavigationDestination(
            selectedIcon: Icon(Icons.home),
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Badge(child: Icon(Icons.calendar_month)),
            label: 'History',
          ),
        ],
      ),
    );
  }

  _showTimeline() {
    return Container(
        margin: const EdgeInsets.only(top: 20, bottom: 10),
        child: EasyDateTimeLine(
          initialDate: DateTime.now(),
          onDateChange: (selectedDate) {
            //`selectedDate` the new date selected.
          },
          headerProps: const EasyHeaderProps(
            monthPickerType: MonthPickerType.switcher,
            dateFormatter: DateFormatter.fullDateDMY(),
          ),
          dayProps: const EasyDayProps(
            dayStructure: DayStructure.dayStrDayNum,
          ),
        ));
  }

  _showTasks() {
    return Expanded(
      child: Obx(() {
        return ListView.builder(
            itemCount: _taskController.taskList.length,
            itemBuilder: (_, index) {
              print(_taskController.taskList.length);
              return Card(
                child: TaskTile(_taskController.taskList[index]),
              );
            }); // ListView.builder
      }), // Obx
    ); // Expanded
  }
}
