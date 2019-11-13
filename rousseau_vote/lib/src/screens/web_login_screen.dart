import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:rousseau_vote/src/providers/login.dart';
import 'package:rousseau_vote/src/widgets/loading_screen.dart';
import 'package:uuid/uuid.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebLoginScreen extends StatelessWidget {
  final String _loginUrl = _generateLoginUrl();

  @override
  Widget build(BuildContext context) {
    final login = Provider.of<Login>(context);
    if(login.isLoggedIn()) {
      Navigator.pushReplacementNamed(context, '/');
      return null;
    }
    if(login.isLoading()) {
      return LoadingScreen();
    }
    return WebView(
        initialUrl: _loginUrl,
        navigationDelegate: (NavigationRequest navigation) {
          if(!_isCodeRedirectUrl(navigation.url)) {
            return NavigationDecision.navigate;
          }
          login.login(_extractAuthorizationCode(navigation.url));
          return NavigationDecision.prevent;
        },
    );
  }

  static String _extractAuthorizationCode(String url) {
    return url.replaceAll(RegExp(r'.*code='), '').replaceAll(RegExp(r'&.*'), '');
  }


  static bool _isCodeRedirectUrl(String url) {
    return url.startsWith("http://localhost");
  }

  static String _generateLoginUrl() {
    final uri = Uri.https(
        'sso.rousseau.movimento5stelle.it',
        'auth/realms/rousseau/protocol/openid-connect/auth',
        {
          'client_id': 'camelot-frontend',
          'redirect_uri': 'http://localhost:8080',
          'response_mode': 'fragment',
          'response_type': 'code',
          'scope': 'openid email profile',
          'nonce': Uuid().v4(),
          'state': Uuid().v4(),
        }
    );
    return uri.toString();
  }
}