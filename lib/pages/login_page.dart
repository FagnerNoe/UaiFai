// ignore_for_file: use_build_context_synchronously

import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:ssh2/ssh2.dart';

import 'package:network_info_plus/network_info_plus.dart';
import 'package:uaifai/pages/menu.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController ipRoteador = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  late SSHClient clientSSH;
  late String password = passwordController.text;

  Future<String> pegarGateway() async {
    final ipConexao = NetworkInfo().getWifiGatewayIP();
    return ipConexao.toString();
  }

  @override
  void initState() {
    super.initState();
    initializeGateway();
  }

  Future<void> initializeGateway() async {
    final ipConexao = await NetworkInfo().getWifiGatewayIP();
    if (ipConexao == null) {
      ipRoteador.text = "0.0.0.0";
    } else {
      ipRoteador.text = ipConexao;
    }
  }

  @override
  void dispose() {
    initializeGateway();
    super.dispose();
  }

  // funcao com dados pra conexao ssh ,,pegando o valor que foi digitado no textfield
  Future<bool> conectar() async {
    late bool conexaoBemSucedida;

    clientSSH = SSHClient(
        host: ipRoteador.text,
        port: 22,
        username: 'support',
        passwordOrKey: passwordController.text);

    if (passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Insira a Senha!!"),
        duration: Duration(seconds: 1),
      ));
    } else {
      try {
        await clientSSH.connect();
        print('Conexao Bem Sucedida');
        conexaoBemSucedida = true;
      } catch (e) {
        print('Falha na Conexao');
        conexaoBemSucedida = false;
      }
    }

    return conexaoBemSucedida;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'WiFi',
          style: TextStyle(
            fontSize: 30,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w700,
            letterSpacing: 0.8,
          ),
        ),
        centerTitle: true,
        forceMaterialTransparency: true,
        foregroundColor: const Color.fromARGB(255, 255, 255, 255),
        toolbarHeight: 50,
        flexibleSpace: ClipRRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
                  const Color.fromARGB(255, 233, 228, 233).withOpacity(0.9),
                  const Color.fromARGB(255, 180, 227, 243).withOpacity(0.9),
                ]),
              ),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: 600,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(33),
                    color: Colors.lightBlue,
                    image: const DecorationImage(
                      image: AssetImage('assets/images/casa.jpg'),
                      fit: BoxFit.cover,
                    ),
                    boxShadow: const [
                      BoxShadow(
                          color: Colors.black,
                          blurRadius: 23.0,
                          offset: Offset(0.8, 0.90),
                          blurStyle: BlurStyle.solid)
                    ]),
              ),
              const SizedBox(
                height: 30,
              ),
              SizedBox(
                  width: 200,
                  height: 40,
                  child: TextField(
                    controller: ipRoteador,
                    textAlign: TextAlign.center,
                    textAlignVertical: TextAlignVertical.top,
                    keyboardType: TextInputType.number,
                    showCursor: true,
                    decoration: InputDecoration(
                      labelText: 'Ip do Roteador',
                      enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.grey),
                          borderRadius: BorderRadius.circular(20)),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: Color.fromARGB(255, 39, 158, 194)),
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  )),
              const SizedBox(
                height: 8,
              ),
              TextField(
                style: const TextStyle(
                    color: Color.fromARGB(255, 18, 18, 18),
                    fontFamily: 'Poppins',
                    fontSize: 20),
                controller: passwordController, // pegando o valor digitado
                decoration: const InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Color.fromARGB(255, 139, 157, 160), width: 0.8),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Color.fromARGB(255, 49, 174, 237), width: 2.0),
                  ),
                  labelText: 'Senha do Roteador',
                  labelStyle:
                      TextStyle(color: Color.fromARGB(255, 157, 150, 150)),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: 400,
                height: 50,
                child: ElevatedButton(
                  onPressed: () async {
                    bool conexao = await conectar();
                    if (conexao) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Menu(
                              clientSSH: clientSSH,
                              password: password,
                            ),
                          ));
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Falha na Conexao,Verifique a Senha!!"),
                          duration: Duration(seconds: 1),
                        ),
                      );
                    }
                  },
                  // deixar o botão retangular
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      backgroundColor: const Color.fromARGB(255, 76, 167, 242),
                      elevation: 8,
                      shadowColor: const Color.fromARGB(255, 18, 198, 243)),

                  child: const Text(
                    'Acessar',
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 18,
                        color: Colors.white),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
