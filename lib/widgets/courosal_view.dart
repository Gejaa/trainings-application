import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:mytrainingsapp/model/trainings_model.dart';
import 'package:mytrainingsapp/screens/training_details_screen.dart';
import 'package:mytrainingsapp/utils/color_utils.dart';
import 'package:mytrainingsapp/utils/image_utils.dart';
import 'package:mytrainingsapp/utils/string_utils.dart';

class CarouselView extends StatefulWidget {
  List<TrainingsModel> trainingList = [];

  CarouselView({Key? key, required this.trainingList}) : super(key: key);

  @override
  State<CarouselView> createState() => _CarouselViewState();
}

class _CarouselViewState extends State<CarouselView> {
  final CarouselController _controller = CarouselController();
  StringUtils string = StringUtils();
  ImageUtils image = ImageUtils();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 80,
          width: 35,
          decoration: BoxDecoration(color: Colors.black.withOpacity(0.5)),
          child: InkWell(
            onTap: () => _controller.previousPage(),
            child: const Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
              size: 20,
            ),
          ),
        ),
        Expanded(
          child: CarouselSlider(
            items: widget.trainingList.map((item) {
              return Padding(
                padding: const EdgeInsets.only(top: 20, bottom: 20),
                child: Container(
                  margin: const EdgeInsets.all(5.0),
                  color: Colors.transparent,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                    child: Stack(
                      children: [
                        Image.asset(
                          image.backgroundCarousel,
                          fit: BoxFit.cover,
                          height: 200,
                          width: MediaQuery.of(context).size.width,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(5.0)),
                            color: Colors.black.withOpacity(0.5),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item.training.toString() +(" (${item.rating})"),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  item.location.toString() +
                                      " " +
                                      item.durationDate.toString(),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          string.dollarSymbolText +
                                              item.mrp.toString(),
                                          style: TextStyle(
                                              color: ColorUtils.appPrimaryColor,
                                              fontSize: 12,
                                              decoration:
                                                  TextDecoration.lineThrough,
                                              fontWeight: FontWeight.w400),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          string.dollarSymbolText +
                                              item.discountedFinalAmount
                                                  .toString(),
                                          style: TextStyle(
                                              color: ColorUtils.appPrimaryColor,
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                    InkWell(
                                      onTap: () {
                                        Navigator.of(context).push(
                                            new MaterialPageRoute(
                                                builder: (context) =>
                                                    new TrainingDetailsScreen(trainingsModel: item,)));
                                      },
                                      child: Text(
                                        string.viewDetails +
                                            " " +
                                            string.forwardArrow,
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 15,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            }).toList(),
            options: CarouselOptions(
                autoPlay: true,
                enlargeCenterPage: true,
                height: 220,
                viewportFraction: 1.0),
            carouselController: _controller,
          ),
        ),
        Container(
          height: 80,
          width: 35,
          decoration: BoxDecoration(color: Colors.black.withOpacity(0.5)),
          child: InkWell(
            onTap: () => _controller.nextPage(),
            child: const Icon(
              Icons.arrow_forward_ios,
              color: Colors.white,
              size: 20,
            ),
          ),
        ),
      ],
    );
  }
}
