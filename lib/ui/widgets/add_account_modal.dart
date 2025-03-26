import 'package:flutter/material.dart';
import 'package:flutter_banco_douro/ui/styles/colors.dart';

class AddAccountModal extends StatefulWidget {
  const AddAccountModal({super.key});

  @override
  State<AddAccountModal> createState() => _AddAccountModalState();
}

class _AddAccountModalState extends State<AddAccountModal> {

  String _accountType = "AMBROSIA";


  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.75,
      padding: const EdgeInsets.all(32),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 16),
            Center(
              child: Image.asset("assets/images/icon_add_account.png", width: 64),
            ),
            const SizedBox(height: 32),
            const Text(
              "Adicionar nova conta",
              style: TextStyle(fontWeight: FontWeight.w400, fontSize: 24),
            ),
            const SizedBox(height: 16),
            const Text(
              "Preencha os dados abaixo:",
              style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14),
            ),
            TextFormField(decoration: const InputDecoration(label: Text("Nome"))),
            TextFormField(
              decoration: const InputDecoration(label: Text("Último nome")),
            ),
            const SizedBox(height: 32),
            Text("Tipo da conta",),
            DropdownButton<String>(value: _accountType,
            isExpanded: true, items: [
              DropdownMenuItem(value: "AMBROSIA", child: Text("Ambrosia")),
              DropdownMenuItem(value: "CANJICA", child: Text("Canjica")),
              DropdownMenuItem(value: "PUDIM", child: Text("Pudim")),
              DropdownMenuItem(value: "BRIGADEIRO", child: Text("Brigadeiro")),
            ], onChanged: (valor) {
              if (valor != null) {
                setState(() {
                  _accountType = valor;
                });
              }
              
            },),

            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    child: const Text(
                      "Cancelar",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    style: const ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(AppColor.orange),
                    ),
                    child: const Text(
                      "Adicionar",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
              ],
            ),

          ],
        ),
      ),
    );
  }
}
