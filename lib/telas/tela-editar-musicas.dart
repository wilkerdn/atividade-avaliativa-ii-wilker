import 'package:flutter/material.dart';
import '../models/musicas.dart';
import '../providers/musicas-providers.dart';
import 'package:provider/provider.dart';

class TelaEditMusicas extends StatefulWidget {
  @override
  TelaEditMusicasState createState() => TelaEditMusicasState();
}

class TelaEditMusicasState extends State<TelaEditMusicas> {
  final form = GlobalKey<FormState>();
  final dadosForm = Map<String, Object>();

  void saveForm(context, Musica musica) {
    var formValido = form.currentState.validate();

    form.currentState.save();

    final novoMusica = Musica(
      id: musica.id,
      nome: dadosForm['nome'],
      duracao: dadosForm['duracao'],
      estilo: dadosForm['estilo'],
      id_artista: musica.id_artista,
    );

    if (formValido) {
      Provider.of<MusicaProvider>(context, listen: false)
          .patchMusica(novoMusica);
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final musicas = ModalRoute.of(context).settings.arguments as Musica;
    print(musicas);
    return Scaffold(
      appBar: AppBar(
        title: Text("Formulário Musica"),
        actions: [
          IconButton(
              icon: Icon(Icons.save),
              onPressed: () {
                saveForm(context, musicas);
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
                initialValue: musicas.nome,
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
                initialValue: musicas.duracao,
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
                initialValue: musicas.estilo,
                textInputAction: TextInputAction.next,
                onSaved: (value) {
                  dadosForm['estilo'] = value;
                },
                onFieldSubmitted: (_) {
                  saveForm(context, musicas);
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
