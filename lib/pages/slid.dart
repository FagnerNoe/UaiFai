// ignore_for_file: avoid_single_cascade_in_expression_statements

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Slid extends StatefulWidget {
  final String password;
  const Slid({super.key, required this.password});

  @override
  State<Slid> createState() => _SlidState();
}

class _SlidState extends State<Slid> {
  String user = 'support';

  final controller = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..setBackgroundColor(const Color.fromARGB(0, 193, 177, 177))
    ..setNavigationDelegate(
      NavigationDelegate(
        onProgress: (int progress) {
          // Update loading bar.
        },
        onPageStarted: (String url) {},
        onPageFinished: (String url) {},
        onWebResourceError: (WebResourceError error) {},
        onNavigationRequest: (NavigationRequest request) {
          if (request.url.startsWith('http://192.168.15.1/instalador')) {
            return NavigationDecision.prevent;
          }
          return NavigationDecision.navigate;
        },
      ),
    )
    ..loadRequest(Uri.parse('http://192.168.15.1/instalador'));

  /*convertHexa() {
    String slidDigitado = idClient.text;
    String hexaDecimalValue = " ";
    for (int i = 0; i < slidDigitado.length; i++) {
      int codeHexa = slidDigitado.codeUnitAt(i);
      hexaDecimalValue += codeHexa.toRadixString(16);
    }
    return hexaDecimalValue;
  }

  Future<bool> slidCadastrar() async {
    bool cadastrado = false;
    String slid = convertHexa();
    bool isConnected = await widget.clientSSH.isConnected();
    print(isConnected);
    if (isConnected) {
      await widget.clientSSH.startShell(
          ptyType: "xterm",
          callback: (dynamic res) {
            print(res);
          });
      try {
        var resultado = await widget.clientSSH
            .writeToShell("set ont ploam_password $slid\n");
        print(resultado);
        await Future.delayed(const Duration(seconds: 2));
        await widget.clientSSH.writeToShell("set reboot on");
      } catch (e) {
        print(e);
      }
    }
    return cadastrado;
  }
*/
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 248, 248, 248),
        appBar: AppBar(
            title: const Text(
              "SLID",
              style: TextStyle(
                color: Colors.white,
                fontSize: 26,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.bold,
              ),
            ),
            centerTitle: true,
            foregroundColor: Colors.white,
            elevation: 10,
            backgroundColor: const Color.fromARGB(255, 29, 35, 41)),
        body: WebViewWidget(controller: controller..runJavaScript('''
            function injetarLogin(){
              document.getElementById('txtUser').value = '$user';
              document.getElementById('txtPass').value = "$widget.password";
              document.getElementById('btnLogin').enabled = true; 
            }
            window.onload = injetarLogin();
           
          ''')));
  }

  /*  
        SingleChildScrollView(
          padding: const EdgeInsets.only(top: 70, right: 10, left: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
             

   /*           Container(
                width: 380,
                height: 400,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    image: const DecorationImage(
                        image: AssetImage(
                          'assets/images/fundo_slid.jpg',
                        ),
                        fit: BoxFit.cover),
                    boxShadow: const [
                      BoxShadow(
                        blurRadius: 33,
                        color: Colors.grey,
                      )
                    ]),
              ),
              const SizedBox(
                height: 50,
              ),
              TextField(
                  controller: idClient,
                  maxLength: 10,
                  decoration: InputDecoration(
                    focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromARGB(255, 61, 160, 221))),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    label: const Text("SLID"),
                  ),
                  keyboardType: TextInputType.number),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  onPressed: () {
                    slidCadastrar();
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      elevation: 8,
                      padding: const EdgeInsets.only(
                          left: 100, top: 10, right: 100, bottom: 10),
                      shadowColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10))),
                  child: const Text(
                    "APLICAR",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ))

     */             
            ],
         */
}
