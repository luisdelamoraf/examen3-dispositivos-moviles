import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_login/models/new.dart';
import 'package:http/http.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share/share.dart';

class ItemNoticia extends StatefulWidget {
  final New noticia;
  ItemNoticia({Key key, @required this.noticia}) : super(key: key);

  @override
  _ItemNoticiaState createState() => _ItemNoticiaState();
}

class _ItemNoticiaState extends State<ItemNoticia> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: EdgeInsets.all(6.0),
        child: Card(
          clipBehavior: Clip.antiAlias,
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Builder(builder: (context) {
                        final condition = widget.noticia.urlToImage != null;
                        return condition
                            ? Image.network(
                                "${widget.noticia.urlToImage}",
                                height: 100,
                                fit: BoxFit.cover,
                              )
                            : Image.asset(
                                "assets/placeholder.png",
                                height: 200,
                                fit: BoxFit.cover,
                              );
                      }),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Padding(
                      padding: EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              IconButton(
                                  onPressed: () {},
                                  icon: Icon(Icons.upload_file)),
                              IconButton(
                                  onPressed: () {
                                    _shareNews(widget.noticia);
                                  },
                                  icon: Icon(Icons.share))
                            ],
                          ),
                          Text(
                            "${widget.noticia.title}",
                            maxLines: 1,
                            overflow: TextOverflow.clip,
                            style: TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 14,
                            ),
                          ),
                          Text(
                            "${widget.noticia.publishedAt}",
                            style: TextStyle(
                              fontWeight: FontWeight.w300,
                              color: Colors.grey,
                              fontSize: 12,
                            ),
                          ),
                          SizedBox(height: 16),
                          Text(
                            "${widget.noticia.description ?? "Descripcion no disponible"}",
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: 16),
                          Text(
                            "${widget.noticia.author ?? "Autor no disponible"}",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontWeight: FontWeight.w300,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  //https://github.com/himanshusharma89/sharefiles
  Future<Null> _shareNews(New noticia) async {
    var response = await get(Uri.parse(noticia.urlToImage));
    final documentDirectory = (await getExternalStorageDirectory()).path;

    File imgFile = new File('$documentDirectory/noticiaImagen.png');
    imgFile.writeAsBytesSync(response.bodyBytes);

    final RenderBox box = context.findRenderObject();
    Share.shareFiles([('$documentDirectory/noticiaImagen.png')],
        subject: 'Mira esta noticia',
        text: '${noticia.title}: ${noticia.description}\n\n ${noticia.url}',
        sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
  }
}
