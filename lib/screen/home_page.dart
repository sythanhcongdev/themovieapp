
import 'package:flutter/material.dart';
import '../components/bottom_home_component.dart';
import '../components/textStyle.dart';
import '../network/network_request.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
class MyHomePage extends StatefulWidget {
  const MyHomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  static const urlNowPlaying = NetworkRequest.urlNowPlaying;
  static const urlUpcoming = NetworkRequest.urlUpcoming;
  late TabController _tabController;
int _nextPage = 1;
    bool _loading = true;
    bool _canLoadMore = true;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);

    fetchDataMovies(urlNowPlaying);
     fetchDataMovies(urlUpcoming);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(15, 15, 15, 0),
      // appBar: AppBar(),
      body: SafeArea(child: _body()),
    );
  }

  Widget _body() {
    return Column(
      children: [
        Expanded(
          flex: 2,
          child: tabBar(),
        ),
        Expanded(
          flex: 30,
          child: tabBarView(),
        ),
        Expanded(
          flex: 2,
          child: bottomListMovie(),
        ),
      ],
    );
  }

  Widget tabBar() {
    return Container(
      margin: const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: const Color(0xff626275),
      ),
      child: TabBar(
        indicator: BoxDecoration(
            borderRadius: BorderRadius.circular(50), // Creates border
            color: Colors.red),
        controller: _tabController,
        tabs: [
          Tab(child: textHeader('In Theaters')),
          Tab(
            child: textHeader('Upcoming'),
          ),
        ],
      ),
    );
  }

  TabBarView tabBarView() {
    return TabBarView(
      controller: _tabController,
      children: [
        gridListMovie(fetchDataMovies(urlNowPlaying)),
        gridListMovie(fetchDataMovies(urlUpcoming)),
      ],
    );
  }
}
