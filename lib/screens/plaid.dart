import 'package:flutter/material.dart';
import 'package:plaid_flutter/plaid_flutter.dart';



class plad extends StatefulWidget {
  @override
  _pladState createState() => _pladState();
}
class _pladState extends State<plad> {
  late LegacyLinkConfiguration _publicKeyConfiguration;
  late LinkTokenConfiguration _linkTokenConfiguration;

  @override
  void initState() {
    super.initState();

    _publicKeyConfiguration = LegacyLinkConfiguration(
      clientName: "CLIENT_NAME",
      publicKey: "PUBLIC_KEY",
      environment: LinkEnvironment.sandbox,
      products: <LinkProduct>[
        LinkProduct.auth,
      ],
      language: "en",
      countryCodes: ['US'],
      userLegalName: "John Appleseed",
      userEmailAddress: "jappleseed@youapp.com",
      userPhoneNumber: "+1 (512) 555-1234",
    );

    _linkTokenConfiguration = LinkTokenConfiguration(
      token: "link-sandbox-c7587ebb-1e1c-4bec-adf3-d96dee5894bd",
    );
    PlaidLink.onSuccess(_onSuccessCallback);
    PlaidLink.onEvent(_onEventCallback);
    PlaidLink.onExit(_onExitCallback);
  }

  void _onSuccessCallback(String publicToken, LinkSuccessMetadata metadata) {
    print("onSuccess: $publicToken, metadata: ${metadata.description()}");
  }

  void _onEventCallback(String event, LinkEventMetadata metadata) {
    print("onEvent: $event, metadata: ${metadata.description()}");
  }

  void _onExitCallback(LinkError? error, LinkExitMetadata metadata) {
    print("onExit metadata: ${metadata.description()}");

    if (error != null) {
      print("onExit error: ${error.description()}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(

        body: Container(
          width: double.infinity,
          color: Colors.grey[200],
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("Connect your bank ",style:TextStyle(color:Colors.black,fontWeight:FontWeight.w500,fontSize:30)),
              SizedBox(height:25),
              Text("A few steps to go.....",style:TextStyle(color:Colors.black,fontWeight:FontWeight.w500)),
              SizedBox(height:25),

              ElevatedButton(
                onPressed: () =>
                    PlaidLink.open(configuration: _linkTokenConfiguration),
                child: Text("Connect Bank"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}