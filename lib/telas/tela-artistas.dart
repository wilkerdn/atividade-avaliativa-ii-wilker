import 'package:flutter/material.dart';
import '../componentes/drawer-personalizado.dart';
import '../componentes/item-artista.dart';
import '../providers/artistas-providers.dart';
import '../utils/rotas.dart';
import 'package:provider/provider.dart';

class TelaArtistas extends StatefulWidget {
  @override
  _TelaArtistasState createState() => _TelaArtistasState();
}

class _TelaArtistasState extends State<TelaArtistas> {
  bool _isLoading = false;
  Future<void> _atualizarLista(BuildContext context) {
    return Provider.of<ArtistaProvider>(context, listen: false).buscaArtista();
  }

  @override
  void initState() {
    super.initState();
    Provider.of<ArtistaProvider>(context, listen: false)
        .buscaArtista()
        .then((_) {
      setState(() {
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final artista = Provider.of<ArtistaProvider>(context).getArtista;
    return Scaffold(
      appBar: AppBar(
        title: Text("Cadastro de Artista"),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(Rotas.FORM_ARTISTA);
            },
          )
        ],
      ),
      drawer: DrawerPersonalisado(),
      body: RefreshIndicator(
        onRefresh: () => _atualizarLista(context),
        child: Padding(
          padding: EdgeInsets.all(15),
          child: ListView.builder(
            itemCount: artista.length,
            itemBuilder: (ctx, i) => Column(
              children: [
                ItemListaArtista(artista[i]),
                Divider(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
