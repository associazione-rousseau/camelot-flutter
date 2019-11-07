import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:rousseau_vote/src/widgets/rousseau_logged_scaffold.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Login Screen')
          ],
        ),
      ),
    );
  }
   Widget build(BuildContext context) {

    return new MaterialApp(

      title: 'Generated App',

      theme: new ThemeData(

        primarySwatch: Colors.red,

        primaryColor: const Color(0xFFf44336),

        accentColor: const Color(0xFFf44336),

        canvasColor: new Image.network('https://aurasostenibile.files.wordpress.com/2011/11/connessioni2.jpg'),

      ),

      home: new MyHomePage(),

    );

  }

}



class MyHomePage extends StatefulWidget {

  MyHomePage({Key key}) : super(key: key);

  @override

  _MyHomePageState createState() => new _MyHomePageState();

}



class _MyHomePageState extends State<MyHomePage> {

    @override

    Widget build(BuildContext context) {

      return new Scaffold(

        appBar: new AppBar(

          new image.network('https://www.webnews.it/app/uploads/2019/04/rousseau-650x245.jpg'),

          fit:BoxFit.fill,

          width: 150.0,

          height: 110.0,

          ),

           body:

            new Text(

           "Entra nel Movimento 5 Stelle",

            textalign: textAlign.right

            style: new TextStyle(fontSize:21.0,

            color: const Color(0xFF000000),

            fontWeight: FontWeight.w400,

            fontFamily: "Roboto"),

            ),

             new Container(

              child:

                new Text(

                "Inserisci la tua email",

                style: new TextStyle(fontSize:26.0,

                color: const Color(0xFF000000),

                fontWeight: FontWeight.w400,

                fontFamily: "Roboto"),

                ),

                new TextField(

                style: new TextStyle(fontSize:26.0,

                color: const Color(0xFF000000),

                fontWeight: FontWeight.w200,

                fontFamily: "Roboto"),

                ),

                new Text(

                "Inserisci la tua password",

                style: new TextStyle(fontSize:26.0,

                color: const Color(0xFF000000),

                fontWeight: FontWeight.w400,

                fontFamily: "Roboto"),

                ),

                new TextField(

                style: new TextStyle(fontSize:26.0,

                color: const Color(0xFF000000),

                fontWeight: FontWeight.w200,

                fontFamily: "Roboto"),

                ),

                new Center(

                child:

                new Checkbox(key:null, onChanged: checkChanged, value:true),

                ),

                new Text(

                "Memorizza i miei dati di accesso",

                style: new TextStyle(fontSize:18.0,

                color: const Color(0xFF000000),

                fontWeight: FontWeight.w400,

                fontFamily: "Roboto"),

                ),

                new Text(

                "Possono accedere tutti gli iscritti",

                style: new TextStyle(fontSize:18.0, align: center,

                color: const Color(0xFF000000),

                fontWeight: FontWeight.w200,

                fontFamily: "Roboto"),

                ),

                new Text(

                "all'Associazione Movimento 5 Stelle",

                style: new TextStyle(fontSize:18.0, align: center,

                color: const Color(0xFF000000),

                fontWeight: FontWeight.w200,

                fontFamily: "Roboto"),

                ),

                new RaisedButton(key:null, onPressed:buttonPressed,

                color: const Color(red),

                child:

                  new Text(

                  "ISCRIVITI",

                    style: new TextStyle(fontSize:12.0,

                    color: const Color(white),

                    fontWeight: FontWeight.w500,

                    fontFamily: "Roboto"),

                  )

                new RaisedButton(key:null, onPressed:buttonPressed,

                color: const Color(red),

                child:

                  new Text(

                  "ACCEDI",

                    style: new TextStyle(fontSize:12.0,

                    color: const Color(white),

                    fontWeight: FontWeight.w500,

                    fontFamily: "Roboto"),

                  )

                  new Text(

                "Hai dimenticato la password",

                style: new TextStyle(fontSize:18.0, align: center,

                color: const Color(0xFF000000),

                fontWeight: FontWeight.w200,

                fontFamily: "Roboto"),

                ),

                new Image.network(

                'https://dona.ilblogdellestelle.it/assets/lugada/images/logo.svg',

                fit:BoxFit.fill,

                width: 100.0, 

                height: 100.0,

                ),

                

            color: const Color(0xFFb6adad),

            padding: const EdgeInsets.all(0.0),

            alignment: Alignment.center,

            width: 300.0,

            height: 380.0,

          ),

            ),

      );

    }

}
}
