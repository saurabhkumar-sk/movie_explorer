import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:movie_explorer/provider/movies_provider.dart';
import 'package:movie_explorer/views/movies_details.dart';
import 'package:provider/provider.dart';

class AllMoviesScreen extends StatefulWidget {
  const AllMoviesScreen({super.key});

  @override
  State<AllMoviesScreen> createState() => _AllMoviesScreenState();
}

class _AllMoviesScreenState extends State<AllMoviesScreen> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();

    context.read<MoviesProvider>().fetchMoviesData();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        if (context.read<MoviesProvider>().hasMoreData) {
          context.read<MoviesProvider>().fetchMoviesData();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.menu),
        title: const Text('Movies'),
        centerTitle: true,
      ),
      body: Consumer<MoviesProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading && provider.moviesList.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          } else if (provider.errorMessage.isNotEmpty) {
            return Center(child: Text(provider.errorMessage));
          } else if (provider.moviesList.isEmpty) {
            return const Center(child: Text('No Data Found'));
          } else {
            return ListView.builder(
              controller: _scrollController,
              itemCount:
                  provider.moviesList.length + (provider.isLoading ? 1 : 0),
              itemBuilder: (context, index) {
                if (index >= provider.moviesList.length) {
                  return const Center(child: CircularProgressIndicator());
                }

                final movies = provider.moviesList[index];

                final dateformat = movies['aired']['from'] != null
                    ? DateFormat('dd/MM/yyyy').format(
                        DateTime.tryParse(movies['aired']['from']) ??
                            DateTime.now(),
                      )
                    : 'Unknown Date';
                final image = movies['images']['jpg']['image_url'] ?? '';
                final title = movies['title']?.toString() ?? 'No Title';
                final duration =
                    movies['duration']?.toString() ?? 'Unknown Duration';
                final score = movies['score']?.toString() ?? 'No Score';
                final synopsis =
                    movies['synopsis']?.toString() ?? 'No Synopsis';
                final year = movies['year']?.toString() ?? 'Unknown Year';
                final broadcast = movies['broadcast']?['string']?.toString() ??
                    'Unknown Broadcast';
                final rating = movies['rating']?.toString() ?? 'No Rating';

                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        side: BorderSide(color: Colors.black12)),
                    leading: Image.network(
                      image,
                      errorBuilder: (context, error, stackTrace) =>
                          const Icon(Icons.error), // Handle image load errors
                    ),
                    title: Text(
                      title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RichText(
                          text: TextSpan(
                            children: [
                              const TextSpan(
                                text: "Rating: ",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 15),
                              ),
                              TextSpan(
                                text: rating,
                                style: const TextStyle(
                                    color: Colors.black, fontSize: 15),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 3),
                        RichText(
                          text: TextSpan(
                            children: [
                              const TextSpan(
                                text: "Release Date: ",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 15),
                              ),
                              TextSpan(
                                text: dateformat,
                                style: const TextStyle(
                                    color: Colors.black, fontSize: 15),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MoviesDetailsScreen(
                            image: image,
                            title: title,
                            duration: duration,
                            rating: rating,
                            score: score,
                            synopsis: synopsis,
                            year: year,
                            broadCast: broadcast,
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
