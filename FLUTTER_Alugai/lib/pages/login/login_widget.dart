import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CustomHttpClient extends http.BaseClient {
  final http.Client _httpClient = http.Client();

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) async {
    try {
      var response = await _httpClient.send(request);
      return response;
    } catch (e) {
      if (e is HandshakeException) {
        // Ignorar a verificação de certificados
        HttpClient client = HttpClient()
          ..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
        var request2 = await client.getUrl(request.url);
        var response2 = await request2.close();
        String reply = await response2.transform(utf8.decoder).join();

        // Converter a resposta em um StreamedResponse simulado para compatibilidade
        return http.StreamedResponse(Stream.value(utf8.encode(reply)), response2.statusCode);
      } else {
        rethrow; // Rethrow outras exceções para tratamento genérico
      }
    }
  }
}

class LoginModel {
  late TextEditingController nifTextController;
  late TextEditingController passwordTextController;

  void dispose() {
    nifTextController.dispose();
    passwordTextController.dispose();
  }
}

class LoginWidget extends StatefulWidget {
  const LoginWidget({Key? key}) : super(key: key);

  @override
  State<LoginWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  late LoginModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = LoginModel();
    _model.nifTextController = TextEditingController();
    _model.passwordTextController = TextEditingController();
  }

  Future<void> _login() async {
  final nif = _model.nifTextController.text.trim();
  final password = _model.passwordTextController.text;

  if (nif.isEmpty || password.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('NIF e senha são obrigatórios')),
    );
    return;
  }

  try {
    final client = CustomHttpClient(); // Usando nosso cliente HTTP personalizado

    final response = await client.post(
      Uri.parse('https://localhost:7225/api/Auth/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'nif_cliente': int.parse(nif),
        'senha_cliente': password,
      }),
    );

    // Mostrar a resposta no console
    print('Resposta do servidor:');
    print(response.body);

    // Processar a resposta do servidor
    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Login realizado com sucesso')),
      );
      // Redirecionar para a próxima tela após o login bem-sucedido
      // Implemente a navegação para a próxima tela aqui
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('NIF ou senha inválidos')),
      );
    }
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Erro durante o login: $e')),
    );
    print('Erro durante o login: $e'); // Mostra o erro no console
  }
}


  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: Text(
          'Login',
          style: TextStyle(
            color: Colors.black,
            fontSize: 16.0,
          ),
        ),
        centerTitle: true,
        elevation: 2.0,
      ),
      body: SafeArea(
        top: true,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: _model.nifTextController,
                decoration: InputDecoration(
                  labelText: 'NIF',
                ),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: _model.passwordTextController,
                decoration: InputDecoration(
                  labelText: 'Senha',
                ),
                obscureText: true,
              ),
              SizedBox(height: 32.0),
              ElevatedButton(
                onPressed: _login,
                child: Text('Entrar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
