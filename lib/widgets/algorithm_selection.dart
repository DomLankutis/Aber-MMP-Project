import 'package:flutter/material.dart';
import 'package:search_algorithm_visualiser/misc/helper.dart';
import 'package:search_algorithm_visualiser/widgets/color_explainer.dart';
import 'package:search_algorithm_visualiser/widgets/info_widget.dart';

enum SearchAlgorithm { linear, binary, fixed, increasingStep }

class AlgorithmSelection extends StatefulWidget {
  final Function(SearchAlgorithm? val) setCallback;

  const AlgorithmSelection({Key? key, required this.setCallback})
      : super(key: key);

  @override
  AlgorithmSelectionState createState() => AlgorithmSelectionState();
}

class AlgorithmSelectionState extends State<AlgorithmSelection> {
  SearchAlgorithm _searchAlgorithm = SearchAlgorithm.linear;

  AlgorithmSelectionState();

  void algorithmRadioListChanged(SearchAlgorithm? val) {
    widget.setCallback(val);
    setState(() {
      _searchAlgorithm = val!;
    });
  }

  List<Widget> algorithmSelection() {
    List<Widget> radioList = List.empty(growable: true);

    for (SearchAlgorithm search in SearchAlgorithm.values) {
      radioList.add(RadioListTile<SearchAlgorithm>(
          title: Text(getAlgorithmName(search)),
          value: search,
          groupValue: _searchAlgorithm,
          onChanged: algorithmRadioListChanged,
          visualDensity: const VisualDensity(
            horizontal: VisualDensity.minimumDensity,
            vertical: VisualDensity.minimumDensity,
          )));
    }

    return radioList;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 6),
                      child: Text("Select Algorithm"),
                    ),
                    InfoWidget(
                      information:
                          "Select the algorithm you would like to search with.",
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.4,
                  alignment: const AlignmentDirectional(0, 0),
                  child: Card(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
                      child: SingleChildScrollView(
                        child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: algorithmSelection()),
                      ),
                    ),
                  ),
                ),
              ),
              ColorExplainer(
                algorithm: _searchAlgorithm,
              ),
            ],
          ),
        ));
  }
}
