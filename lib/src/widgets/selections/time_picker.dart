import 'package:collection/collection.dart';
import 'package:coody_common_flutter/styles.dart';
import 'package:coody_common_flutter/utils.dart';
import 'package:flutter/widgets.dart';

enum TimerPickerSize {
  small,
  large;

  TextStyle getTextStyle(BuildContext context) => switch (this) {
        TimerPickerSize.small => context.typography.title1.emphasized,
        TimerPickerSize.large => context.typography.largeTitle2.emphasized,
      };

  EdgeInsets get padding => const EdgeInsets.symmetric(vertical: 4.0);

  double getItemExtent(BuildContext context) =>
      getTextStyle(context).textHeight! + padding.vertical;
}

class TimePicker extends StatefulWidget {
  const TimePicker({
    super.key,
    this.size = TimerPickerSize.small,
    this.minutes,
    this.onHourChanged,
    this.onMinuteChanged,
  });

  final TimerPickerSize size;
  final List<int>? minutes;
  final void Function(int hour)? onHourChanged;
  final void Function(int minute)? onMinuteChanged;

  @override
  State<TimePicker> createState() => _TimePickerState();
}

class _TimePickerState extends State<TimePicker> {
  int _selectedHourIndex = 0;
  int _selectedMinuteIndex = 0;

  final _hours = List.generate(24, (index) => index);
  List<int> _minutes = [];

  @override
  void initState() {
    super.initState();

    _minutes = widget.minutes ?? List.generate(60, (index) => index);
  }

  @override
  void didUpdateWidget(covariant TimePicker oldWidget) {
    if (widget.minutes != oldWidget.minutes) {
      _minutes = widget.minutes ?? List.generate(60, (index) => index);
    }

    super.didUpdateWidget(oldWidget);
  }

  void _onSelectedHourIndexChanged(int index) {
    setState(() => _selectedHourIndex = index);
    widget.onHourChanged?.call(_hours[index]);
  }

  void _onSelectedMinuteIndexChanged(int index) {
    setState(() => _selectedMinuteIndex = index);
    widget.onMinuteChanged?.call(_minutes[index]);
  }

  bool _isNearestItem(List list, int selectedIndex, int index) {
    var leftOffset = selectedIndex - 1;
    var rightOffset = selectedIndex + 1;

    if (leftOffset < 0) {
      leftOffset = list.length + leftOffset;
    }
    if (rightOffset >= list.length) {
      rightOffset = rightOffset - list.length;
    }

    return list[leftOffset] == index || list[rightOffset] == index;
  }

  Widget _buildItem(int index, int selectedIndex, List<int> itemList) {
    Color? color = context.colors.gray4;
    if (index == selectedIndex) {
      color = null;
    } else if (_isNearestItem(itemList, selectedIndex, index)) {
      color = context.colors.gray5;
    }

    return Padding(
      key: Key(index.toString()),
      padding: widget.size.padding,
      child: Text(
        itemList[index].toString().padLeft(2, '0'),
        style: widget.size.getTextStyle(context).copyWith(color: color),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.size.getItemExtent(context) * 5,
      child: Stack(
        children: [
          Center(
            child: Container(
              decoration: BoxDecoration(
                color: context.colors.gray2,
                borderRadius: const BorderRadius.all(Radius.circular(8.0)),
              ),
              height: 32.0,
            ),
          ),
          Row(
            children: [
              const Expanded(child: SizedBox()),
              Expanded(
                child: ListWheelScrollView.useDelegate(
                  physics: const FixedExtentScrollPhysics(),
                  itemExtent: widget.size.getItemExtent(context),
                  onSelectedItemChanged: _onSelectedHourIndexChanged,
                  childDelegate: ListWheelChildLoopingListDelegate(
                    children: _hours.mapIndexed((index, value) {
                      return _buildItem(index, _selectedHourIndex, _hours);
                    }).toList(),
                  ),
                ),
              ),
              Expanded(
                child: ListWheelScrollView.useDelegate(
                  physics: const FixedExtentScrollPhysics(),
                  itemExtent: widget.size.getItemExtent(context),
                  onSelectedItemChanged: _onSelectedMinuteIndexChanged,
                  childDelegate: ListWheelChildLoopingListDelegate(
                    children: _minutes.mapIndexed((index, value) {
                      return _buildItem(index, _selectedMinuteIndex, _minutes);
                    }).toList(),
                  ),
                ),
              ),
              const Expanded(child: SizedBox()),
            ],
          ),
        ],
      ),
    );
  }
}
