import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:search_algorithm_visualiser/screens/details_screen.dart';
import 'package:search_algorithm_visualiser/searches/search_class.dart';
import 'package:search_algorithm_visualiser/widgets/algorithm_selection.dart';
import 'package:search_algorithm_visualiser/widgets/parameter_selection.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double _arraySizeSlider = 0;
  SearchAlgorithm? _algorithm = SearchAlgorithm.linear;
  String? _elementToSearchFor;
  TextEditingController _textEditingController = TextEditingController()
    ..clear();

  late int _maximumArraySize;

  void parameterRadioListChanged(String? val) {
    setState(() {
      _elementToSearchFor = val;
    });
  }

  void sliderParameterChanged(double? val) {
    setState(() {
      _arraySizeSlider = val!;
    });
  }

  TextEditingController getController() {
    return _textEditingController;
  }

  @override
  void initState() {
    super.initState();
    _maximumArraySize = SearchClass.getMaxArraySize();
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

      int fixedStep = 0;
      if (_algorithm == SearchAlgorithm.fixed) {
        if (_textEditingController.value.text.isNotEmpty) {
          fixedStep = int.parse(_textEditingController.value.text);
        } else {
          showErrorDialog(context);
          return;
        }
      }

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

      // Navigator.push(
      //     context,
      //     MaterialPageRoute(
      //       builder: (context) => customPainterBuilder(
      //         context,
      //         arrSize,
      //         searchFor,
      //         algorithm,
      //         fixedStep,
      //       ),
      //     ));

      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailsScreen(
              arrSize: arrSize,
              fixedStep: fixedStep,
              searchFor: searchFor,
              algorithm: algorithm,
            ),
          ));
    } else {
      showErrorDialog(context);
    }
  }

  void algorithmRadioListChanged(SearchAlgorithm? val) {
    setState(() {
      _algorithm = val!;
    });
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
                      child: AlgorithmSelection(
                        setCallback: algorithmRadioListChanged,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.45,
                      height: MediaQuery.of(context).size.height * 0.85,
                      child: ParameterSelection(
                        algorithm: _algorithm!,
                        maximumArraySize: _maximumArraySize.toDouble(),
                        radioSetCallback: parameterRadioListChanged,
                        sliderSetCallback: sliderParameterChanged,
                        getEditingController: getController,
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
