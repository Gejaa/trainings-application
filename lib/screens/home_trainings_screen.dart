import 'package:firebase_core/firebase_core.dart';
import "package:flutter/material.dart";
import 'package:mytrainingsapp/model/sort_array_list_model.dart';
import 'package:mytrainingsapp/model/trainings_model.dart';
import 'package:mytrainingsapp/repository/training_sorting_repo.dart';
import 'package:mytrainingsapp/services/firebase_get.dart';
import 'package:mytrainingsapp/utils/color_utils.dart';
import 'package:mytrainingsapp/utils/string_utils.dart';
import 'package:mytrainingsapp/widgets/card_view.dart';
import 'package:mytrainingsapp/widgets/courosal_view.dart';
import 'package:mytrainingsapp/widgets/sort_dialog_view.dart';

class HomeTrainingsScreen extends StatefulWidget {
  final FirebaseApp firebaseApp;

  const HomeTrainingsScreen({Key? key, required this.firebaseApp})
      : super(key: key);

  @override
  State<HomeTrainingsScreen> createState() => _HomeTrainingsScreenState();
}

class _HomeTrainingsScreenState extends State<HomeTrainingsScreen> {
  StringUtils string = StringUtils();
  List<String> locationList = [];
  List<String> trainingNameList = [];
  List<String> trainerList = [];
  String selectedLocation ="";
  String selectedTrainingName = "";
  List<String> selectedTrainerLisy = [];
  List<TrainingsModel> carouselTrainingsModel = [];
  late TrainingRepository trainingRepository;
  final ScrollController _listScrollController = ScrollController();
  bool loadingInitialDataStatus = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getInitialDataFromDatabase();
    trainingRepository = TrainingRepository();
    _listScrollController.addListener(_scrollListener);
  }

  getInitialDataFromDatabase() async {
    try {
      await FirebaseGet.getMdData().then((value) {
        setState(() {
          locationList = value.location!;
          trainingNameList = value.trainingName!;
          trainerList = value.trainer!;
        });
      }).then((value) async {
        await FirebaseGet.getCourosalData().then((value) {
          setState(() {
            carouselTrainingsModel = value;
          });
        });
      }).then((value) {
        setState(() {
          selectedTrainingName="Safe Scrum Master";
          selectedLocation="West Des Moines";
          selectedTrainerLisy=["Aaron"];
          loadingInitialDataStatus = false;
        });
      });
    } catch (e) {
      //print(e.toString());
    }
  }

  void _scrollListener() {
    if (_listScrollController.offset >=
            _listScrollController.position.maxScrollExtent &&
        !_listScrollController.position.outOfRange) {
      trainingRepository.requestMoreData(
          scrolled: true,
          sortArrayListModel: SortArrayListModel(
              trainingNameList: selectedTrainingName,
              trainerList: selectedTrainerLisy,
              locationList: selectedLocation));
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: ColorUtils.appPrimaryColor,
          title: Text(
            string.trainings,
            style: const TextStyle(
                color: Colors.white, fontSize: 25, letterSpacing: 0.5),
          ),
          actions: const [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(
                Icons.menu,
                color: Colors.white,
                size: 30,
              ),
            )
          ],
        ),
        body: SingleChildScrollView(
          controller: _listScrollController,
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  Column(
                    children: [
                      Container(
                        height: 200,
                        color: ColorUtils.appPrimaryColor,
                      ),
                      Container(
                        height: 150,
                        color: Colors.white,
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Container(
                          alignment: FractionalOffset.centerLeft,
                          child: Text(
                            string.highlights,
                            style: const TextStyle(
                                color: Colors.white, fontSize: 20),
                          ),
                        ),
                      ),
                      loadingInitialDataStatus
                          ? Container(height: 200)
                          : CarouselView(
                              trainingList: carouselTrainingsModel,
                            ),
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Container(
                          alignment: FractionalOffset.centerLeft,
                          child: InkWell(
                            onTap: () {
                              showModalBottomSheet(
                                  isDismissible: false,
                                  enableDrag: false,
                                  context: context,
                                  builder: (BuildContext cnt) {
                                    return WillPopScope(
                                      onWillPop: () => Future.value(false),
                                      child: SortDialogView(
                                        locationList: locationList,
                                        trainerList: trainerList,
                                        trainingNameList: trainingNameList,
                                        selectedLocation: selectedLocation,
                                        selectedTrainerLisy: selectedTrainerLisy,
                                        selectedTrainingName: selectedTrainingName,
                                      ),
                                    );
                                  }).then((value) {
                                print(value);
                                if (value is SortArrayListModel) {
                                  print(value.trainerList.length);
                                  setState(() {
                                    selectedLocation=value.locationList;
                                    selectedTrainingName=value.trainingNameList;
                                    selectedTrainerLisy=value.trainerList;
                                  });
                                }
                              });
                            },
                            child: Container(
                              width: 80,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5.0),
                                  border: Border.all(
                                      color: Colors.grey, width: 1.0)),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    const Icon(
                                      Icons.filter_list_outlined,
                                      color: Colors.grey,
                                      size: 15,
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      string.filter,
                                      style: const TextStyle(
                                          color: Colors.grey, fontSize: 16),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
              loadingInitialDataStatus
                  ? Text(
                      string.noData,
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 15),
                    )
                  : StreamBuilder(
                      stream: trainingRepository.listenToRealTime(
                          scrolled: false,
                          sortArrayListModel: SortArrayListModel(
                              trainingNameList: selectedTrainingName,
                              trainerList: selectedTrainerLisy,
                              locationList: selectedLocation)),
                      builder: (context, AsyncSnapshot snapshot) {
                        if (snapshot.hasData) {
                          print(snapshot.data.length);
                          return snapshot.data.length == 0
                              ? Text(
                                  string.emptyString,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15),
                                )
                              : CardView(trainingList: snapshot.data);
                        } else {
                          return Container();
                        }
                      }),
            ],
          ),
        ),
      ),
    );
  }
}
