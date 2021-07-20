import 'package:flutter/material.dart';
import '../models/artista.dart';
import '../providers/artistas-providers.dart';
import '../utils/rotas.dart';
import 'package:provider/provider.dart';

class ItemListaArtista extends StatelessWidget {
  final Artista artista;

  ItemListaArtista(this.artista);

  void deleteArtista(context, Artista artista) {
    Provider.of<ArtistaProvider>(context, listen: false).deleteArtista(artista);
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(artista.imagem),
      ),
      contentPadding: EdgeInsets.all(15),
      tileColor: Colors.orange[200],
      title: Container(
        child: Text(
          '${artista.nome}\n${artista.email}',
          style: TextStyle(color: Colors.black),
        ),
      ),
      trailing: Container(
        width: 100,
        child: Row(
          children: [
            Expanded(
              child: IconButton(
                icon: Icon(Icons.edit),
                onPressed: () {
                  Navigator.of(context).pushNamed(
                    Rotas.FORM_ARTISTA,
                    arguments: artista,
                  );
                },
                color: Colors.black,
              ),
            ),
            Expanded(
              child: IconButton(
                iconSize: 20,
                icon: Icon(Icons.delete),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (ctx) => AlertDialog(
                      title: Text("ATENÇÃO"),
                      content: Text("Está certo disso?"),
                      actions: [
                        TextButton(
                            child: Text("Não"),
                            onPressed: () {
                              Navigator.of(context).pop();
                            }),
                        TextButton(
                            child: Text("Sim"),
                            onPressed: () {
                              deleteArtista(context, artista);
                              Navigator.of(context).pop();
                            })
                      ],
                    ),
                  );
                },
                color: Colors.black,
              ),
            ),
            Expanded(
              child: IconButton(
                icon: Icon(Icons.music_note),
                onPressed: () {
                  Navigator.of(context).pushNamed(
                    Rotas.TELA_MUSICAS,
                    arguments: artista,
                  );
                },
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
