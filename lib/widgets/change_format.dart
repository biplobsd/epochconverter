import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'examples.dart';

class ChangeFormat extends StatefulWidget {
  final Function changeTimePattern;
  final String nowTimePattern;
  final DateTime timeStamp;
  const ChangeFormat({
    required this.changeTimePattern,
    required this.nowTimePattern,
    required this.timeStamp,
    Key? key,
  }) : super(key: key);

  @override
  State<ChangeFormat> createState() => _ChangeFormatState();
}

class _ChangeFormatState extends State<ChangeFormat> {
  TextEditingController timeStringContoler = TextEditingController();

  List<String> timePattern = [
    "yMd",
    "yMEd",
    "yMMMd",
    "yMMMEd",
    "yMMMMd",
    "yMMMMEEEEd",
    "EEE, MMM d, ''yy",
    // "EEE, MMM d, ''yy",
    "yyyy-MM-dd – kk:mm:ss",
    "yyyy-MM-dd",
    "yyyy.MM.dd G 'at' HH:mm:ss",
    "HH:mm:ss"
  ];

  void changePNow([String? e]) {
    if (e != null) {
      setState(() {
        timeStringContoler.text = e;
      });
    }
    widget.changeTimePattern(timeStringContoler.text);
  }

  @override
  Widget build(BuildContext context) {
    if (timeStringContoler.text.isEmpty) {
      timeStringContoler.text = widget.nowTimePattern;
    }

    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
              color: Theme.of(context).hoverColor,
              borderRadius: BorderRadius.circular(15)),
          padding: const EdgeInsets.all(15),
          margin: const EdgeInsets.symmetric(vertical: 30, horizontal: 10),
          child: Column(
            children: [
              Text(
                "Change Format",
                style: Theme.of(context).textTheme.caption,
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                onChanged: (_) {
                  changePNow();
                },
                onSubmitted: (_) {
                  changePNow();
                },
                controller: timeStringContoler,
                decoration: const InputDecoration(
                    label: Text("ICU/JDK date/time pattern"),
                    border: OutlineInputBorder()),
              ),
              const SizedBox(
                height: 10,
              ),
              Wrap(
                children: [
                  ...timePattern.map(
                    (e) => Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: TextButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                Theme.of(context)
                                    .primaryColorLight
                                    .withAlpha(200))),
                        onPressed: () {
                          changePNow(e);
                        },
                        child: Text(
                          DateFormat(e).format(widget.timeStamp),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
        // ElevatedButton(
        //     onPressed: changePNow, child: const Text("Change Pattern"))
        Examples(widget.timeStamp, changePNow),
      ],
    );
  }
}
