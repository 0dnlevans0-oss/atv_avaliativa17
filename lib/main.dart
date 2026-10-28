import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MeuApp(),
  ));
}

class MeuApp extends StatefulWidget {
  @override
  State<MeuApp> createState() => _MeuAppState();
}

class _MeuAppState extends State<MeuApp> {
  
  String veiculo = "Carro Econômico";
  bool seguro = false;
  bool gps = false;
  bool motorista = false;
  double dias = 1;
  int qtd = 1;
  double valorDiario = 0;
  double valorBruto = 0;
  double percentual = 0;
  double desconto = 0;
  double valorFinal = 0;
  String categoria = "";

  void alterarVeiculo(String novoVeiculo) {
    setState(() {
      veiculo = novoVeiculo;
      print(novoVeiculo);
    });
  }

  void alterarSeguro(bool novoValor) {
    setState(() {
      seguro = novoValor;
      print(novoValor);
    });
  }

  void alterarGps(bool novoValor) {
    setState(() {
      gps = novoValor;
      print(novoValor);
    });
  }

  void alterarMotorista(bool novoValor) {
    setState(() {
      motorista = novoValor;
      print(novoValor);
    });
  }

  void alterarDias(double novoValor) {
    setState(() {
      dias = novoValor;
      print(novoValor);
    });
  }

  void calcular() {
    qtd = dias.toInt();
    if (veiculo == "Carro Econômico") {
      valorDiario = 120;
    } else if (veiculo == "SUV") {
      valorDiario = 180;
    } else {
      valorDiario = 300;
    }

    if (seguro) {
      valorDiario = valorDiario + 40;
    }

    if (gps) {
      valorDiario = valorDiario + 15;
    }

    valorBruto = valorDiario * qtd;

    if (motorista) {
      valorBruto = valorBruto + 100;
    }

    if (qtd >= 15) {
      percentual = 10;
    } else if (qtd >= 7) {
      percentual = 5;
    } else {
      percentual = 0;
    }

    desconto = valorBruto * percentual / 100;
    valorFinal = valorBruto - desconto;

    if (valorFinal <= 1000) {
      categoria = "Cliente Bronze";
    } else if (valorFinal <= 3000) {
      categoria = "Cliente Prata";
    } else if (valorFinal <= 5000) {
      categoria = "Cliente Ouro";
    } else {
      categoria = "Cliente Platinum";
    }
  }

  String montarResumo() {
    String textoSeguro = "Não";
    if (seguro) {
      textoSeguro = "Sim";
    }

    String textoGps = "Não";
    if (gps) {
      textoGps = "Sim";
    }

    String textoMotorista = "Não";
    if (motorista) {
      textoMotorista = "Sim";
    }

    return "Veículo: $veiculo\n" +
        "Dias: $qtd\n" +
        "Seguro: $textoSeguro\n" +
        "GPS: $textoGps\n" +
        "Motorista adicional: $textoMotorista\n" +
        "Valor bruto: R\$ ${valorBruto.toStringAsFixed(2)}\n" +
        "Desconto (${percentual.toInt()}%): R\$ ${desconto.toStringAsFixed(2)}\n" +
        "Valor final: R\$ ${valorFinal.toStringAsFixed(2)}\n" +
        "Categoria: $categoria";
  }

  void finalizarReserva() {
    showDialog(
      context: context,
      builder: (contextDialogo) {
        return AlertDialog(
          title: Text("Confirmar Reserva"),
          content: Text(montarResumo()),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(contextDialogo);
              },
              child: Text("Cancelar"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(contextDialogo);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("Reserva realizada com sucesso!"),
                  ),
                );
              },
              child: Text("Confirmar Reserva"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    calcular();
    return Scaffold(
      appBar: AppBar(
        title: Text("Locadora de Carros"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Veículo (por dia): Econômico R\$ 120 | SUV R\$ 180 | Luxo R\$ 300",
              ),
              SegmentedButton<String>(
                segments: [
                  ButtonSegment(
                    value: "Carro Econômico",
                    label: Text("Econômico"),
                  ),
                  ButtonSegment(
                    value: "SUV",
                    label: Text("SUV"),
                  ),
                  ButtonSegment(
                    value: "Carro de Luxo",
                    label: Text("Luxo"),
                  ),
                ],
                selected: {veiculo},
                onSelectionChanged: (novaSelecao) {
                  alterarVeiculo(novaSelecao.first);
                },
              ),
              SizedBox(height: 10),
              Text("Seguro Completo (+ R\$ 40 por dia)"),
              Checkbox(
                value: seguro,
                onChanged: (valor) {
                  alterarSeguro(valor ?? false);
                },
              ),
              Text("GPS (+ R\$ 15 por dia)"),
              Checkbox(
                value: gps,
                onChanged: (valor) {
                  alterarGps(valor ?? false);
                },
              ),
              Text("Motorista Adicional (taxa fixa R\$ 100)"),
              Switch(
                value: motorista,
                onChanged: (valor) {
                  alterarMotorista(valor);
                },
              ),
              Text("Quantidade de dias: ${dias.toInt()}"),
              Slider(
                min: 1,
                max: 30,
                divisions: 29,
                value: dias,
                onChanged: (novoValor) {
                  alterarDias(novoValor);
                },
              ),
              Text("RESUMO DA LOCAÇÃO"),
              Text(montarResumo()),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: finalizarReserva,
                child: Text("Finalizar Reserva"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
