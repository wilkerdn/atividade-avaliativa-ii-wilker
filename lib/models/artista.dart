import 'package:flutter/material.dart';

class Artista {
  final String id;
  final String nome;
  final String email;
  final String senha;
  final String imagem;

  const Artista({
    @required this.id,
    @required this.nome,
    @required this.email,
    @required this.senha,
    @required this.imagem,
  });
}
