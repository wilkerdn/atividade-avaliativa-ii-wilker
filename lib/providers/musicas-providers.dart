import 'dart:convert';
import 'package:flutter/material.dart';
import '../models/artista.dart';
import 'package:http/http.dart' as http;
import '../models/musicas.dart';
import '../utils/variaveis.dart';

class MusicaProvider with ChangeNotifier {
  List<Musica> _musica = [];

  List<Musica> get getArtista => [..._musica];

  void adicionarMusica(Musica musica) {
    _musica.add(musica);
    notifyListeners();
  }

  Future<void> postMusica(Musica musica) async {
    var url = Uri.https(
        Variaveis.BACKURL, '/artistas/${musica.id_artista}/musicas.json');
    http
        .post(url,
            body: jsonEncode(
              {
                'nome': musica.nome,
                "duracao": musica.duracao,
                "estilo": musica.estilo,
                "id_artista": musica.id_artista,
              },
            ))
        .then((value) {
      adicionarMusica(musica);
    });
  }

  //PARA FAZER REQUISIÇÕSE SINCRONAS DEVEMOS RETORNAR O FUTURE
  Future<void> buscaMusica(Artista artista) async {
    var url =
        Uri.https(Variaveis.BACKURL, '/artistas/${artista.id}/musicas.json');
    var resposta = await http.get(url);
    Map<String, dynamic> data = json.decode(resposta.body);
    _musica.clear();
    if (data.isNotEmpty) {
      data.forEach((idMusica, dadosMusica) {
        adicionarMusica(
          Musica(
            id: idMusica,
            nome: dadosMusica['nome'],
            duracao: dadosMusica['duracao'],
            estilo: dadosMusica['estilo'],
            id_artista: dadosMusica['id_artista'],
          ),
        );
      });
    }
    notifyListeners();
  }

  Future<void> deleteMusica(Musica musica) async {
    print('Teste: ${musica.id}');
    print('Test2: ${musica.id_artista}');
    var url = Uri.https(Variaveis.BACKURL,
        '/artistas/${musica.id_artista}/musicas/${musica.id}.json');

    http.delete((url)).then((value) {
      notifyListeners();
    });
  }

  Future<void> patchMusica(Musica musica) async {
    var url = Uri.https(Variaveis.BACKURL,
        '/artistas/${musica.id_artista}/musicas/${musica.id}.json');
    http
        .patch(url,
            body: jsonEncode(
              {
                "nome": musica.nome,
                "duracao": musica.duracao,
                "estilo": musica.estilo,
              },
            ))
        .then((value) {
      notifyListeners();
    });
  }
}
