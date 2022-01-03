import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mytrainingsapp/model/sort_array_list_model.dart';
import 'package:mytrainingsapp/utils/color_utils.dart';
import 'package:mytrainingsapp/utils/string_utils.dart';

class SortDialogView extends StatefulWidget {
  List<String> locationList = [];
  List<String> trainingNameList = [];
  List<String> trainerList = [];
  String selectedLocation = "";
  String selectedTrainingName = "";
  List<String> selectedTrainerLisy = [];

  SortDialogView(
      {Key? key,
      required this.locationList,
      required this.trainerList,
      required this.trainingNameList,
      required this.selectedTrainerLisy,
      required this.selectedTrainingName,
      required this.selectedLocation})
      : super(key: key);

  @override
  State<SortDialogView> createState() => _SortDialogViewState();
}

class _SortDialogViewState extends State<SortDialogView> {
  StringUtils string = StringUtils();
  int selectedIndex = 1;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      height: MediaQuery.of(context).size.height / 1.5,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  string.sortAndFilters,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                InkWell(
                  onTap: () {
                    SortArrayListModel sortArray = SortArrayListModel(
                        trainingNameList: widget.selectedTrainingName,
                        trainerList: widget.selectedTrainerLisy,
                        locationList: widget.selectedLocation);
                    Navigator.pop(context, sortArray);
                  },
                  child: Icon(
                    Icons.close,
                    color: Colors.grey,
                    size: 20,
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width / 2,
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Container(
                        decoration: BoxDecoration(
                            color: selectedIndex == index
                                ? Colors.white
                                : Colors.grey.withOpacity(0.2),
                            border: Border(
                                left: BorderSide(
                                    width: 5.0,
                                    color: selectedIndex == index
                                        ? ColorUtils.appPrimaryColor
                                        : Colors.transparent))),
                        child: ListTile(
                          onTap: () {
                            setState(() {
                              selectedIndex = index;
                            });
                          },
                          title: Text(
                            string.sortList[index],
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 17,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                      );
                    },
                    itemCount: string.sortList.length,
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width / 2,
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: AlwaysScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return selectedIndex == 0
                          ? Center(
                              child: Text(
                                "Please use location,Training Name and Trainer fiters or now.",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 17,
                                    fontWeight: FontWeight.w400),
                              ),
                            )
                          : ListTile(
                              leading: containsValueBorder(index: index)
                                  ? Container(
                                      height: 20,
                                      width: 20,
                                      color: ColorUtils.appPrimaryColor,
                                      child: Icon(
                                        Icons.check,
                                        color: Colors.white,
                                        size: 15,
                                      ),
                                    )
                                  : Container(
                                      height: 20,
                                      width: 20,
                                      decoration: BoxDecoration(
                                          border:
                                              Border.all(color: Colors.grey)),
                                    ),
                              onTap: () {
                                setState(() {
                                  if (selectedIndex == 1) {
                                    widget.selectedLocation
                                    =(widget.locationList[index]);
                                  } else if (selectedIndex == 2) {
                                    widget.selectedTrainingName=
                                    (widget.trainingNameList[index]);
                                  } else if (selectedIndex == 3) {
                                    if (widget.selectedTrainerLisy.length >=
                                        9) {
                                      Fluttertoast.showToast(
                                          msg: string.exceedsLimit,
                                          textColor: Colors.white,
                                          backgroundColor: Colors.black);
                                    } else {
                                      widget.selectedTrainerLisy.contains(
                                              widget.trainerList[index])
                                          ? widget.selectedTrainerLisy
                                              .remove(widget.trainerList[index])
                                          : widget.selectedTrainerLisy
                                              .add(widget.trainerList[index]);
                                    }
                                  } else {}
                                });
                              },
                              title: Text(
                                determining(index: false)[index],
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 17,
                                    fontWeight: FontWeight.w400),
                              ),
                            );
                    },
                    itemCount: determining(index: true),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  determining({required bool index}) {
    if (selectedIndex == 0) {
      return 1;
    } else if (selectedIndex == 1) {
      return index ? widget.locationList.length : widget.locationList;
    } else if (selectedIndex == 2) {
      return index ? widget.trainingNameList.length : widget.trainingNameList;
    } else if (selectedIndex == 3) {
      return index ? widget.trainerList.length : widget.trainerList;
    } else {
      return 0;
    }
  }

  bool containsValueBorder({required int index}) {
    if (selectedIndex == 1) {
      return widget.selectedLocation.contains(widget.locationList[index])
          ? true
          : false;
    } else if (selectedIndex == 2) {
      return widget.selectedTrainingName
              .contains(widget.trainingNameList[index])
          ? true
          : false;
    } else if (selectedIndex == 3) {
      return widget.selectedTrainerLisy.contains(widget.trainerList[index])
          ? true
          : false;
    } else {
      return false;
    }
  }
}
