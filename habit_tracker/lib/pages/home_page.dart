import 'package:flutter/material.dart';
import 'package:habit_tracker/components/drawer.dart';
import 'package:habit_tracker/components/my_habit_tile.dart';
import 'package:habit_tracker/database/habit_database.dart';
import 'package:provider/provider.dart';

import '../components/my_heat_map.dart';
import '../models/habit.dart';
import '../utils/habit_util.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController textController = TextEditingController();

  // create a new habit
  @override
  void initState() {
    Provider.of<HabitDatabase>(context, listen: false).readHabits();

    super.initState();
  }

  void createNewHabit() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: TextField(
          controller: textController,
          decoration: InputDecoration(hintText: "Create a new habit"),
        ),
        actions: [
          MaterialButton(
            onPressed: () {
              String newHabitName = textController.text;

              context.read<HabitDatabase>().addHabit(newHabitName);

              Navigator.pop(context);

              textController.clear();
            },
            child: Text("Save"),
          ),
          MaterialButton(
            onPressed: () {
              Navigator.pop(context);

              textController.clear();
            },
            child: Text("Cancel"),
          ),
        ],
      ),
    );
  }

  void checkHabitOnOff(bool? value, Habit habit) {
    if (value != null) {
      context.read<HabitDatabase>().updateHabitCompletion(habit.id, value);
    }
  }

  void editHabitBox(Habit habit) {
    textController.text = habit.name;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: TextField(
          controller: textController,
        ),
        actions: [
          MaterialButton(
            onPressed: () {
              String newHabitName = textController.text;

              context
                  .read<HabitDatabase>()
                  .updateHabitName(habit.id, newHabitName);

              Navigator.pop(context);

              textController.clear();
            },
            child: Text("Save"),
          ),
          MaterialButton(
            onPressed: () {
              Navigator.pop(context);

              textController.clear();
            },
            child: Text("Cancel"),
          ),
        ],
      ),
    );
  }

  void deleteHabitBox(Habit habit) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Are you sure you want to delete?"),
        actions: [
          MaterialButton(
            onPressed: () {
              context.read<HabitDatabase>().deleteHabit(habit.id);

              Navigator.pop(context);
            },
            child: Text("Delete"),
          ),
          MaterialButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text("Cancel"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(),
      drawer: MyDrawer(),
      floatingActionButton: FloatingActionButton(
        onPressed: createNewHabit,
        elevation: 0,
        backgroundColor: Theme.of(context).colorScheme.tertiary,
        foregroundColor: Theme.of(context).colorScheme.inversePrimary,
        child: Icon(Icons.add),
      ),
      body: ListView(
        children: [
          // heatmap
          _buildHeatMap(),
          // habitlist
          _buildHabitList(),
        ],
      ),
    );
  }

  Widget _buildHeatMap() {
    final habitDatabase = context.watch<HabitDatabase>();

    List<Habit> currentHabits = habitDatabase.currentHabits;

    return FutureBuilder(
      future: habitDatabase.getFirstLaunchDate(),
      builder: (context, snapshot){
        if(snapshot.hasData){
          return MyHeatMap(
            startDate: snapshot.data!,
            datasets: prepHeatMapDataset(currentHabits),
          );
        }
        else{
          return Container();
        }
      },
    );
  }

  Widget _buildHabitList() {
    final habitDatabase = context.watch<HabitDatabase>();

    List<Habit> currentHabits = habitDatabase.currentHabits;

    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: currentHabits.length,
      itemBuilder: (context, index) {
        final habit = currentHabits[index];

        bool isCompletedToday = isHabitCompletedToday(habit.completedDays);

        return MyHabitTile(
          text: habit.name,
          isCompleted: isCompletedToday,
          onChanged: (value) => checkHabitOnOff(value, habit),
          editHabit: (context) => editHabitBox(habit),
          deleteHabit: (context) => deleteHabitBox(habit),
        );
      },
    );
  }
}
