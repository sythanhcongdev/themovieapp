import 'package:flutter/material.dart';

import '../components/textStyle.dart';
import '../module/detail_person_module.dart';
import '../network/network_request.dart';

class DetailPersonPage extends StatefulWidget {
  final int? id;
  const DetailPersonPage({
    Key? key,
    this.id,
  }) : super(key: key);

  @override
  State<DetailPersonPage> createState() => _DetailPersonPageState(id);
}

class _DetailPersonPageState extends State<DetailPersonPage>
    with TickerProviderStateMixin {
  final int? id;
  final String apiKey = NetworkRequest.apiKey;
  final String apiKeyDetailPerson = NetworkRequest.apiKeyDetailPerson;
  final String apiKeyMvCredit = NetworkRequest.apiKeyMvCredit;
  final String urlImg = NetworkRequest.urlImg;
  final String urlImgPerson = NetworkRequest.urlImgPerson;
  final String urlLogo = NetworkRequest.urlLogo1;
  final String urlPerson = NetworkRequest.urlPerson;
  _DetailPersonPageState(this.id);
  late Future<DetailPerson> uriPerson;
  late Future<Credit> uriPersonMovie;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    uriPerson = fetchDataDetailsPerson('$urlPerson$id$apiKeyDetailPerson');
    uriPersonMovie = fetchDataCredits('$urlPerson$id$apiKeyMvCredit');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0x000F0F0F),
      // appBar: AppBar(
      // ),
      body: SafeArea(child: _body()),
    );
  }

  Widget _body() {
    return Stack(
      children: [
        FutureBuilder<DetailPerson>(
          future: uriPerson,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return showDetailList(snapshot);
            } else if (snapshot.hasError) {
              return Center(child: Text("Error", style: textStyle(12)));
            }
            return Center(child: Text("Loading...", style: textStyle(12)));
          },
        )
      ],
    );
  }

  Widget showDetailList(AsyncSnapshot<DetailPerson> snapshot) {
    return Column(
      children: [
        titleName(snapshot),
        SizedBox(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.3,
            child: Stack(
              children: [
                Column(
                  children: [
                    imagePosterPath(snapshot),
                    detail(snapshot),
                  ],
                ),
                Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    child: Container(child: imagePosterStack(snapshot))),
              ],
            )),
        tabBar(),
        Expanded(
          child: SizedBox(
              width: double.infinity,
              child: tabBarView(snapshot)),
        )
      ],
    );
  }

  Widget imagePosterPath(AsyncSnapshot<DetailPerson> snapshot) {
    return CircleAvatar(
      radius: 50,
      backgroundImage: NetworkImage(
        '$urlImgPerson${snapshot.data?.profilePath}',
      ),
    );
  }

  Widget imagePosterStack(AsyncSnapshot<DetailPerson> snapshot) {
    return Container(
        decoration: BoxDecoration(
      image: DecorationImage(
          image: AssetImage(
            '$urlImg${snapshot.data?.profilePath}',
          ),
          fit: BoxFit.cover),
    ));
  }

  Widget titleName(AsyncSnapshot<DetailPerson> snapshot) {
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
            child: textNameTitle('${snapshot.data?.name}'),
          ),
        ],
      ),
    );
  }

  Widget detail(AsyncSnapshot<DetailPerson> snapshot) {
    return SizedBox(
      child: Column(
        children: [
          const SizedBox(
            height: 15,
          ),
          textNameTitle('${snapshot.data?.birthday}'),
          Center(child: textNameTitle('${snapshot.data?.placeOfBirth}')),
          textNameTitle('${snapshot.data?.birthday}'),
        ],
      ),
    );
  }

  Widget tabBar() {
    return Container(
      height: 40,
      margin: const EdgeInsets.only(left: 90, right: 90, top: 10, bottom: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(7),
        color: const Color(0xff626275),
      ),
      child: TabBar(
        indicator: BoxDecoration(
            borderRadius: BorderRadius.circular(7), // Creates border
            color: Colors.red),
        controller: _tabController,
        tabs: [
          Tab(child: textHeader('Biography')),
          Tab(
            child: textHeader('Movies'),
          ),
        ],
      ),
    );
  }

  TabBarView tabBarView(AsyncSnapshot<DetailPerson> snapshot) {
    return TabBarView(
      controller: _tabController,
      children: [
        SingleChildScrollView(
          child: biography(snapshot),
        ),
        SingleChildScrollView(
          child: moviesToPerson(),
        ),
      ],
    );
  }

  Widget biography(AsyncSnapshot<DetailPerson> snapshot) {
    return Container(
        margin: const EdgeInsets.only(right: 20, left: 20, top: 10, bottom: 10),
        child: Text(
          '${snapshot.data?.biography}',
          style: textStyle(15),
        ));
  }

  Widget moviesToPerson() {
    return FutureBuilder<Credit>(
        future: uriPersonMovie,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Container(
              decoration: textUnderline(),
              child: Container(
                margin: const EdgeInsets.only(
                  right: 20,
                  left: 20,
                ),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ...List.generate(snapshot.data?.cast?.length as int,
                          (index) {
                        if (snapshot.data?.cast?[index].posterPath == null) {
                          return Text('');
                        } else {
                          return Container(
                              width: double.infinity,
                              height: 70,
                              margin: const EdgeInsets.only(right: 30),
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: SizedBox(
                                      width: 40,
                                      height: 50,
                                      child: Image.network(
                                        "$urlLogo${snapshot.data?.cast?[index].posterPath}",
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  Expanded(
                                    flex: 7,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        SizedBox(height: 10),
                                        Text(
                                            '${snapshot.data?.cast?[index].originalTitle}',
                                            style: textStyle(15)),
                                        SizedBox(height: 6),
                                        Text(
                                            '${snapshot.data?.cast?[index].releaseDate}',
                                            style: textStyle(10)),
                                      ],
                                    ),
                                  ),
                                ],
                              ));
                        }
                      }),
                    ]),
              ),
            );
          } else if (snapshot.hasError) {
            return Center(child: Text("Error1", style: textStyle(12)));
          }
          return Center(child: Text("Loading...", style: textStyle(12)));
        });
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
