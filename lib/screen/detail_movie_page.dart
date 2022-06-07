import 'dart:ui';
 
import 'package:flutter/material.dart';
import '../screen/detail_person_page.dart';
// import '../components/textStyle.dart';
import '../components/textStyle.dart';
import '../module/detail_movie_module.dart';
import '../network/network_request.dart';

class DetailMoviePage extends StatefulWidget {
  final int id;

  const DetailMoviePage({Key? key, required this.id}) : super(key: key);
  @override
  State<DetailMoviePage> createState() => _DetailMoviePageState(id);
}

class _DetailMoviePageState extends State<DetailMoviePage> {
  final int? id;
  final String apiKey = NetworkRequest.apiKey;
  final String urlImg = NetworkRequest.urlImg;
  final String urlLogo = NetworkRequest.urlLogo;
  final String urlMovies = NetworkRequest.urlMovies;
  _DetailMoviePageState(this.id);
  
  late Future<DetailMovie> uriMovie;

  @override
  void initState() {
    super.initState();
    loadingData();
  }

  loadingData() async {
    await Future.wait(
        [uriMovie = fetchDataDetailsMovies('$urlMovies$id$apiKey')]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0x000F0F0F),
      // appBar: AppBar(
      // ),
      body: SafeArea(child: _body()),
    );
  }

  Widget _body() {
    return FutureBuilder<DetailMovie>(
      future: uriMovie,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Stack(
            children: [
              showDetailList(snapshot),
              Positioned(
              child: ClipRect(
                child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 6000, sigmaY: 6000),
                    child: Positioned(
                        top: 0,
                        right: 0,
                        child: SizedBox(child: titleName(snapshot)))),
              ),
            )
            ],
          );
        } else if (snapshot.hasError) {
          return Center(child: Text("Error", style: textStyle(12)));
        }
        return Center(child: Text("Loading...", style: textStyle(12)));
      },
    );
  }

  Widget showDetailList(AsyncSnapshot<DetailMovie> snapshot) {
    return ListView(
      shrinkWrap: true,
      children: [
        Stack(
          alignment: Alignment.topCenter,
          children: [
            Column(
              children: [
                imagePosterPath(snapshot),
                textDateTimeAndTitle(snapshot),
                iconMovie(),
                rateStart(),
                showLogoImg(snapshot),
                textOverview(snapshot),
                Column(
                  children: [
                    const SizedBox(
                      height: 40,
                    ),
                    textList1(snapshot),
                    const SizedBox(
                      height: 60,
                    ),
                    textList2(snapshot),
                  ],
                ),
                showDirector(snapshot),
                showCast(snapshot),
              ],
            ),
            
          ],
        ),
      ],
    );
  }

  Widget showLogoImg(AsyncSnapshot<DetailMovie> snapshot) {
    return Container(
      decoration: textUnderline(),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Container(
          margin: const EdgeInsets.all(20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ...List.generate(
                snapshot.data?.productionCompanies?.length ?? 0,
                (index) {
                  if (snapshot.data?.productionCompanies?[index].logoPath ==
                      null) {
                    return const Text('');
                  } else {
                    return Container(
                      margin: const EdgeInsets.only(right: 30),
                      child: Image.network(
                        "$urlLogo${snapshot.data?.productionCompanies?[index].logoPath}",
                      ),
                    );
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget showDirector(AsyncSnapshot<DetailMovie> snapshot) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 30),
        Container(
            margin:
                const EdgeInsets.only(bottom: 5, top: 5, left: 20, right: 20),
            child: Text('Director', style: textStyle(12))),
        Container(
          decoration: textUnderline(),
          child: Container(
            margin:
                const EdgeInsets.only(bottom: 10, top: 10, left: 20, right: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ...List.generate(
                  snapshot.data?.credits?.crew?.length ?? 0,
                  (index) {
                    if (snapshot.data?.credits?.crew?[index].job ==
                        'Director') {
                      return Container(
                        margin: const EdgeInsets.only(bottom: 5, top: 5),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DetailPersonPage(
                                      id: snapshot
                                          .data?.credits?.crew?[index].id),
                                ));
                          },
                          child: Row(
                            children: [
                              CircleAvatar(
                                backgroundImage: NetworkImage(
                                    '$urlLogo${snapshot.data?.credits?.crew?[index].profilePath}'),
                              ),
                              const SizedBox(
                                width: 30,
                              ),
                              Text(
                                '${snapshot.data?.credits?.crew?[index].originalName} ',
                                style: textStyle(15),
                              ),
                            ],
                          ),
                        ),
                      );
                    } else {
                      return Container(
                          decoration: const BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                                      color: Colors.white, width: 0.0000001))));
                    }
                  },
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget showCast(AsyncSnapshot<DetailMovie> snapshot) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 30),
        Container(
            margin:
                const EdgeInsets.only(bottom: 5, top: 5, left: 20, right: 20),
            child: Text('Cast', style: textStyle(12))),
        Container(
          decoration: textUnderline(),
          child: Container(
            margin:
                const EdgeInsets.only(bottom: 10, top: 10, left: 20, right: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ...List.generate(
                  5,
                  (index) {
                    return Container(
                      margin: const EdgeInsets.only(bottom: 10, top: 10),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DetailPersonPage(
                                    id: snapshot
                                        .data?.credits?.cast?[index].id),
                              ));
                        },
                        child: Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: snapshot.data?.credits?.cast != null
                                  ? CircleAvatar(
                                      backgroundImage: NetworkImage(
                                          '$urlLogo${snapshot.data?.credits?.cast?[index].profilePath}'),
                                    )
                                  : const CircleAvatar(child: Text('CT')),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Expanded(
                              flex: 6,
                              child: Container(
                                decoration: textUnderlineChild(),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${snapshot.data?.credits?.cast?[index].originalName} ',
                                      style: textStyle(15),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      '${snapshot.data?.credits?.cast?[index].character} ',
                                      style: textStyle(10),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget titleName(AsyncSnapshot<DetailMovie> snapshot) {
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: backButton(),
          ),
          const SizedBox(
            width: 15,
          ),
          Expanded(
            flex: 7,
            child: textNameTitle('${snapshot.data?.title}'),
          ),
        ],
      ),
    );
  }

  Widget imagePosterPath(AsyncSnapshot<DetailMovie> snapshot) {
    return Image.network(
      "$urlImg${snapshot.data?.posterPath}",
    );
  }

  Widget textOverview(AsyncSnapshot<DetailMovie> snapshot) {
    return Container(
      decoration: textUnderline(),
      child: Container(
        margin: const EdgeInsets.all(20),
        child: Text(
          "${snapshot.data?.overview}",
          style: textStyle(
            18,
          ),
        ),
      ),
    );
  }

  Widget textDateTimeAndTitle(AsyncSnapshot<DetailMovie> snapshot) {
    return Container(
      margin: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "${snapshot.data?.releaseDate} ~ ${snapshot.data?.runtime} min",
            style: textStyle(
              15,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            "${snapshot.data?.originalTitle}",
            style: textStyle(
              30,
            ),
          )
        ],
      ),
    );
  }

  Widget iconMovie() {
    return SizedBox(
      height: 100,
      child: Row(
        children: [
          Expanded(child: iconBottom(Icons.play_circle_outline, 40)),
          Expanded(child: iconBottom(Icons.add, 40)),
          Expanded(child: iconBottom(Icons.ios_share_outlined, 40)),
        ],
      ),
    );
  }

  Widget textList1(AsyncSnapshot<DetailMovie> snapshot) {
    return Container(
      decoration: textUnderline(),
      child: Container(
        margin: const EdgeInsets.all(20),
        child: Row(
          children: [
            Expanded(child: Text('Custom Lists', style: textStyle(15))),
            const Expanded(
              child: SizedBox(),
            ),
            Text("None", style: textStyle(15)),
            const Icon(
              Icons.navigate_next,
              color: Color(0xFFffffff),
            ),
          ],
        ),
      ),
    );
  }

  Widget textList2(AsyncSnapshot<DetailMovie> snapshot) {
    return Container(
      decoration: textUnderline(),
      child: Container(
        margin: const EdgeInsets.all(20),
        child: Column(
          children: [
            Container(
              height: 30,
              decoration: textUnderlineChild(),
              child: Row(
                children: [
                  Expanded(child: Text('Release Date', style: textStyle(15))),
                  const Expanded(
                    child: SizedBox(),
                  ),
                  Text("${snapshot.data?.releaseDate}", style: textStyle(15)),
                ],
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Container(
              height: 30,
              decoration: textUnderlineChild(),
              child: Row(
                children: [
                  Expanded(child: Text('Runtime', style: textStyle(15))),
                  const Expanded(
                    child: SizedBox(),
                  ),
                  Text("${snapshot.data?.runtime} min", style: textStyle(15)),
                ],
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Container(
              height: 30,
              decoration: textUnderlineChild(),
              child: Row(
                children: [
                  Expanded(child: Text('Rating', style: textStyle(15))),
                  const Expanded(
                    child: SizedBox(),
                  ),
                  Text("${snapshot.data?.voteAverage}", style: textStyle(15)),
                ],
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            SizedBox(
              height: 25,
              child: Row(
                children: [
                  Expanded(child: Text('Genre', style: textStyle(15))),
                  const Expanded(
                    child: SizedBox(),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ...List.generate(
                        snapshot.data!.genres!.length < 2
                            ? snapshot.data!.genres!.length
                            : 2,
                        (index) {
                          if (snapshot.data?.genres?[index].name == null) {
                            return const Text('');
                          } else {
                            return Text(
                                "${snapshot.data?.genres?[index].name}, ",
                                style: textStyle(15));
                          }
                        },
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget rateStart() {
    return Container(
      decoration: textUnderline(),
      child: Container(
        margin: const EdgeInsets.all(20),
        height: 60,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'My Rating',
              style: textStyle(
                10,
              ),
            ),
            Text(
              'Rate This Movie',
              style: textStyle(
                18,
              ),
            ),
            Row(
              children: [
                iconRate(Icons.star),
                iconRate(Icons.star),
                iconRate(Icons.star),
                iconRate(Icons.star),
                iconRate(Icons.star),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget backButton() {
    return Container(
      margin: const EdgeInsets.only(bottom: 5, top: 5),
      height: 40,
      width: 20,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(90),
        color: const Color(0xffFFFFFF),
      ),
      child: const Icon(
        Icons.arrow_back_ios_new,
        color: Color(0xFF000000),
      ),
    );
  }
}
