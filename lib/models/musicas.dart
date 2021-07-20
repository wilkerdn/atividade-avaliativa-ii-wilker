import 'package:flutter/material.dart';

class Musica {
  final String id;
  final String nome;
  final String duracao;
  final String estilo;
  final String id_artista;

  const Musica({
    this.id,
    @required this.nome,
    @required this.duracao,
    @required this.estilo,
    @required this.id_artista,
  });
}
