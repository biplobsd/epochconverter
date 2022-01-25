import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Examples extends StatelessWidget {
  final DateTime mainDateTime;
  final Function _backPattern;
  const Examples(
    this.mainDateTime,
    this._backPattern, {
    Key? key,
  }) : super(key: key);

  static const List<List<String>> examples = [
    ["d", "Day"],
    ["E", "Abbr Weekday"],
    ["EEEE", "WEEKDAY"],
    ["LLL", "ABBR_STANDALONE_MONTH"],
    ["LLLL", "STANDALONE_MONTH"],
    ["M", "NUM_MONTH"],
    ["Md", "NUM_MONTH_DAY"],
    ["MEd", "NUM_MONTH_WEEKDAY_DAY"],
    ["MMM", "ABBR_MONTH"],
    ["MMMd", "ABBR_MONTH_DAY"],
    ["MMMEd", "ABBR_MONTH_WEEKDAY_DAY"],
    ["MMMM", "MONTH"],
    ["MMMMd", "MONTH_DAY"],
    ["MMMMd", "MONTH_WEEKDAY_DAY"],
    ["QQQ", "ABBR_QUARTER"],
    ["QQQQ", "QUARTER"],
    ["y", "YEAR"],
    ["yM", "YEAR_NUM_MONTH"],
    ["yMd", "YEAR_NUM_MONTH_DAY"],
    ["yMEd", "YEAR_NUM_MONTH_WEEKDAY_DAY"],
    ["yMMM", "YEAR_ABBR_MONTH"],
    ["yMMMd", "YEAR_ABBR_MONTH_DAY"],
    ["yMMMEd", "YEAR_ABBR_MONTH_WEEKDAY_DAY"],
    ["yMMMM", "YEAR_MONTH"],
    ["yMMMMd", "YEAR_MONTH_DAY"],
    ["yMMMMEEEEd", "YEAR_MONTH_WEEKDAY_DAY"],
    ["yQQQ", "YEAR_ABBR_QUARTER"],
    ["yQQQQ", "YEAR_QUARTER"],
    ["H", "HOUR24"],
    ["Hm", "HOUR24_MINUTE"],
    ["Hms", "HOUR24_MINUTE_SECOND"],
    ["j", "HOUR"],
    ["jm", "HOUR_MINUTE"],
    ["jms", "HOUR_MINUTE_SECOND"],
    // ["jmv", "HOUR_MINUTE_GENERIC_TZ"],
    // ["jmz", "HOUR_MINUTE_TZ"],
    // ["jv", "HOUR_GENERIC_TZ"],
    // ["jz", "HOUR_TZ"],
    ["m", "MINUTE"],
    ["ms", "MINUTE_SECOND"],
    ["s", "SECOND"],
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Theme.of(context).hoverColor,
          borderRadius: BorderRadius.circular(10)),
      height: MediaQuery.of(context).size.height * .6,
      padding: const EdgeInsets.all(15),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  padding: const EdgeInsets.all(2),
                  alignment: Alignment.center,
                  // width: 55,
                  child: FittedBox(
                    child: Text(
                      "Skeleton".toUpperCase(),
                      style: Theme.of(context).textTheme.overline,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              Expanded(
                flex: 1,
                child: Container(
                  padding: const EdgeInsets.all(2),
                  alignment: Alignment.center,
                  // width: 50,
                  child: FittedBox(
                    child: Text(
                      "Example".toUpperCase(),
                      style: Theme.of(context).textTheme.overline,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 50,
              ),
              Expanded(
                flex: 2,
                child: Container(
                  padding: const EdgeInsets.all(2),
                  alignment: Alignment.centerRight,
                  // width: 100,
                  child: FittedBox(
                    child: Text(
                      "ICU Name".toUpperCase(),
                      style: Theme.of(context).textTheme.overline,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * .5,
            child: SingleChildScrollView(
              child: Column(children: [
                const SizedBox(
                  height: 5,
                ),
                ...examples.map(
                  (e) => Container(
                    decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                              color: Theme.of(context)
                                  .primaryColorDark
                                  .withAlpha(10))),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: TextButton(
                      onPressed: () => _backPattern(e[0]),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Expanded(
                            flex: 1,
                            child: Container(
                              padding: const EdgeInsets.all(2),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  color: Theme.of(context).hoverColor,
                                  borderRadius: BorderRadius.circular(3)),
                              child: FittedBox(
                                child: Text(
                                  e[0],
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Expanded(
                            flex: 1,
                            child: Container(
                              padding: const EdgeInsets.all(2),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  color: Theme.of(context).hoverColor,
                                  borderRadius: BorderRadius.circular(3)),
                              // width: 50,
                              child: FittedBox(
                                child: Text(
                                  DateFormat(e[0]).format(mainDateTime),
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 50,
                          ),
                          Expanded(
                            flex: 2,
                            child: Container(
                              alignment: Alignment.centerRight,
                              // decoration: BoxDecoration(
                              //     color: Theme.of(context).hoverColor,
                              //     borderRadius: BorderRadius.circular(3)),
                              // width: 100,
                              child: FittedBox(
                                child: Text(
                                  e[1].toUpperCase(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall!
                                      .copyWith(fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ]),
            ),
          )
        ],
      ),
    );
  }
}
