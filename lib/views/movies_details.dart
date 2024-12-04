import 'package:flutter/material.dart';

class MoviesDetailsScreen extends StatefulWidget {
  final dynamic image;
  final dynamic title;
  final dynamic duration;
  final dynamic rating;
  final dynamic score;
  final dynamic synopsis;
  final dynamic year;
  final dynamic broadCast;
  const MoviesDetailsScreen({
    super.key,
    required this.image,
    required this.title,
    required this.duration,
    required this.rating,
    required this.score,
    required this.synopsis,
    required this.year,
    required this.broadCast,
  });

  @override
  State<MoviesDetailsScreen> createState() => _MoviesDetailsScreenState();
}

class _MoviesDetailsScreenState extends State<MoviesDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Movies"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: double.infinity,
                height: 400,
                child: Image.network(
                  widget.image,
                  fit: BoxFit.fill,
                ),
              ),
              const SizedBox(height: 15),
              RichText(
                text: TextSpan(
                  children: [
                    const TextSpan(
                      text: "Title: ",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w500),
                    ),
                    TextSpan(
                      text: widget.title,
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              RichText(
                text: TextSpan(
                  children: [
                    const TextSpan(
                      text: "Rating: ",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.w500),
                    ),
                    TextSpan(
                      text: widget.rating,
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.normal),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              RichText(
                text: TextSpan(
                  children: [
                    const TextSpan(
                      text: "Duration: ",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.w500),
                    ),
                    TextSpan(
                      text: widget.duration,
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.normal),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              RichText(
                text: TextSpan(
                  children: [
                    const TextSpan(
                      text: "Score: ",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.w500),
                    ),
                    TextSpan(
                      text: widget.score.toString(),
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.normal),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              RichText(
                text: TextSpan(
                  children: [
                    const TextSpan(
                      text: "Year: ",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.w500),
                    ),
                    TextSpan(
                      text: widget.year,
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.normal),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              RichText(
                text: TextSpan(
                  children: [
                    const TextSpan(
                      text: "Broadcast: ",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.w500),
                    ),
                    TextSpan(
                      text: widget.broadCast,
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.normal),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              RichText(
                text: TextSpan(
                  children: [
                    const TextSpan(
                      text: "Synopsis: ",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.w500),
                    ),
                    TextSpan(
                      text: widget.synopsis,
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.normal),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
