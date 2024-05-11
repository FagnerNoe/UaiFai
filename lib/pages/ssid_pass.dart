import 'package:flutter/material.dart';

import 'package:ssh2/ssh2.dart';
import 'package:uaifai/pages/login_page.dart';

class SssidSenha extends StatefulWidget {
  final SSHClient clientSSH;

  const SssidSenha({super.key, required this.clientSSH});

  @override
  State<SssidSenha> createState() => _SssidSenhaState();
}

class _SssidSenhaState extends State<SssidSenha> {
  bool status = false;
  final TextEditingController nomeWifi = TextEditingController();
  final TextEditingController senhaWifi = TextEditingController();
  String? _btnSelecionado;

  void btnApertado(String nomeHgu) {
    setState(() {
      _btnSelecionado = nomeHgu;
    });
  }

  @override
  void initState() {
    super.initState();
    print(widget.clientSSH.passwordOrKey);
    print(widget.clientSSH.host);
    print(widget.clientSSH.port);
  }

  Future<bool> configurarRede() async {
    bool configurado = true;
    try {
      await widget.clientSSH.isConnected();
      await widget.clientSSH.startShell(
          ptyType: "xterm",
          callback: (dynamic res) {
            print(res);
          });
      if (_btnSelecionado == "askey") {
        var result = await widget.clientSSH
            .writeToShell("set wifi ssid ${nomeWifi.text}\n");

        var result2 = await widget.clientSSH
            .writeToShell("set wifi password ${senhaWifi.text}\n");
        print(result);
        print(result2);

        configurado = true;

        if (status == true) {
          var result3 =
              widget.clientSSH.writeToShell("set unique_SSID disabled\n");
          print(result3);
        } else {
          var result4 =
              widget.clientSSH.writeToShell("set unique_SSID enabled\n");
          print(result4);
        }
      } else if (_btnSelecionado == "mitra") {
        var resultMitra = await widget.clientSSH
            .writeToShell("wlan config ssid 1:1st ${nomeWifi.text}\n");

        var resultMitraSenha = await widget.clientSSH
            .writeToShell("wlan config wpapskey 1:1st ${senhaWifi.text}\n");

        print(resultMitra);
        print(resultMitraSenha);

        if (status == true) {
          var result3 =
              widget.clientSSH.writeToShell("wlan5 config status -i 1 up\n");
          widget.clientSSH.writeToShell(
              "wlan5 config ssid -i 1 ${"${nomeWifi.text}-5G"}\n");
          widget.clientSSH
              .writeToShell("wlan5 config wpapskey -i 1 ${senhaWifi.text}\n");
          widget.clientSSH.writeToShell("wlan5 config status -i 0 down\n");
          print(result3);
        } else {
          var result4 =
              widget.clientSSH.writeToShell("set unique_SSID enabled\n");
          print(result4);
        }
      }
    } catch (e) {
      print(e);
      configurado = false;
    }
    return configurado;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 243, 244, 244),
        body: Stack(children: [
          Container(
              alignment: Alignment.center,
              width: double.infinity,
              height: double.infinity,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            btnApertado("askey");
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: _btnSelecionado == "askey"
                                  ? Color.fromARGB(255, 6, 103,
                                      24) // Cor quando o botão é pressionado
                                  : const Color.fromARGB(255, 204, 212,
                                      212), // Cor original do botão

                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10))),
                          child: const Text("Askey"),
                        ),
                        ElevatedButton(
                            onPressed: () {
                              btnApertado("mitra");
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: _btnSelecionado == "mitra"
                                    ? Color.fromARGB(255, 43, 6,
                                        103) // Cor quando o botão é pressionado
                                    : const Color.fromARGB(255, 204, 212, 212),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10))),
                            child: const Text("Mitra")),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      width: 376,
                      height: 480,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "Nome da Rede",
                                style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(255, 19, 102, 169)),
                              )
                            ],
                          ),
                          TextField(
                              controller: nomeWifi,
                              style: const TextStyle(
                                  height: 1,
                                  fontFamily: "Poppins",
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400),
                              decoration: InputDecoration(
                                  hintText: "Utilize _ para nomes com espaços",
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(
                                        color: Colors.blue, width: 2.0),
                                  ))),
                          const SizedBox(height: 50),
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "Senha do Wifi",
                                style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(255, 19, 102, 169)),
                              ),
                            ],
                          ),
                          TextField(
                            controller: senhaWifi,
                            style: const TextStyle(
                                height: 1,
                                fontSize: 18,
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.w400),
                            decoration: InputDecoration(
                                hintText: "Minimo 8 caracteres",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                      color: Colors.blue, width: 2.0),
                                )),
                          ),
                          SizedBox(
                            height: 140,
                            width: 250,
                            child: Container(
                              margin: const EdgeInsets.only(top: 80),
                              decoration: BoxDecoration(
                                  gradient: const LinearGradient(colors: [
                                    Color.fromARGB(255, 37, 155, 182),
                                    Color.fromARGB(255, 73, 130, 237)
                                  ]),
                                  borderRadius: BorderRadius.circular(35)),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  const Text(
                                    'Separar Redes',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w700,
                                        fontSize: 18),
                                  ),
                                  Switch(
                                      activeColor: Colors.white,
                                      value: status,
                                      onChanged: (value) {
                                        setState(() => status = value);

                                        return;
                                      })
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 50),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          style: ElevatedButton.styleFrom(
                              elevation: 8,
                              backgroundColor:
                                  const Color.fromARGB(255, 28, 124, 227),
                              shadowColor:
                                  const Color.fromARGB(255, 13, 47, 170),
                              fixedSize: const Size(180, 60),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15))),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Icon(
                                Icons.arrow_back,
                                color: Colors.white,
                              ),
                              Text(
                                'VOLTAR',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16),
                              ),
                            ],
                          ),
                        ),
                        ElevatedButton(
                            onPressed: () async {
                              bool configurada = await configurarRede();
                              if (configurada == true && mounted == true) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text("Rede Configurada!!"),
                                    duration: Duration(seconds: 2),
                                  ),
                                );
                                Future.delayed(const Duration(seconds: 8), () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const LoginPage()));
                                });
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text("Não Deu!!"),
                                    duration: Duration(seconds: 3),
                                  ),
                                );
                                Future.delayed(const Duration(seconds: 2), () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const LoginPage()));
                                });
                              }
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    const Color.fromARGB(255, 62, 202, 67),
                                fixedSize: const Size(180, 60),
                                shadowColor:
                                    const Color.fromARGB(255, 16, 186, 21),
                                elevation: 8,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                )),
                            child: const Text(
                              'SALVAR',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Poppins',
                                  fontSize: 18),
                            )),
                      ],
                    )
                  ],
                ),
              ))
        ]));
  }
}
