import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import 'add_date_time.dart';
import 'change_format.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController userInput = TextEditingController();
  String formatTimeString = 'yyyy-MM-dd – kk:mm:ss';
  late DateTime? pickedDate;

  void changeTimeFormat(String pattern) {
    if (pattern.isNotEmpty) {
      setState(() {
        formatTimeString = pattern;
      });
    }
  }

  DateTime get mainDateTime {
    return DateTime.fromMillisecondsSinceEpoch(int.parse(userInput.text));
  }

  String get epochCnv {
    if (userInput.text.isEmpty) {
      userInput.text = '1642811640';
    }
    return DateFormat(formatTimeString).format(mainDateTime);
  }

  void _dateTimePiced(BuildContext ctx) {
    showDatePicker(
            context: ctx,
            initialDate: DateTime.now(),
            firstDate: DateTime(2021),
            lastDate: DateTime.now())
        .then((valueDate) {
      if (valueDate != null) {
        showTimePicker(context: context, initialTime: TimeOfDay.now())
            .then((valueTime) {
          if (valueTime != null) {
            DateTime preDate = DateTime(
              valueDate.year,
              valueDate.month,
              valueDate.day,
              valueTime.hour,
              valueTime.minute,
            );
            openDialog(preDate);
          }
        });
      }
    });
  }

  Future openDialog(DateTime preDate) => showDialog(
      context: context,
      builder: (context) => AlertDialog(
            title: Text(
              "ENTER SECOND",
              style: Theme.of(context)
                  .textTheme
                  .overline!
                  .copyWith(color: Colors.black),
            ),
            content: SMMPicker(
                preDate: preDate,
                chFunction: (DateTime p) {
                  setState(() {
                    userInput.text = p.millisecondsSinceEpoch.toString();
                  });
                }),
            // actions: [],
          ));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.title),
      ),
      body: Container(
        margin: const EdgeInsets.all(15),
        alignment: Alignment.center,
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                      color: Theme.of(context).hoverColor,
                      borderRadius: BorderRadius.circular(10)),
                  padding: const EdgeInsets.all(20),
                  child: TextField(
                    controller: userInput,
                    onChanged: (value) => setState(() {
                      epochCnv;
                    }),
                    decoration: const InputDecoration(
                        label: Text("Enter Epoch Timestamp From Milliseconds"),
                        border: OutlineInputBorder()),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  width: MediaQuery.of(context).size.width * .9,
                  padding: const EdgeInsets.all(12.0),
                  decoration: BoxDecoration(
                      color: Theme.of(context).hoverColor,
                      borderRadius: BorderRadius.circular(10)),
                  child: FittedBox(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Human Readable Form',
                          style: Theme.of(context).textTheme.caption,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          epochCnv,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.headline3,
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                      color: Theme.of(context).hoverColor,
                      borderRadius: BorderRadius.circular(10)),
                  height: 50,
                  child: FittedBox(
                    child: Row(
                      children: [
                        Tooltip(
                          message: "Update now Time",
                          child: IconButton(
                            onPressed: () {
                              setState(() {
                                userInput.text = DateTime.now()
                                    .millisecondsSinceEpoch
                                    .toString();
                              });
                            },
                            icon: const Icon(Icons.update),
                          ),
                        ),
                        Tooltip(
                          message: "Edit DateTime",
                          child: IconButton(
                            onPressed: () {
                              _dateTimePiced(context);
                            },
                            icon: const Icon(Icons.edit),
                          ),
                        ),
                        Tooltip(
                          message: "Copy DateTime",
                          child: IconButton(
                            onPressed: () {
                              Clipboard.setData(ClipboardData(text: epochCnv));
                            },
                            icon: const Icon(Icons.copy),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                ChangeFormat(
                  timeStamp: mainDateTime,
                  changeTimePattern: changeTimeFormat,
                  nowTimePattern: formatTimeString,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
