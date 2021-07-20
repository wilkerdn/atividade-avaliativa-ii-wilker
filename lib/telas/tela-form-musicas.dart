import 'package:flutter/material.dart';
import '../models/artista.dart';
import '../models/musicas.dart';
import '../providers/musicas-providers.dart';
import 'package:provider/provider.dart';

class TelaFormMusicas extends StatefulWidget {
  @override
  TelaFormMusicasState createState() => TelaFormMusicasState();
}

class TelaFormMusicasState extends State<TelaFormMusicas> {
  final form = GlobalKey<FormState>();
  final dadosForm = Map<String, Object>();

  void saveForm(context, Artista artista) {
    var formValido = form.currentState.validate();

    form.currentState.save();

    final novoMusica = Musica(
      id: artista != null ? artista.id : artista,
      nome: dadosForm['nome'],
      duracao: dadosForm['duracao'],
      estilo: dadosForm['estilo'],
      id_artista: artista.id,
    );

    if (formValido) {
      Provider.of<MusicaProvider>(context, listen: false)
          .postMusica(novoMusica);
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final artista = ModalRoute.of(context).settings.arguments as Artista;
    print(artista);
    return Scaffold(
      appBar: AppBar(
        title: Text("Formulário Musica"),
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
                decoration: InputDecoration(labelText: 'Duração'),
                textInputAction: TextInputAction.next,
                onSaved: (value) {
                  dadosForm['duracao'] = value;
                },
                validator: (value) {
                  if (value.trim().isEmpty) {
                    return "Informe uma duração válida";
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Estilo'),
                textInputAction: TextInputAction.next,
                onSaved: (value) {
                  dadosForm['estilo'] = value;
                },
                onFieldSubmitted: (_) {
                  saveForm(context, artista);
                },
                validator: (value) {
                  if (value.trim().isEmpty) {
                    return "Informe um estilo válido";
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
