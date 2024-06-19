import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';

class RegistoCarroWidget extends StatefulWidget {
  const RegistoCarroWidget({Key? key}) : super(key: key);

  @override
  _RegistoCarroWidgetState createState() => _RegistoCarroWidgetState();
}

class _RegistoCarroWidgetState extends State<RegistoCarroWidget> {
  late TextEditingController _matriculaController;
  late TextEditingController _nomeController;
  late TextEditingController _anoController;
  late TextEditingController _descricaoController;
  late TextEditingController _codPostalController;
  late TextEditingController _moradaController;
  late TextEditingController _portasController;
  late TextEditingController _lugaresController;
  late TextEditingController _valorDiaController;

  int _selectedCorId = -1;
  int _selectedModeloId = -1;
  int _selectedTipoCarroId = -1;
  int _selectedCombustivelId = -1;
  bool _arCondicionado = false;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  List<Map<String, dynamic>> _cores = [];
  List<Map<String, dynamic>> _modelos = [];
  List<Map<String, dynamic>> _tiposCarro = [];
  List<Map<String, dynamic>> _combustiveis = [];

  @override
  void initState() {
    super.initState();
    _matriculaController = TextEditingController();
    _nomeController = TextEditingController();
    _anoController = TextEditingController();
    _descricaoController = TextEditingController();
    _codPostalController = TextEditingController();
    _moradaController = TextEditingController();
    _portasController = TextEditingController();
    _lugaresController = TextEditingController();
    _valorDiaController = TextEditingController();

    // Carregar opções para os dropdowns
    carregarOpcoes();
  }

  @override
  void dispose() {
    _matriculaController.dispose();
    _nomeController.dispose();
    _anoController.dispose();
    _descricaoController.dispose();
    _codPostalController.dispose();
    _moradaController.dispose();
    _portasController.dispose();
    _lugaresController.dispose();
    _valorDiaController.dispose();
    super.dispose();
  }

  Future<void> carregarOpcoes() async {
    await carregarCores();
    await carregarModelos();
    await carregarTiposCarro();
    await carregarCombustiveis();
  }

