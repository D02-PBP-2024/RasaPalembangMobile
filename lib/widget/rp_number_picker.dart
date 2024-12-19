import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:rasapalembang/utils/color_constants.dart';

class ListWheelScrollViewX extends StatelessWidget {
  final Axis scrollDirection;
  final List<Widget>? children;
  final ScrollController? controller;
  final ScrollPhysics? physics;
  final double diameterRatio;
  final double perspective;
  final double offAxisFraction;
  final bool useMagnifier;
  final double magnification;
  final double overAndUnderCenterOpacity;
  final double itemExtent;
  final double squeeze;
  final ValueChanged<int>? onSelectedItemChanged;
  final bool renderChildrenOutsideViewport;
  final ListWheelChildDelegate? childDelegate;
  final Clip clipBehavior;

  const ListWheelScrollViewX({
    super.key,
    this.scrollDirection = Axis.vertical,
    this.controller,
    this.physics,
    this.diameterRatio = RenderListWheelViewport.defaultDiameterRatio,
    this.perspective = RenderListWheelViewport.defaultPerspective,
    this.offAxisFraction = 0.0,
    this.useMagnifier = false,
    this.magnification = 1.0,
    this.overAndUnderCenterOpacity = 1.0,
    required this.itemExtent,
    this.squeeze = 1.0,
    this.onSelectedItemChanged,
    this.renderChildrenOutsideViewport = false,
    this.clipBehavior = Clip.hardEdge,
    required this.children,
  })  : childDelegate = null;

  const ListWheelScrollViewX.useDelegate({
    super.key,
    this.scrollDirection = Axis.vertical,
    this.controller,
    this.physics,
    this.diameterRatio = RenderListWheelViewport.defaultDiameterRatio,
    this.perspective = RenderListWheelViewport.defaultPerspective,
    this.offAxisFraction = 0.0,
    this.useMagnifier = false,
    this.magnification = 1.0,
    this.overAndUnderCenterOpacity = 1.0,
    required this.itemExtent,
    this.squeeze = 1.0,
    this.onSelectedItemChanged,
    this.renderChildrenOutsideViewport = false,
    this.clipBehavior = Clip.hardEdge,
    required this.childDelegate,
  })  : children = null;

  @override
  Widget build(BuildContext context) {
    final _childDelegate = children != null
        ? ListWheelChildListDelegate(
        children: children!.map((child) {
          return RotatedBox(
            quarterTurns: scrollDirection == Axis.horizontal ? 1 : 0,
            child: child,
          );
        }).toList())
        : ListWheelChildBuilderDelegate(
      builder: (context, index) {
        return RotatedBox(
          quarterTurns: scrollDirection == Axis.horizontal ? 1 : 0,
          child: childDelegate!.build(context, index),
        );
      },
    );

    return RotatedBox(
      quarterTurns: scrollDirection == Axis.horizontal ? 3 : 0,
      child: ListWheelScrollView.useDelegate(
        controller: controller,
        physics: FixedExtentScrollPhysics(),
        diameterRatio: diameterRatio,
        perspective: perspective,
        offAxisFraction: offAxisFraction,
        useMagnifier: useMagnifier,
        magnification: magnification,
        overAndUnderCenterOpacity: overAndUnderCenterOpacity,
        itemExtent: itemExtent,
        squeeze: squeeze,
        onSelectedItemChanged: onSelectedItemChanged,
        renderChildrenOutsideViewport: renderChildrenOutsideViewport,
        clipBehavior: clipBehavior,
        childDelegate: _childDelegate,
      ),
    );
  }
}

class RPNumberPicker extends StatefulWidget {
  final String? labelText;
  final int initialValue;
  final int minValue;
  final int maxValue;
  final ValueChanged<int> onChanged;

  RPNumberPicker({
    this.labelText,
    required this.initialValue,
    required this.minValue,
    required this.maxValue,
    required this.onChanged,
  });

  @override
  _RPNumberPickerState createState() => _RPNumberPickerState();
}

class _RPNumberPickerState extends State<RPNumberPicker> {
  late int _selectedValue;
  late FixedExtentScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _selectedValue = widget.initialValue;
    _scrollController = FixedExtentScrollController(initialItem: _selectedValue - widget.minValue);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (widget.labelText != null)
          Column(
            children: [
              Row(
                children: [
                  const SizedBox(width: 8.0),
                  Text(
                    widget.labelText!,
                    style: const TextStyle(
                      fontSize: 14.0,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12.0),
            ],
          ),
        SizedBox(
          height: 32,
          child: ListWheelScrollViewX(
            scrollDirection: Axis.horizontal,
            itemExtent: 60.0,
            diameterRatio: 1.5,
            perspective: 0.002,
            overAndUnderCenterOpacity: 0.5,
            controller: _scrollController,
            onSelectedItemChanged: (index) {
              setState(() {
                _selectedValue = widget.minValue + index;
              });
              widget.onChanged(_selectedValue);
            },
            children: List.generate(
              widget.maxValue - widget.minValue + 1,
                  (index) {
                int value = widget.minValue + index;
                return Center(
                  child: Text(
                    '$value',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: RPColors.textPrimary,
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
