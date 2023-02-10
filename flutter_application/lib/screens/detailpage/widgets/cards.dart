// bazılarının biyografisi yok onları hallet
import 'package:flutter/material.dart';
import 'package:movie_app/screens/detailpage/detail.dart';

import '../../../constants/api.dart';
import '../../../constants/numbers.dart';
import '../../../models/credits.dart';



class CustomCastCard extends StatefulWidget {
  const CustomCastCard({
    Key? key,
    required this.value,
  }) : super(key: key);

  final Cast value;

  @override
  State<CustomCastCard> createState() => _CustomCardState();
}

class _CustomCardState extends State<CustomCastCard> {
  @override
  Widget build(BuildContext context) {
    // circleavatar yerine container'a dön
    return Padding(
      padding: const EdgeInsets.only(right: 12.0),
      child: Column(
        children: [
          SizedBox(
            height: 100,
            width: 80,
            child: (widget.value.profilePath == null)
                ? Container(
                    height: 200,
                    width: 200,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: Image.network(
                          defaultCastImage,
                          fit: BoxFit.fill,
                        )))
                : Container(
                    height: 70,
                    width: 80,
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle, color: Colors.black),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: Image.network(
                        "$imageBaseUrl${widget.value.profilePath}",
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 5.0,
            ),
            child: SizedBox(
              width: 140,
              child: Column(
                children: [
                  Text(
                    widget.value.originalName!,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    widget.value.character!,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 4,
                    softWrap: true,
                    style: const TextStyle(
                        fontWeight: FontWeight.w300,
                        color: Color.fromARGB(255, 0, 0, 0)),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}


