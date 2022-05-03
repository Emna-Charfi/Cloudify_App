import 'package:cloudify_application/home.dart';
import 'package:cloudify_application/pages/authentication.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecretVaultScreen extends StatelessWidget {
  final String? userName;

  final String? password;

  SecretVaultScreen({this.userName, this.password});

  @override
  Widget build(BuildContext context) {
    final storage = FlutterSecureStorage();
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: AppBar(
        elevation: 0,
        leading: Container(),
        backgroundColor: Colors.blueGrey,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(
            left: 16.0,
            right: 16.0,
            bottom: 20.0,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(),
              const Icon(
                Icons.lock_open,
                size: 60,
                color: Colors.grey,
              ),
              const SizedBox(height: 24.0),
              Text(
                'You have successfully accessed the secret vault. Leaving the vault is pretty easy, just go back to the previous screen by using the "Leave vault" button.',
                style: TextStyle(
                  color: Colors.grey.withOpacity(0.8),
                  fontSize: 14,
                  letterSpacing: 0.2,
                ),
              ),
              const SizedBox(height: 24.0),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.redAccent),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                onPressed: () async {
                  bool isAuthenticated =
                      await Authentication.authenticateWithBiometrics();

                  if (isAuthenticated) {
                    storage.write(key: 'email', value: userName);
                    storage.write(key: 'password', value: password);
                    storage.write(key: 'usingBiometric', value: 'true');
                    print("****the username is :" + userName!);
                    print("the psw is *****" + password!);
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => Home(),
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Error authenticating using Biometrics.'),
                      ),
                    );
                  }
                },
                child: const Padding(
                  padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                  child: Text(
                    'Leave vault',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 2,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
