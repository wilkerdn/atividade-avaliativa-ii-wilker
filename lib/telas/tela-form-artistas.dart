import 'package:flutter/material.dart';
import '../models/artista.dart';
import '../providers/artistas-providers.dart';
import 'package:provider/provider.dart';

class TelaFormArtista extends StatefulWidget {
  @override
  TelaFormArtistaState createState() => TelaFormArtistaState();
}

class TelaFormArtistaState extends State<TelaFormArtista> {
  final form = GlobalKey<FormState>();
  final dadosForm = Map<String, Object>();

  void saveForm(context, Artista artista) {
    var formValido = form.currentState.validate();

    form.currentState.save();

    final novoArtista = Artista(
        id: artista != null ? artista.id : artista,
        nome: dadosForm['nome'],
        imagem: dadosForm['imagem'],
        email: dadosForm['email'],
        senha: dadosForm['senha']);

    if (formValido) {
      if (artista != null) {
        Provider.of<ArtistaProvider>(context, listen: false)
            .patchArtista(novoArtista);
        Navigator.of(context).pop();
      } else {
        Provider.of<ArtistaProvider>(context, listen: false)
            .postArtista(novoArtista);
        Navigator.of(context).pop();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final artista = ModalRoute.of(context).settings.arguments as Artista;
    print(artista);
    return Scaffold(
      appBar: AppBar(
        title: Text("Formulário Artista"),
        actions: [
          IconButton(
              icon: Icon(Icons.save),
              onPressed: () {
                saveForm(context, artista);
              })
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(15),
        child: Form(
          key: form,
          child: ListView(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Nome'),
                textInputAction: TextInputAction.next,
                initialValue: artista != null ? artista.nome : '',
                onSaved: (value) {
                  dadosForm['nome'] = value;
                },
                validator: (value) {
                  if (value.trim().isEmpty) {
                    return "Informe um nome válido";
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Imagem'),
                textInputAction: TextInputAction.done,
                onSaved: (value) {
                  dadosForm['imagem'] = value;
                },
                initialValue: artista != null ? artista.imagem : '',
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Email'),
                textInputAction: TextInputAction.done,
                onSaved: (value) {
                  dadosForm['email'] = value;
                },
                initialValue: artista != null ? artista.email : '',
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Senha'),
                textInputAction: TextInputAction.done,
                onSaved: (value) {
                  dadosForm['senha'] = value;
                },
                initialValue: artista != null ? artista.senha : '',
                onFieldSubmitted: (_) {
                  saveForm(context, artista);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