  Future<void> carregarCores() async {
    const ip = '127.0.0.1'; // IP da sua API
    const url = 'https://$ip:7225/Cores';

    try {
      HttpClient client = HttpClient();
      HttpClientRequest request = await client.getUrl(Uri.parse(url));
      HttpClientResponse response = await request.close();
      String reply = await response.transform(utf8.decoder).join();

      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(reply);
        setState(() {
          _cores = data.map((e) => {'id': e['id_cor'], 'nome': e['nome_cor']}).toList();
        });
      } else {
        print('Erro ao buscar cores. Código: ${response.statusCode}');
      }
    } catch (e) {
      print('Erro ao fazer a requisição: $e');
    }
  }

  Future<void> carregarModelos() async {
    const ip = '127.0.0.1'; // IP da sua API
    const url = 'https://$ip:7225/Modelos';

    try {
      HttpClient client = HttpClient();
      HttpClientRequest request = await client.getUrl(Uri.parse(url));
      HttpClientResponse response = await request.close();
      String reply = await response.transform(utf8.decoder).join();

      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(reply);
        setState(() {
          _modelos = data.map((e) => {'id': e['id_modelo'], 'nome': e['nome_modelo']}).toList();
        });
      } else {
        print('Erro ao buscar modelos. Código: ${response.statusCode}');
      }
    } catch (e) {
      print('Erro ao fazer a requisição: $e');
    }
  }

  Future<void> carregarTiposCarro() async {
    const ip = '127.0.0.1'; // IP da sua API
    const url = 'https://$ip:7225/TipoCarro';

    try {
      HttpClient client = HttpClient();
      HttpClientRequest request = await client.getUrl(Uri.parse(url));
      HttpClientResponse response = await request.close();
      String reply = await response.transform(utf8.decoder).join();

      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(reply);
        setState(() {
          _tiposCarro = data.map((e) => {'id': e['id_tipoCarro'], 'nome': e['nome_tipoCarro']}).toList();
        });
      } else {
        print('Erro ao buscar tipos de carro. Código: ${response.statusCode}');
      }
    } catch (e) {
      print('Erro ao fazer a requisição: $e');
    }
  }

  Future<void> carregarCombustiveis() async {
    const ip = '127.0.0.1'; // IP da sua API
    const url = 'https://$ip:7225/Combustiveis';

    try {
      HttpClient client = HttpClient();
      HttpClientRequest request = await client.getUrl(Uri.parse(url));
      HttpClientResponse response = await request.close();
      String reply = await response.transform(utf8.decoder).join();

      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(reply);
        setState(() {
          _combustiveis = data.map((e) => {'id': e['id_combustivel'], 'nome': e['nome_combustivel']}).toList();
        });
      } else {
        print('Erro ao buscar combustíveis. Código: ${response.statusCode}');
      }
    } catch (e) {
      print('Erro ao fazer a requisição: $e');
    }
  }

  Future<void> salvarCarro() async {
    const ip = '127.0.0.1'; // IP local da sua máquina host
    const url = 'https://$ip:7225/Carros';

    var carroData = {
      'matricula_carro': _matriculaController.text,
      'nome_carro': _nomeController.text,
      'ano_carro': int.parse(_anoController.text),
      'cor_carro': _selectedCorId,
      'modelo_carro': _selectedModeloId,
      'tipo_carro': _selectedTipoCarroId,
      'combustivel_carro': _selectedCombustivelId,
      'portas_carro': int.parse(_portasController.text),
      'lugares_carro': int.parse(_lugaresController.text),
      'valorDia_carro': double.parse(_valorDiaController.text),
      'arCondicionado_carro': _arCondicionado ? 1 : 0,
      'descricao_carro': _descricaoController.text,
      'estado_carro': 1,
      'codPostal_carro': int.parse(_codPostalController.text),
      'morada_carro': _moradaController.text,
    };

    try {
      HttpClient client = HttpClient();
      client.badCertificateCallback = ((X509Certificate cert, String host, int port) => true);

      HttpClientRequest request = await client.postUrl(Uri.parse(url));
      request.headers.set('Content-Type', 'application/json');
      request.add(utf8.encode(jsonEncode(carroData)));

      HttpClientResponse response = await request.close();
      String reply = await response.transform(utf8.decoder).join();

      if (response.statusCode == 200) {
        print('Dados da resposta: $reply');
        _limparCampos();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Carro registrado com sucesso!'),
            duration: Duration(seconds: 3),
          ),
        );
      } else {
        print('Erro na requisição: ${response.statusCode}');
        print('Corpo da resposta: $reply');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erro ao salvar carro. Código: ${response.statusCode}'),
            duration: Duration(seconds: 3),
          ),
        );
      }
    } catch (e) {
      print('Erro ao fazer a requisição: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erro ao salvar carro. Detalhes: $e'),
          duration: Duration(seconds: 3),
        ),
      );
    }
  }

  void _limparCampos() {
    _matriculaController.clear();
    _nomeController.clear();
    _anoController.clear();
    _descricaoController.clear();
    _codPostalController.clear();
    _moradaController.clear();
    _portasController.clear();
    _lugaresController.clear();
    _valorDiaController.clear();
    setState(() {
      _selectedCorId = -1;
      _selectedModeloId = -1;
      _selectedTipoCarroId = -1;
      _selectedCombustivelId = -1;
      _arCondicionado = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
          title: Text('Registo de Carro'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Registe um novo carro',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: _matriculaController,
                  decoration: InputDecoration(
                    labelText: 'Matrícula',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 12),
                TextFormField(
                  controller: _nomeController,
                  decoration: InputDecoration(
                    labelText: 'Nome',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 12),
                TextFormField(
                  controller: _anoController,
                  decoration: InputDecoration(
                    labelText: 'Ano',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                ),
                SizedBox(height: 12),
                DropdownButtonFormField<int>(
                  value: _selectedCorId,
                  onChanged: (int? newValue) {
                    setState(() {
                      _selectedCorId = newValue!;
                    });
                  },
                  items: _cores.map<DropdownMenuItem<int>>((cor) {
                    return DropdownMenuItem<int>(
                      value: cor['id'],
                      child: Text(cor['nome']),
                    );
                  }).toList(),
                  decoration: InputDecoration(
                    labelText: 'Cor',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 12),
                DropdownButtonFormField<int>(
                  value: _selectedModeloId,
                  onChanged: (int? newValue) {
                    setState(() {
                      _selectedModeloId = newValue!;
                    });
                  },
                  items: _modelos.map<DropdownMenuItem<int>>((modelo) {
                    return DropdownMenuItem<int>(
                      value: modelo['id'],
                      child: Text(modelo['nome']),
                    );
                  }).toList(),
                  decoration: InputDecoration(
                    labelText: 'Modelo',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 12),
                DropdownButtonFormField<int>(
                  value: _selectedTipoCarroId,
                  onChanged: (int? newValue) {
                    setState(() {
                      _selectedTipoCarroId = newValue!;
                    });
                  },
                  items: _tiposCarro.map<DropdownMenuItem<int>>((tipo) {
                    return DropdownMenuItem<int>(
                      value: tipo['id'],
                      child: Text(tipo['nome']),
                    );
                  }).toList(),
                  decoration: InputDecoration(
                    labelText: 'Tipo de Carro',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 12),
                DropdownButtonFormField<int>(
                  value: _selectedCombustivelId,
                  onChanged: (int? newValue) {
                    setState(() {
                      _selectedCombustivelId = newValue!;
                    });
                  },
                  items: _combustiveis.map<DropdownMenuItem<int>>((combustivel) {
                    return DropdownMenuItem<int>(
                      value: combustivel['id'],
                      child: Text(combustivel['nome']),
                    );
                  }).toList(),
                  decoration: InputDecoration(
                    labelText: 'Combustível',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 12),
                TextFormField(
                  controller: _portasController,
                  decoration: InputDecoration(
                    labelText: 'Número de Portas',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                ),
                SizedBox(height: 12),
                TextFormField(
                  controller: _lugaresController,
                  decoration: InputDecoration(
                    labelText: 'Número de Lugares',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                ),
                SizedBox(height: 12),
                TextFormField(
                  controller: _valorDiaController,
                  decoration: InputDecoration(
                    labelText: 'Valor por Dia',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                ),
                SizedBox(height: 12),
                Row(
                  children: [
                    Text('Ar Condicionado'),
                    Checkbox(
                      value: _arCondicionado,
                      onChanged: (bool? value) {
                        setState(() {
                          _arCondicionado = value ?? false;
                        });
                      },
                    ),
                  ],
                ),
                SizedBox(height: 12),
                TextFormField(
                  controller: _descricaoController,
                  decoration: InputDecoration(
                    labelText: 'Descrição',
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 3,
                ),
                SizedBox(height: 12),
                TextFormField(
                  controller: _codPostalController,
                  decoration: InputDecoration(
                    labelText: 'Código Postal',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 12),
                TextFormField(
                  controller: _moradaController,
                  decoration: InputDecoration(
                    labelText: 'Morada',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: salvarCarro,
                  child: Text('Salvar Carro'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
