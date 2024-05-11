import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:ssh2/ssh2.dart';
import 'package:uaifai/pages/slid.dart';
import 'package:uaifai/pages/speed.dart';
import 'package:uaifai/pages/ssid_pass.dart';

// ignore: must_be_immutable
class Menu extends StatelessWidget {
  final SSHClient clientSSH;
  final String password;
  const Menu({super.key, required this.clientSSH, required this.password});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(0),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
                width: double.infinity,
                height: double.infinity,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/fundo_ssid.jpg'),
                      fit: BoxFit.cover),
                )),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Slid(
                                        password: password,
                                      )));
                        },
                        child: Container(
                            width: 260,
                            height: 100,
                            margin: const EdgeInsets.only(bottom: 30),
                            decoration: BoxDecoration(
                                gradient: LinearGradient(colors: [
                                  const Color.fromARGB(255, 67, 70, 74)
                                      .withOpacity(0.8),
                                  const Color.fromARGB(255, 16, 16, 16)
                                      .withOpacity(0.7)
                                ]),
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(15)),
                                border: Border.all(
                                    color:
                                        const Color.fromARGB(255, 251, 7, 202),
                                    width: 3.0)),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.settings_suggest,
                                  size: 55,
                                  color: Colors.white,
                                ),
                                Text(
                                  'Inserir SLID',
                                  style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 18,
                                      decoration: TextDecoration.none,
                                      color: Colors.white),
                                ),
                              ],
                            )),
                      ),
                    )),
                ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SssidSenha(
                                        clientSSH: clientSSH,
                                      )));
                        },
                        child: Container(
                            width: 260,
                            height: 100,
                            margin: const EdgeInsets.only(bottom: 30),
                            decoration: BoxDecoration(
                                gradient: LinearGradient(colors: [
                                  const Color.fromARGB(255, 67, 70, 74)
                                      .withOpacity(0.8),
                                  const Color.fromARGB(255, 16, 16, 16)
                                      .withOpacity(0.7)
                                ]),
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(15)),
                                border: Border.all(
                                    color:
                                        const Color.fromARGB(255, 218, 246, 8),
                                    width: 3.0)),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.wifi,
                                  size: 55,
                                  color: Colors.white,
                                ),
                                Text(
                                  'Nome e Senha',
                                  style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 18,
                                      decoration: TextDecoration.none,
                                      color: Colors.white),
                                )
                              ],
                            )),
                      ),
                    )),
                ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 3, sigmaY: 5),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Speed()));
                        },
                        child: Container(
                          width: 260,
                          height: 100,
                          margin: const EdgeInsets.only(bottom: 30),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(colors: [
                              const Color.fromARGB(255, 41, 41, 42)
                                  .withOpacity(0.8),
                              const Color.fromARGB(255, 36, 35, 36)
                                  .withOpacity(0.7)
                            ]),
                            borderRadius: const BorderRadius.all(
                              Radius.circular(15),
                            ),
                            border: Border.all(
                                color: const Color.fromARGB(255, 76, 248, 13),
                                width: 3.0),
                          ),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.speed_outlined,
                                size: 55,
                                color: Colors.white,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Teste de ",
                                    style: TextStyle(
                                        decoration: TextDecoration.none,
                                        fontFamily: 'Poppins',
                                        fontSize: 18,
                                        color:
                                            Color.fromARGB(255, 245, 244, 245)),
                                  ),
                                  Text(
                                    "Velocidade",
                                    style: TextStyle(
                                        decoration: TextDecoration.none,
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontFamily: 'Poppins'),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    )),
                const SizedBox(
                  height: 100,
                ),
                ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 250, 178, 8),
                        elevation: 15,
                        shadowColor: const Color.fromARGB(255, 239, 242, 66),
                        foregroundColor: Colors.white,
                        fixedSize: const Size(300, 60),
                        shape: const RoundedRectangleBorder(
                            side: BorderSide(
                                color: Color.fromARGB(116, 248, 247, 248)),
                            borderRadius: BorderRadius.all(
                              Radius.circular(15),
                            ))),
                    child: const Text(
                      'SAIR',
                      style: TextStyle(fontFamily: 'Poppins', fontSize: 22),
                    ))
              ],
            ),
          ],
        ));
  }
}
