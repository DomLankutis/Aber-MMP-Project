import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:search_algorithm_visualiser/custom_painter.dart';
import 'package:search_algorithm_visualiser/help_widget.dart';
import 'package:search_algorithm_visualiser/searches/binary_search.dart';
import 'package:search_algorithm_visualiser/searches/fixed_step_search.dart';
import 'package:search_algorithm_visualiser/searches/linear_Search.dart';
import 'package:search_algorithm_visualiser/searches/search_class.dart';

enum SearchAlgorithm { linear, binary, fixed }

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double _arraySizeSlider = 0;
  SearchAlgorithm? _algorithm = SearchAlgorithm.linear;
  String? _elementToSearchFor;

  late int _maximumArraySize;

  void algorithmRadioListChanged(SearchAlgorithm? val) {
    setState(() {
      _algorithm = val;
    });
  }

  void parameterRadioListChanged(String? val) {
    setState(() {
      _elementToSearchFor = val;
    });
  }

  @override
  void initState() {
    super.initState();

    _maximumArraySize = SearchClass.calculateMaximumSize(
        SearchClass.largeCanvasPixelSize, SearchClass.largeGap);
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget showErrorDialog(BuildContext context) {
    AlertDialog alertDialog = AlertDialog(
      title: const Text("Error"),
      content: const Text("Make sure all the parameters are set."),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text("OK"),
        ),
      ],
    );

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return alertDialog;
        });

    return alertDialog;
  }

  void startButtonPressed() {
    if (_algorithm != null && _elementToSearchFor != null) {
      SearchAlgorithm algorithm = _algorithm!;
      int arrSize = _arraySizeSlider.toInt();
      int searchFor = 0;

      switch (_elementToSearchFor) {
        case "first":
          searchFor = 0;
          break;
        case "middle":
          searchFor = (arrSize / 2).floor();
          break;
        case "last":
          searchFor = arrSize - 1;
          break;
        case "random":
          searchFor = Random.secure().nextInt(arrSize - 1);
          break;
      }

      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                customPainterBuilder(context, arrSize, searchFor, algorithm),
          ));
    } else {
      showErrorDialog(context);
    }
  }

  //TODO: Add marking for each canvas rendering boundary

  //TODO: Add explanations for what special colours mean in the visualiser
  Map<Color, String> getSearchColorExplanation() {
    switch (_algorithm!) {
      case SearchAlgorithm.linear:
        return LinearSearch.getColorExplanations();
      case SearchAlgorithm.binary:
        return BinarySearch.getColorExplanations();
      case SearchAlgorithm.fixed:
        return FixedStepSearch.getColorExplanations();
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);

    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);

    return Scaffold(
      body: SafeArea(
        maintainBottomViewPadding: false,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.45,
                      height: MediaQuery.of(context).size.height * 0.85,
                      child: Card(
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            const Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 10, 0, 10),
                              child: Text("Select Algorithm"),
                            ),
                            Expanded(
                              child: Align(
                                alignment: const AlignmentDirectional(0, 0),
                                child: Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      20, 0, 20, 0),
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    height: MediaQuery.of(context).size.height *
                                        0.4,
                                    alignment: const AlignmentDirectional(0, 0),
                                    child: Card(
                                      clipBehavior: Clip.antiAliasWithSaveLayer,
                                      child: Padding(
                                        padding: const EdgeInsetsDirectional
                                            .fromSTEB(10, 10, 10, 10),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            RadioListTile<SearchAlgorithm>(
                                              title:
                                                  const Text('Linear Search'),
                                              value: SearchAlgorithm.linear,
                                              groupValue: _algorithm,
                                              onChanged:
                                                  (algorithmRadioListChanged),
                                              visualDensity:
                                                  const VisualDensity(
                                                horizontal: VisualDensity
                                                    .minimumDensity,
                                                vertical: VisualDensity
                                                    .minimumDensity,
                                              ),
                                            ),
                                            RadioListTile<SearchAlgorithm>(
                                              title:
                                                  const Text('Binary Search'),
                                              value: SearchAlgorithm.binary,
                                              groupValue: _algorithm,
                                              onChanged:
                                                  (algorithmRadioListChanged),
                                              visualDensity:
                                                  const VisualDensity(
                                                horizontal: VisualDensity
                                                    .minimumDensity,
                                                vertical: VisualDensity
                                                    .minimumDensity,
                                              ),
                                            ),
                                            RadioListTile<SearchAlgorithm>(
                                              title: const Text(
                                                  'Fixed Step Search'),
                                              value: SearchAlgorithm.fixed,
                                              groupValue: _algorithm,
                                              onChanged:
                                                  (algorithmRadioListChanged),
                                              visualDensity:
                                                  const VisualDensity(
                                                horizontal: VisualDensity
                                                    .minimumDensity,
                                                vertical: VisualDensity
                                                    .minimumDensity,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SingleChildScrollView(
                              child: Card(
                                child: HelpWidget(
                                  colorsToExplain: getSearchColorExplanation(),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.45,
                      height: MediaQuery.of(context).size.height * 0.85,
                      child: Card(
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            const Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                              child: Text("Select Parameters"),
                            ),
                            Padding(
                              padding: const EdgeInsetsDirectional.all(5),
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width,
                                child: Card(
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  child: Padding(
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            10, 5, 10, 5),
                                    child: InputDecorator(
                                      decoration: const InputDecoration(
                                        label: Text("Array Size"),
                                        contentPadding: EdgeInsets.zero,
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)),
                                        ),
                                      ),
                                      child: Slider(
                                        value: _arraySizeSlider,
                                        min: 0,
                                        max: _maximumArraySize.toDouble(),
                                        divisions: _maximumArraySize,
                                        label:
                                            _arraySizeSlider.round().toString(),
                                        onChanged: (val) {
                                          setState(() {
                                            _arraySizeSlider = val;
                                          });
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsetsDirectional.all(5),
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width,
                                child: Card(
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      const Text('Search For'),
                                      Padding(
                                        padding: const EdgeInsetsDirectional
                                            .fromSTEB(0, 10, 0, 15),
                                        child: Column(
                                          children: [
                                            RadioListTile<String>(
                                              title:
                                                  const Text("First Element"),
                                              onChanged:
                                                  parameterRadioListChanged,
                                              groupValue: _elementToSearchFor,
                                              value: "first",
                                              visualDensity:
                                                  const VisualDensity(
                                                horizontal: VisualDensity
                                                    .minimumDensity,
                                                vertical: VisualDensity
                                                    .minimumDensity,
                                              ),
                                            ),
                                            RadioListTile<String>(
                                              title:
                                                  const Text("Middle Element"),
                                              onChanged:
                                                  parameterRadioListChanged,
                                              groupValue: _elementToSearchFor,
                                              value: "middle",
                                              visualDensity:
                                                  const VisualDensity(
                                                horizontal: VisualDensity
                                                    .minimumDensity,
                                                vertical: VisualDensity
                                                    .minimumDensity,
                                              ),
                                            ),
                                            RadioListTile<String>(
                                              title: const Text("Last Element"),
                                              onChanged:
                                                  parameterRadioListChanged,
                                              groupValue: _elementToSearchFor,
                                              value: "last",
                                              visualDensity:
                                                  const VisualDensity(
                                                horizontal: VisualDensity
                                                    .minimumDensity,
                                                vertical: VisualDensity
                                                    .minimumDensity,
                                              ),
                                            ),
                                            RadioListTile<String>(
                                              title:
                                                  const Text("Random Element"),
                                              onChanged:
                                                  parameterRadioListChanged,
                                              groupValue: _elementToSearchFor,
                                              value: "random",
                                              visualDensity:
                                                  const VisualDensity(
                                                horizontal: VisualDensity
                                                    .minimumDensity,
                                                vertical: VisualDensity
                                                    .minimumDensity,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
              child: ElevatedButton(
                onPressed: startButtonPressed,
                child: const Text("Start"),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, double.infinity),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
