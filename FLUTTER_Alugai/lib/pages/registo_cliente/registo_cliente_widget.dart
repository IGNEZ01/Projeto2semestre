import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';

class RegistoClienteWidget extends StatefulWidget {
  const RegistoClienteWidget({Key? key}) : super(key: key);

  @override
  _RegistoClienteWidgetState createState() => _RegistoClienteWidgetState();
}

class _RegistoClienteWidgetState extends State<RegistoClienteWidget> {
  late TextEditingController _nomeController;
  late TextEditingController _nifController;
  late TextEditingController _cartaController;
  late TextEditingController _emailController;
  late TextEditingController _telefoneController;
  late TextEditingController _moradaController;
  late TextEditingController _codPostalController;
  late TextEditingController _passwordController;
  String _nomeLocalidade = '';

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _nomeController = TextEditingController();
    _nifController = TextEditingController();
    _cartaController = TextEditingController();
    _emailController = TextEditingController();
    _telefoneController = TextEditingController();
    _moradaController = TextEditingController();
    _codPostalController = TextEditingController();
    _passwordController = TextEditingController();

    // Adiciona um listener para buscar a localidade ao mudar o código postal
    _codPostalController.addListener(() {
      buscarLocalidade();
    });
  }

  @override
  void dispose() {
    _nomeController.dispose();
    _nifController.dispose();
    _cartaController.dispose();
    _emailController.dispose();
    _telefoneController.dispose();
    _moradaController.dispose();
    _codPostalController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> salvarCliente() async {
    const ip = '127.0.0.1'; // IP local da sua máquina host
    const url = 'https://$ip:7225/Clientes'; // URL da API

    // Criação dos dados a serem enviados
    var clienteData = {
      'nome_cliente': _nomeController.text,
      'nif_cliente': _nifController.text,
      'carta_cliente': _cartaController.text,
      'email_cliente': _emailController.text,
      'telefone_cliente': _telefoneController.text,
      'morada_cliente': _moradaController.text,
      'codPostal_cliente': _codPostalController.text,
      'senha_cliente': _passwordController.text,
    };

    try {
      HttpClient client = HttpClient()
        ..badCertificateCallback =
            ((X509Certificate cert, String host, int port) => true);

      HttpClientRequest request = await client.postUrl(Uri.parse(url));
      request.headers.set('Content-Type', 'application/json');
      request.add(utf8.encode(jsonEncode(clienteData)));

      HttpClientResponse response = await request.close();
      String reply = await response.transform(utf8.decoder).join();

      if (response.statusCode == 200) {
        print('Dados da resposta: $reply');
        // Limpar os campos após o sucesso
        _nomeController.clear();
        _nifController.clear();
        _cartaController.clear();
        _emailController.clear();
        _telefoneController.clear();
        _moradaController.clear();
        _codPostalController.clear();
        _passwordController.clear();
          setState(() {
          _nomeLocalidade = '';
        });

        // Mostrar uma mensagem de sucesso
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Cliente registrado com sucesso!'),
            duration: Duration(seconds: 3),
          ),
        );
      } else {
        print('Erro na requisição: ${response.statusCode}');
        print('Corpo da resposta: $reply');
        // Mostrar uma mensagem de erro
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erro ao salvar cliente. Código: ${response.statusCode}'),
            duration: Duration(seconds: 3),
          ),
        );
      }
    } catch (e) {
      print('Erro ao fazer a requisição: $e');
      // Mostrar uma mensagem de erro
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erro ao salvar cliente. Detalhes: $e'),
          duration: Duration(seconds: 3),
        ),
      );
    }
  }

  Future<void> buscarLocalidade() async {
    const ip = '127.0.0.1'; // IP local da sua máquina host
    const url = 'https://$ip:7225/Localidade'; // URL da API

    try {
      HttpClient client = HttpClient()
        ..badCertificateCallback =
            ((X509Certificate cert, String host, int port) => true);

      HttpClientRequest request = await client.getUrl(Uri.parse('$url/${_codPostalController.text}'));

      HttpClientResponse response = await request.close();
      String reply = await response.transform(utf8.decoder).join();

      if (response.statusCode == 200) {
        setState(() {
          _nomeLocalidade = reply; // Usando o corpo da resposta
        });
      }else{
          _nomeLocalidade = 'Codigo postal inexistente.';
      }
    } catch (e) {
      _nomeLocalidade = 'Codigo postal inexistente.';
      
    }
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
          title: Text('Registo Cliente'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Crie sua conta',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _nomeController,
                decoration: InputDecoration(
                  labelText: 'Nome completo',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 12),
              TextFormField(
                controller: _nifController,
                decoration: InputDecoration(
                  labelText: 'NIF',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 12),
              TextFormField(
                controller: _cartaController,
                decoration: InputDecoration(
                  labelText: 'Número da carta de condução',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 12),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'E-mail',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 12),
              TextFormField(
                controller: _telefoneController,
                decoration: InputDecoration(
                  labelText: 'Telefone',
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
              SizedBox(height: 12),
              TextFormField(
                controller: _codPostalController,
                decoration: InputDecoration(
                  labelText: 'Código Postal',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 12),
              if (_nomeLocalidade.isNotEmpty)
                Text(
                  'Localidade: $_nomeLocalidade',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              SizedBox(height: 12),
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText: 'Senha',
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: salvarCliente,
                child: Text('Salvar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
