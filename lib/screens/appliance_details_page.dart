import 'package:cached_network_image/cached_network_image.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class ApplianceDetailsScreen extends StatefulWidget {
  const ApplianceDetailsScreen({
    super.key,
    required this.name,
    required this.icon,
    required this.value,
    required this.onToggle,
    required this.params,
    required this.paramsValue,
    required this.initial,
    required this.min,
    required this.max,
  });

  final String name;
  final String icon;
  final bool value;
  final void Function(bool) onToggle;
  final List<String> params;
  final List<dynamic> paramsValue;
  final int initial;
  final int min;
  final int max;

  @override
  State<ApplianceDetailsScreen> createState() => _ApplianceDetailsScreenState();
}

class _ApplianceDetailsScreenState extends State<ApplianceDetailsScreen> {
  late double _currentValue;

  @override
  void initState() {
    super.initState();
    _currentValue = widget.initial.toDouble();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.name,
          style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                fontWeight: FontWeight.w400,
              ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          child: Column(
            children: [
              Card(
                elevation: 2.0,
                child: Container(
                  height: MediaQuery.of(context).size.height / 4,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Theme.of(context).scaffoldBackgroundColor,
                        Theme.of(context).primaryColor,
                      ],
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16.0,
                          vertical: 20.0,
                        ),
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 24,
                              backgroundColor: Colors.grey.shade300,
                              backgroundImage:
                                  CachedNetworkImageProvider(widget.icon),
                            ),
                            const Spacer(),
                            Switch.adaptive(
                              value: widget.value,
                              onChanged: widget.onToggle,
                            ),
                          ],
                        ),
                      ),
                      Text(
                        '$_currentValue ${widget.paramsValue[2]}',
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium!
                            .copyWith(
                              fontWeight: FontWeight.w400,
                            ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        widget.params[0],
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                              fontWeight: FontWeight.w400,
                            ),
                      ),
                      Slider.adaptive(
                        min: widget.min.toDouble(),
                        max: widget.max.toDouble(),
                        divisions: 5,
                        value: _currentValue,
                        onChanged: (value) {
                          setState(() {
                            _currentValue = value;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Card(
                elevation: 2.0,
                child: Container(
                  height: 80,
                  width: double.infinity,
                  padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      Text(
                        widget.params[1],
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                              fontWeight: FontWeight.w400,
                            ),
                      ),
                      const SizedBox(width: 20),
                      VerticalDivider(
                        indent: 10,
                        endIndent: 10,
                        thickness: 2,
                        color: Theme.of(context).hintColor,
                      ),
                      const Spacer(),
                      Text(
                        widget.paramsValue[1],
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                              fontWeight: FontWeight.w400,
                            ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 400,
                width: 400,
                child: PieChart(
                  PieChartData(
                    sections: [
                      PieChartSectionData(
                        value: widget.initial.toDouble(),
                        color: Colors.red,
                        title: '${widget.initial} ${widget.paramsValue[2]}',
                        radius: 125,
                        titleStyle: Theme.of(context).textTheme.titleMedium,
                      ),
                      PieChartSectionData(
                        value: widget.max - widget.initial.toDouble(),
                        color: Colors.blue,
                        title:
                            '${widget.max - widget.initial} ${widget.paramsValue[2]}',
                        radius: 125,
                        titleStyle: Theme.of(context).textTheme.titleMedium,
                      )
                    ],
                    centerSpaceRadius: 0,
                    sectionsSpace: 5,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
