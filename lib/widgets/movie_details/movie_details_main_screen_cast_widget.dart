import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:themoviedb/domain/api_client/image_downloader.dart';
import 'package:themoviedb/widgets/movie_details/movie_details_model.dart';

class MovieDetailsMainScreenCastWidget extends StatelessWidget {
  const MovieDetailsMainScreenCastWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text('В главных ролях',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w800,
                )),
          ),
          const SizedBox(
            height: 280,
            child: Scrollbar(
              child: _ActorListWidget(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(3.0),
            child: TextButton(
                onPressed: () {},
                child: Text('Полный актёрский и съёмочный состав')),
          ),
        ],
      ),
    );
  }
}

class _ActorListWidget extends StatelessWidget {
  const _ActorListWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final data = context.select((MovieDetailsModel model) => model.data.actorsData);
    if (data.isEmpty) return const SizedBox.shrink();
    return ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: data.length,
        itemExtent: 120,
        itemBuilder: (BuildContext context, int index) {
          return _ActorListItemWidget(actorIndex: index);
        });
  }
}

class _ActorListItemWidget extends StatelessWidget {
  final int actorIndex;
  const _ActorListItemWidget({
    Key? key,
    required this.actorIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.read<MovieDetailsModel>();
    
    final actor = model.data.actorsData[actorIndex];
    final profilePath = actor.profilePath;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.black.withOpacity(0.2)),
          borderRadius: BorderRadius.all(Radius.circular(10)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          clipBehavior: Clip.hardEdge,
          child: Column(
            children: [
              if (profilePath != null)
              Image.network(
                ImageDownloader.imageUrl(profilePath),
                width: 150,
                height: 150,
                ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                    Text(actor.name, style: TextStyle(fontWeight: FontWeight.w800)),
                    SizedBox(height: 5),
                    Text(actor.character, maxLines: 2),
                  ],
                  ),
                ),
              ),


            ],

          ),
        ),
      ),
    );
  }
}
