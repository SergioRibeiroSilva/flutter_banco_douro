import 'package:flutter/material.dart';
import 'package:flutter_banco_douro/models/account.dart';
import 'package:flutter_banco_douro/ui/styles/colors.dart';
import 'package:flutter_banco_douro/ui/widgets/account_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushReplacementNamed(
                context,
                "login",
              );
            },
            icon: Icon(Icons.logout),
          ),
        ],
        title: Text("Sistema de Gestão de Contas"),
        backgroundColor: AppColor.lightGrey,
      ),
      body: AccountWidget(
        account: Account(
          id: "22",
          name: "SERGIO RIBEIRO",
          lastName: "SILVA",
          balance: 300,
          accountType: null,
        ),
      ),
    );
  }
}
