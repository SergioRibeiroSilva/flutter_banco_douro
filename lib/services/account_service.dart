import 'dart:async';

import 'package:http/http.dart';
import 'dart:convert';

import '../models/account.dart';
import 'api_key.dart';

class AccountService {
  final StreamController<String> _streamController =
      StreamController<String>();
  Stream<String> get streamInfos =>
      _streamController.stream;

  String url =
      "https://api.github.com/gists/ac0b4d8708f0b80e8f99f9e3d1d00f23"; //essa chave é do Gist...

  Future<List<Account>> getAll() async {
    Response response = await get(
      Uri.parse(url),
      headers: {"Authorization": "Bearer $githubApiKey"},
    );

    print('Status Code: ${response.statusCode}');
    //print('Response Body: ${response.body}');

    if (response.statusCode == 200) {
      if (response.body.isNotEmpty) {
        try {
          final data = jsonDecode(response.body);
          print('Dados decodificados: $data');
        } catch (e) {
          print('Erro ao decodificar JSON: $e');
        }
      } else {
        print('Erro: Resposta vazia!');
      }
    } else {
      print('Erro na requisição: ${response.statusCode}');
    }

    print('================================');

    _streamController.add(
      "${DateTime.now()} | Requisição de leitura.",
    );

    Map<String, dynamic> mapResponse = json.decode(
      response.body,
    );

    bool existe = response.body.contains('"content":""');
    if (existe) {
      print("content está vazio");
    }

    List<dynamic> listDynamic = json.decode(
      mapResponse["files"]["accounts.json"]["content"],
    );

    List<Account> listAccounts = [];

    for (dynamic dyn in listDynamic) {
      Map<String, dynamic> mapAccount =
          dyn as Map<String, dynamic>;
      Account account = Account.fromMap(mapAccount);
      listAccounts.add(account);
    }

    return listAccounts;
  }

  addAccount(Account account) async {
    List<Account> listAccounts = await getAll();
    //List<Account> listAccounts = [];

    listAccounts.add(account);
    await save(listAccounts, accountName: account.name);
  }

  save(
    List<Account> listAccounts, {
    String accountName = "",
  }) async {
    List<Map<String, dynamic>> listContent = [];
    for (Account account in listAccounts) {
      listContent.add(account.toMap());
    }

    String content = json.encode(listContent);
    print(content);

    Response response = await post(
      Uri.parse(url),
      headers: {"Authorization": "Bearer $githubApiKey"},
      body: json.encode({
        "description": "account.json",
        "public": true,
        "files": {
          "accounts.json": {"content": content},
        },
      }),
    );

    if (response.statusCode.toString()[0] == "2") {
      _streamController.add(
        "${DateTime.now()} | Requisição adição bem sucedida ($accountName).",
      );
      print('Add bem sucedido.');
    } else {
      _streamController.add(
        "${DateTime.now()} | Requisição falhou ($accountName).",
      );
    }
  }
}
