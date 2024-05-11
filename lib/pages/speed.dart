import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Speed extends StatefulWidget {
  const Speed({super.key});

  @override
  State<Speed> createState() => _SpeedState();
}

class _SpeedState extends State<Speed> {
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
          if (request.url.startsWith('https://www.fast.com/pt/')) {
            return NavigationDecision.prevent;
          }
          return NavigationDecision.navigate;
        },
      ),
    )
    ..loadRequest(Uri.parse('https://www.fast.com/pt/'));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 248, 248, 248),
        appBar: AppBar(
            title: const Text(
              "Teste de Velocidade",
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
        body: WebViewWidget(controller: controller));
  }
}
