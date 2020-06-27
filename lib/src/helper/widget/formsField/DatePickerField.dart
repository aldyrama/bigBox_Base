part of 'index.dart';

enum DateMode { DATE, TIME, DATETIME }

class DatePickerField extends StatefulWidget {
  final TextEditingController controller;
  final String placeholder;
  final ValueChanged<String> onValueChanged;
  final FormFieldValidator<String> validator;
  final GlobalKey<DatePickerState> key;
  final DateMode mode;
  final String dateFormat;
  final bool isSimple;
  final bool required;
  final bool withLable;
  final Color enableBorderColor;
  final Color titleColor;
  final int minTime;
  final int maxTime;

  DatePickerField(this.placeholder, this.controller,
      {
        this.onValueChanged,
        this.validator,
        this.key,
        this.mode = DateMode.DATETIME,
        this.isSimple = false,
        this.enableBorderColor = AppColors.GREY3,
        this.titleColor = AppColors.BLACK,
        this.withLable = true,
        this.dateFormat = "d MMMM yyyy, hh:mm a",
        this.required = true,
        this.minTime = null,
        this.maxTime = null
      });

  @override
  State<StatefulWidget> createState() {
    return DatePickerState();
  }
}

class DatePickerState extends State<DatePickerField> {
  final dateFieldKey = GlobalKey<FormFieldState<String>>();

  Widget buildDatePickerField(BuildContext context) {
    return Stack(alignment: AlignmentDirectional.topStart, children: <Widget>[
      Row(
        children: <Widget>[
//          Padding(
//            padding: EdgeInsets.symmetric(vertical: 10.0),
//            child: Padding(
//                padding: EdgeInsets.only(right: 8.0),
//                child: Image.asset(
//                  "assets/icons/calendar.png",
//                  scale: 4,
//                )),
////          child: Icon(
////            Icons.lock_open,
////            color: Colors.grey,
////          ),
//          ),
          Flexible(
            child: TextFormField(
              key: dateFieldKey,
              style: TextStyle(
                fontFamily: 'BrandonText',
                color: widget.titleColor,
              ),
              decoration: InputDecoration(
                labelText: widget.withLable ? widget.placeholder : "",
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFFC4C4C4)),
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: widget.enableBorderColor),
                ),
                errorBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: widget.enableBorderColor),
                ),
              ),
              controller: widget.controller,
              validator: (String value) {
                if (value.isEmpty && widget.required) {
                  return widget.placeholder + ' is required';
                }
                if (widget.validator != null) {
                  return widget.validator(value);
                }

                return null;
              },
            ),
          )
        ],
      ),
      SizedBox(
          height: 65.0,
          child: GestureDetector(
              onTap: () async {
                datePickerTaped();
              },
              child: Container(
                color: Colors.transparent,
                padding: EdgeInsets.all(10.0),
              )))
    ]);
  }

  void datePickerTaped() async {
    //clear focus
    FocusScope.of(context).requestFocus(new FocusNode());

    DateFormat formater = DateFormat(widget.dateFormat);

    String date = widget.controller.text;
    DateTime initial;
    try {
      initial = DateFormat(widget.dateFormat).parse(date);
    } catch (error) {}

    DateTime dates = await showDateTimeDialog(context, widget.mode,
        initalDate: initial, isSimple: widget.isSimple);

    if (dates == null) {
      dateFieldKey.currentState.validate();
      return;
    }

    String result = formater.format(dates);
    widget.controller.text = result;

    dateFieldKey.currentState.validate();

    if (widget.onValueChanged != null) {
      widget.onValueChanged(result);
    }
  }

  Future<DateTime> showDateDialog(BuildContext context,
      {DateTime initalDate, DateTime firstDate, DateTime lastDate}) async {
    DateTime selectedDate = await showDatePicker(
        context: context,
        initialDatePickerMode: DatePickerMode.year,
        initialDate: initalDate != null ? initalDate : DateTime.now(),
        firstDate: firstDate != null
            ? firstDate
            : DateTime.fromMicrosecondsSinceEpoch(0),
        lastDate: lastDate != null
            ? lastDate
            : DateTime.now().add(Duration(days: 365 * 10)));

    return selectedDate;
  }

  Future<DateTime> showCupertinoDateDialog(BuildContext context,
      {DateTime initalDate, DateTime firstDate, DateTime lastDate}) async {
    Completer task = new Completer();
    DatePicker.showDatePicker(context,
        showTitleActions: true,

        minTime: widget.minTime == null ? DateTime.fromMicrosecondsSinceEpoch(0)
            : DateTime.fromMillisecondsSinceEpoch(widget.minTime),
//        minTime: firstDate != null
//            ? firstDate
//            : DateTime.fromMillisecondsSinceEpoch(-1262283162000),
////            : DateTime.fromMicrosecondsSinceEpoch(0),
//        maxTime: lastDate != null
//            ? lastDate
//            : DateTime.now().add(Duration(days: 365 * 10)), onChanged: (date) {
        maxTime: widget.maxTime == null ? DateTime.now().add(Duration(days: 365 * 10))
            : DateTime.now().add(Duration(days: widget.maxTime)),
        onChanged: (date) {
      print('change $date');
    }, onConfirm: (date) {
      print('confirm $date');
      task.complete(date);
    },
        currentTime: initalDate != null ? initalDate : DateTime.now(),
        locale: LocaleType.en,
        theme: DatePickerTheme(
            doneStyle:
                TextStyle(color: Colors.black, fontWeight: FontWeight.bold)));
    dynamic val = await task.future;
    return val as DateTime;
  }

  Future<DateTime> showTimeDialog(
      BuildContext context, DateTime initalDate) async {
    TimeOfDay initialTime = TimeOfDay.fromDateTime(initalDate);

    TimeOfDay selectedTime =
        await showTimePicker(context: context, initialTime: initialTime);

    if (selectedTime == null) {
      return null;
    }

    return DateTime(initalDate.year, initalDate.month, initalDate.day,
        selectedTime.hour, selectedTime.minute);
  }

  Future<DateTime> showDateTimeDialog(BuildContext context, DateMode mode,
      {DateTime initalDate,
      DateTime firstDate,
      DateTime lastDate,
      bool isSimple = false}) async {
    if (mode == DateMode.TIME) {
      return showTimeDialog(
          context, initalDate != null ? initalDate : DateTime.now());
    }

    DateTime selectedDate;

    if (isSimple) {
      selectedDate = await showCupertinoDateDialog(context,
          initalDate: initalDate, firstDate: firstDate, lastDate: lastDate);
    } else {
      selectedDate = await showDateDialog(context,
          initalDate: initalDate, firstDate: firstDate, lastDate: lastDate);
    }

    if (mode == DateMode.DATE) {
      return selectedDate;
    }

    if (selectedDate == null) {
      return null;
    }

    if (initalDate != null) {
      if (DateTime(initalDate.year, initalDate.month, initalDate.day)
              .difference(selectedDate) ==
          Duration(seconds: 0)) {
        selectedDate = initalDate;
      }
    }

    return showTimeDialog(context, selectedDate);
  }

  @override
  Widget build(BuildContext context) {
    return buildDatePickerField(context);
  }
}
