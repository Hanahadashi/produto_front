// confirmacao_dialog.dart
import 'package:flutter/material.dart';

class ConfirmacaoDialog {
  static Future<bool> confirmarExclusao(BuildContext context) async {
    return await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Confirmar exclusão"),
          content: Text("Tem certeza de que deseja excluir este produto?"),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text("Cancelar"),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: Text("Excluir"),
            ),
          ],
        );
      },
    ) ?? false;
  }

  static Future<bool> confirmarEdicao(BuildContext context) async {
    return await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Confirmar edição"),
          content: Text("Tem certeza de que deseja editar este produto?"),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text("Cancelar"),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: Text("Confirmar"),
            ),
          ],
        );
      },
    ) ?? false;
  }
}
