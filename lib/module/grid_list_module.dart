import 'package:flutter/material.dart';

import '../screen/detail_movie_page.dart';

String? theMovies;

GridView gridViewBuilder(AsyncSnapshot<dynamic> snapshot) {
  return GridView.builder(
      itemCount: snapshot.data?.results?.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 2 / 3,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
      ),
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      DetailMoviePage(id: snapshot.data?.results?[index].id),
                ));
          },
          child: Image.network(
              "https://image.tmdb.org/t/p/w300/${snapshot.data?.results?[index].posterPath}"),
        );
      });
}

//  void _getMovieData() async {
  //   setState(() {
  //     isLoading = true;
  //   });
  //   final response = await http.get(Uri.parse(url));
  //   final data = jsonDecode(response.body) as Map<String, dynamic>?;
  //   if (data == null) {
  //     return;
  //   }
  //   final theMovies = Movie.fromJson(data);
  //   setState(() {
  //     isLoading = false;
  //     this.theMovies = theMovies.backdropPath;
  //   });
  // }
