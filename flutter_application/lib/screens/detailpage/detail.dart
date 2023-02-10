import 'dart:async';
import 'dart:math';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/screens/detailpage/widgets/cards.dart';
import 'package:movie_app/screens/detailpage/widgets/getGenres.dart';
import 'package:movie_app/screens/detailpage/widgets/posterAndTitle.dart';
import 'package:movie_app/screens/detailpage/widgets/yearAndRating.dart';
import '../../constants/colors.dart';
import '../../models/credits.dart';
import '../../models/movie_detail.dart';
import '../../service/dieMethods.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({super.key, required this.movieId});

  final int movieId;
  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> with TickerProviderStateMixin {
  double rate = 1;
  late final AnimationController _addedController;
  late final AnimationController _removedController;

  @override
  void initState() {
    super.initState();
    _addedController = AnimationController(vsync: this);
    _removedController = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _addedController.dispose();
    _removedController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var sizeWidth = size.width;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(),
      body: Center(
        child: SingleChildScrollView(
          child: FutureBuilder<MovieDetails>(
              future: MovieDatas().getMovieDetails(widget.movieId),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasData) {
                  final value = snapshot.data!;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      posterAndTitle(sizeWidth: sizeWidth, value: value),
                      yearAndRating(value: value),
                      const Padding(
                        padding: EdgeInsets.only(left: 150, top: 10),
                        child: Text(
                          'Description',
                          style: TextStyle(
                              color: textbuttonColor,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 12.0, horizontal: 8),
                          child: Text(
                            value.overview!,
                            style: TextStyle(color: logoColor, fontSize: 15),
                          ),
                        ),
                      ),
                      getGenres(value: value),
                      const Padding(
                        padding: EdgeInsets.only(left: 8.0),
                        child: Text(
                          "Cast",
                          style: TextStyle(
                              color: logoColor,
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(
                        height: 200,
                        child: FutureBuilder<List<Cast>>(
                          future: MovieDatas().getCharacters(value.id!),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return ListView.builder(
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  itemCount: snapshot.data!.length,
                                  itemBuilder: (context, index) {
                                    final value = snapshot.data![index];
                                    return CustomCastCard(value: value);
                                  });
                            } else {
                              return const Text("");
                            }
                          },
                        ),
                      ),
                    ],
                  );
                } else if (snapshot.hasError) {
                  return const Text(
                      "Some error occured. Please try again later.");
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              }),
        ),
      ),
    );
  }
}
