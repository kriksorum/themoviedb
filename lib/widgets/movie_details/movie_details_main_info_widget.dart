import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:themoviedb/domain/api_client/image_downloader.dart';
import 'package:themoviedb/ui/navigation/main_navigation.dart';
import 'package:themoviedb/widgets/elements/radial_percent_widget.dart';
import 'package:themoviedb/widgets/movie_details/movie_details_model.dart';

class MovieDetailsMainInfoWidget extends StatelessWidget {
  const MovieDetailsMainInfoWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _TopPostersWidget(),
        _MovieNameWidget(),
        _ScoreWidget(),
        _SummeryWidget(),
        _OverviewWidget(),
        _DescriptionWidget(),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: _PeopleWidget(),
        ),
      ],
    );
  }
}

class _ScoreWidget extends StatelessWidget {
  const _ScoreWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final scoreData =
        context.select((MovieDetailsModel model) => model.data.scoreData);
    
    final trailerKey = scoreData.trailerKey;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        TextButton(
            onPressed: () {},
            child: Row(
              children: [
                SizedBox(
                  width: 30,
                  height: 30,
                  child: RadialPercentWidget(
                    child: Text(scoreData.voteAverage.toStringAsFixed(0)),
                    percent: scoreData.voteAverage / 100,
                    fillColor: Color.fromARGB(255, 10, 23, 25),
                    lineColor: Color.fromARGB(255, 37, 203, 103),
                    freeColor: Color.fromARGB(255, 25, 54, 31),
                    lineWidth: 3,
                  ),
                ),
                SizedBox(width: 10),
                Text('Пользовательский счет',
                    style: TextStyle(color: Colors.white)),
              ],
            )),
        Container(
          color: Colors.grey,
          width: 1,
          height: 15,
        ),
        if (trailerKey != null)
             TextButton(
                onPressed: () => Navigator.of(context).pushNamed(
                  MainNavigationRouteNames.movieTrailerWidget,
                  arguments: trailerKey,
                ),
                child: Row(
                  children: [
                    Icon(Icons.play_arrow),
                    SizedBox(width: 10),
                    Text('Воспроизвести',
                        style: TextStyle(color: Colors.white)),
                  ],
                ),
              )
      ],
    );
  }
}

class _DescriptionWidget extends StatelessWidget {
  const _DescriptionWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final overview =
        context.select((MovieDetailsModel model) => model.data.overview);

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Text(
        overview,
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w200,
          fontSize: 14,
        ),
      ),
    );
  }
}

class _PeopleWidget extends StatelessWidget {
  const _PeopleWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var crew = context
        .select((MovieDetailsModel model) => model.data.peopleData);
    if (crew.isEmpty) return const SizedBox.shrink();
    
    return Column(
      children: crew
          .map((chunk) => Padding(
                padding: const EdgeInsets.only(bottom: 20, top: 20),
                child: _PeopleWidgetRow(employes: chunk),
              ))
          .toList(),
    );
  }
}

class _PeopleWidgetRow extends StatelessWidget {
  final List<MovieDetailsPeopleData> employes;
  const _PeopleWidgetRow({Key? key, required this.employes}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisSize: MainAxisSize.max,
        //mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: employes
            .map((employee) => _PeopleWidgetRowItem(employee: employee))
            .toList());
  }
}

class _PeopleWidgetRowItem extends StatelessWidget {
  final MovieDetailsPeopleData employee;
  const _PeopleWidgetRowItem({Key? key, required this.employee})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    const nameStyle = TextStyle(
        color: Colors.white, fontSize: 14, fontWeight: FontWeight.w200);
    const jobTitleStyle = TextStyle(
        color: Colors.white, fontSize: 14, fontWeight: FontWeight.w200);
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(employee.name, style: nameStyle),
          Text(employee.job, style: jobTitleStyle),
        ],
      ),
    );
  }
}

class _OverviewWidget extends StatelessWidget {
  const _OverviewWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Text(
        'Обзор',
        textAlign: TextAlign.start,
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w600,
          fontSize: 17,
        ),
      ),
    );
  }
}

class _TopPostersWidget extends StatelessWidget {
  const _TopPostersWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.read<MovieDetailsModel>();
    final posterData =
        context.select((MovieDetailsModel model) => model.data.posterData);
    final backdropPath = posterData.backdropPath;
    final posterPath = posterData.posterPath;
    return AspectRatio(
      aspectRatio: 390 / 219,
      child: Stack(
        children: [
          if (backdropPath != null)
            Image.network(ImageDownloader.imageUrl(backdropPath)),
          if (posterPath != null)
            Positioned(
              top: 20,
              left: 20,
              bottom: 20,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.network(ImageDownloader.imageUrl(posterPath)),
              ),
            ),
          Positioned(
            top: 5,
            right: 5,
            child: IconButton(
              onPressed: () => model.toggleFavorite(context),
              icon: Icon(posterData.favoriteIcon),
            ),
          ),
        ],
      ),
    );
  }
}

class _MovieNameWidget extends StatelessWidget {
  const _MovieNameWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var nameData = context.select((MovieDetailsModel model) =>
        model.data.nameData);


    final title = nameData.name;
    final year = nameData.year;
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Center(
        child: RichText(
            textAlign: TextAlign.center,
            maxLines: 3,
            text: TextSpan(
              children: [
                TextSpan(
                  text: title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 17,
                  ),
                ),
                TextSpan(
                  text: ' ($year)',
                  style: const TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                  ),
                ),
              ],
            )),
      ),
    );
  }
}

class _SummeryWidget extends StatelessWidget {
  const _SummeryWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    final sumary =
        context.select((MovieDetailsModel model) => model.data.sumary);
    
    return ColoredBox(
      color: Color.fromRGBO(22, 21, 25, 1.0),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        child: Text(
          sumary,
          maxLines: 3,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w200,
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}
