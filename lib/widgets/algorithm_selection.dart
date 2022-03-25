import 'package:flutter/material.dart';
import 'package:search_algorithm_visualiser/widgets/help_widget.dart';

enum SearchAlgorithm { linear, binary, fixed }

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

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          const Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 10),
            child: Text("Select Algorithm"),
          ),
          Expanded(
            child: Align(
              alignment: const AlignmentDirectional(0, 0),
              child: Padding(
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
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RadioListTile<SearchAlgorithm>(
                            title: const Text('Linear Search'),
                            value: SearchAlgorithm.linear,
                            groupValue: _searchAlgorithm,
                            onChanged: (algorithmRadioListChanged),
                            visualDensity: const VisualDensity(
                              horizontal: VisualDensity.minimumDensity,
                              vertical: VisualDensity.minimumDensity,
                            ),
                          ),
                          RadioListTile<SearchAlgorithm>(
                            title: const Text('Binary Search'),
                            value: SearchAlgorithm.binary,
                            groupValue: _searchAlgorithm,
                            onChanged: (algorithmRadioListChanged),
                            visualDensity: const VisualDensity(
                              horizontal: VisualDensity.minimumDensity,
                              vertical: VisualDensity.minimumDensity,
                            ),
                          ),
                          RadioListTile<SearchAlgorithm>(
                            title: const Text('Fixed Step Search'),
                            value: SearchAlgorithm.fixed,
                            groupValue: _searchAlgorithm,
                            onChanged: (algorithmRadioListChanged),
                            visualDensity: const VisualDensity(
                              horizontal: VisualDensity.minimumDensity,
                              vertical: VisualDensity.minimumDensity,
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
            child: HelpWidget(
              algorithm: _searchAlgorithm,
            ),
          )
        ],
      ),
    );
  }
}
