import 'package:flutter/material.dart';
import 'package:flutter_banco_douro/models/account.dart';
import 'package:flutter_banco_douro/services/account_service.dart';
import 'package:flutter_banco_douro/ui/styles/colors.dart';
import 'package:flutter_banco_douro/ui/widgets/account_widget.dart';
import 'package:flutter_banco_douro/ui/widgets/add_account_modal.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<List<Account>> _futureGetAll =
      AccountService().getAll();

  Future<void> refreshGetAll() async {
    setState(() {
      _futureGetAll = AccountService().getAll();
    });
  }

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
        child: RefreshIndicator(
          onRefresh: refreshGetAll,
          child: FutureBuilder(
            future: _futureGetAll,
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
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (context) {
              return AddAccountModal();
            },
            isScrollControlled: true,
          );
        }, //isScrollControlled ... importantíssimo....
        child: Icon(Icons.add),
        backgroundColor: AppColor.orange,
      ),
    );
  }
}
