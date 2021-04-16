import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_login/home/noticias_ext_api/bloc/extapinews_bloc.dart';
import 'package:google_login/utils/news_repository.dart';

import 'item_noticia.dart';

class NoticiasDeportes extends StatefulWidget {
  const NoticiasDeportes({Key key}) : super(key: key);

  @override
  _NoticiasDeportesState createState() => _NoticiasDeportesState();
}

class _NoticiasDeportesState extends State<NoticiasDeportes> {
  var queryController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ExtapinewsBloc, ExtapinewsState>(
        builder: (context, state) {
      if (state is ExtapinewsLoadedState) {
        // Lista vacía
        if (state.externalApiNewsList.length == 0) {
          return Center(
            child: Text("Oops, algo salió mal"),
          );
        }
        // Lista no vacía
        else if (state.externalApiNewsList.length > 0) {
          return _extApiNews(state.externalApiNewsList);
        } else {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(),
              ],
            ),
          );
        }
      } else {
        return Center(
          child: CircularProgressIndicator(),
        );
      }
    }, listener: (context, state) {
      if (state is ExtapinewsLoadingState) {
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(
            SnackBar(
              content: Text('Cargando..'),
            ),
          );
      } else if (state is ExtapinewsErrorState) {
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(
            SnackBar(
              content: Text("${state.error}"),
            ),
          );
      }
    });
  }

  Widget _extApiNews(extNews) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: queryController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              IconButton(
                onPressed: () {
                  BlocProvider.of<ExtapinewsBloc>(context)
                      .add(RequestFilterNewsEvent(query: queryController.text));
                },
                icon: Icon(Icons.search),
              )
            ],
          ),
        ),
        Expanded(
          child: Container(
            height: MediaQuery.of(context).size.height,
            child: ListView.builder(
              itemCount: extNews.length,
              itemBuilder: (context, index) {
                return ItemNoticia(
                  noticia: extNews[index],
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
