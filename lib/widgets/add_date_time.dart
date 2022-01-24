import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SMMPicker extends StatefulWidget {
  const SMMPicker({
    Key? key,
    required this.preDate,
    required this.chFunction,
  }) : super(key: key);
  final Function chFunction;
  final DateTime preDate;

  @override
  State<SMMPicker> createState() => _SMMPickerState();
}

class _SMMPickerState extends State<SMMPicker> {
  TextEditingController? sc = TextEditingController();

  TextEditingController? mi = TextEditingController();

  TextEditingController? mc = TextEditingController();

  late String displayTimeString;

  DateTime get nextDate {
    if (sc!.text.isEmpty) sc!.text = "0";
    if (mi!.text.isEmpty) mi!.text = "0";
    if (mc!.text.isEmpty) mc!.text = "0";
    return DateTime(
      widget.preDate.year,
      widget.preDate.month,
      widget.preDate.day,
      widget.preDate.hour,
      widget.preDate.minute,
      int.parse(sc!.text),
      int.parse(mi!.text),
      int.parse(mc!.text),
    );
  }

  String get _changeTimeString {
    return DateFormat("yyyy-MM-dd HH:mm:ss.S").format(nextDate);
  }

  void changeString() {
    setState(() {
      _changeTimeString;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 320,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          FittedBox(
            child: Text(
              _changeTimeString,
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          TextField(
              onChanged: (value) => changeString(),
              controller: sc,
              decoration: const InputDecoration(
                  label: Text("Second"), border: OutlineInputBorder())),
          const SizedBox(
            height: 20,
          ),
          TextField(
              onChanged: (value) => changeString(),
              controller: mi,
              decoration: const InputDecoration(
                  label: Text("Millisecond"), border: OutlineInputBorder())),
          const SizedBox(
            height: 20,
          ),
          TextField(
              onChanged: (value) => changeString(),
              controller: mc,
              decoration: const InputDecoration(
                  label: Text("Microsecond "), border: OutlineInputBorder())),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text("CANCEL")),
              const SizedBox(
                width: 10,
              ),
              TextButton(
                  onPressed: () {
                    widget.chFunction(nextDate);
                    Navigator.of(context).pop();
                  },
                  child: const Text("SUBMIT")),
            ],
          )
        ],
      ),
    );
  }
}
