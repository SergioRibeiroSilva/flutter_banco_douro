import 'package:flutter/material.dart';
import 'package:flutter_banco_douro/models/account.dart';
import 'package:flutter_banco_douro/services/account_service.dart';
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
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: FutureBuilder(
          future: AccountService().getAll(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
              case ConnectionState.waiting:
              case ConnectionState.active:
                return Center(
                  child: CircularProgressIndicator(),
                );
              case ConnectionState.done:
                {
                  if (snapshot.data == null ||
                      snapshot.data!.isEmpty) {
                    return Center(
                      child: Text("Lista vazia"),
                    );
                  } else {
                    List<Account> listAccounts =
                        snapshot.data!;

                    return ListView.builder(
                      itemCount: listAccounts.length,
                      itemBuilder: (context, index) {
                        Account account =
                            listAccounts[index];
                        return AccountWidget(
                          account: account,
                        );
                      },
                    );
                  }
                }
            }
          },
        ),
      ),
    );
  }
}
