// Importa os componentes visuais do Flutter, como botões, textos e telas.
import 'package:flutter/material.dart';

// Função principal do aplicativo, onde tudo começa.
void main() {
  // Inicia o aplicativo usando o MaterialApp.
  runApp(MaterialApp(
    // Remove a faixa de DEBUG que aparece no canto da tela.
    debugShowCheckedModeBanner: false,

    // Define MeuApp como a primeira tela do aplicativo.
    home: MeuApp(),
  ));
}

// Cria o widget principal do aplicativo.
// StatefulWidget permite que a tela seja atualizada quando os dados mudam.
class MeuApp extends StatefulWidget {
  // Cria o estado que controla as informações da tela.
  @override
  State<MeuApp> createState() => _MeuAppState();
}

// Classe responsável por guardar os dados e controlar a tela.
class _MeuAppState extends State<MeuApp> {

  // Guarda o veículo escolhido pelo usuário.
  String veiculo = "Carro Econômico";

  // Guarda se o seguro está selecionado.
  bool seguro = false;

  // Guarda se o GPS está selecionado.
  bool gps = false;

  // Guarda se o motorista adicional está ativado.
  bool motorista = false;

  // Guarda a quantidade de dias selecionada no Slider.
  double dias = 1;

  // Guarda a quantidade de dias convertida para número inteiro.
  int qtd = 1;

  // Guarda o preço diário do veículo com os opcionais.
  double valorDiario = 0;

  // Guarda o valor bruto total da locação.
  double valorBruto = 0;

  // Guarda a porcentagem de desconto aplicada.
  double percentual = 0;

  // Guarda o valor em dinheiro do desconto.
  double desconto = 0;

  // Guarda o valor final que o cliente deverá pagar.
  double valorFinal = 0;

  // Guarda a categoria do cliente de acordo com o valor final.
  String categoria = "";

  // Método que altera o veículo escolhido.
  void alterarVeiculo(String novoVeiculo) {
    // setState informa ao Flutter que a tela precisa ser atualizada.
    setState(() {
      // Salva o novo veículo selecionado.
      veiculo = novoVeiculo;

      // Mostra o veículo selecionado no console do VS Code.
      print(novoVeiculo);
    });
  }

  // Método que altera a seleção do seguro.
  void alterarSeguro(bool novoValor) {
    // Atualiza o estado da tela.
    setState(() {
      // Salva se o seguro está ativado ou desativado.
      seguro = novoValor;

      // Mostra o valor verdadeiro ou falso no console.
      print(novoValor);
    });
  }

  // Método que altera a seleção do GPS.
  void alterarGps(bool novoValor) {
    // Atualiza o estado da tela.
    setState(() {
      // Salva se o GPS está ativado ou desativado.
      gps = novoValor;

      // Mostra o valor verdadeiro ou falso no console.
      print(novoValor);
    });
  }

  // Método que altera a opção de motorista adicional.
  void alterarMotorista(bool novoValor) {
    // Atualiza o estado da tela.
    setState(() {
      // Salva se o motorista adicional está ativado.
      motorista = novoValor;

      // Mostra o valor verdadeiro ou falso no console.
      print(novoValor);
    });
  }

  // Método que altera a quantidade de dias escolhida.
  void alterarDias(double novoValor) {
    // Atualiza o estado da tela.
    setState(() {
      // Salva a nova quantidade de dias.
      dias = novoValor;

      // Mostra a quantidade selecionada no console.
      print(novoValor);
    });
  }

  // Método responsável por calcular o preço da locação.
  void calcular() {

    // Converte a quantidade de dias para um número inteiro.
    qtd = dias.toInt();

    // Verifica se o veículo escolhido é o econômico.
    if (veiculo == "Carro Econômico") {
      // Define o preço diário do carro econômico.
      valorDiario = 120;

    // Caso não seja econômico, verifica se é um SUV.
    } else if (veiculo == "SUV") {
      // Define o preço diário do SUV.
      valorDiario = 180;

    // Se não for econômico nem SUV, considera carro de luxo.
    } else {
      // Define o preço diário do carro de luxo.
      valorDiario = 300;
    }

    // Verifica se o cliente selecionou o seguro.
    if (seguro) {
      // Acrescenta R$ 40 ao preço diário.
      valorDiario = valorDiario + 40;
    }

    // Verifica se o cliente selecionou o GPS.
    if (gps) {
      // Acrescenta R$ 15 ao preço diário.
      valorDiario = valorDiario + 15;
    }

    // Multiplica o valor diário pela quantidade de dias.
    valorBruto = valorDiario * qtd;

    // Verifica se o motorista adicional está ativado.
    if (motorista) {
      // Acrescenta a taxa fixa de R$ 100 ao valor bruto.
      valorBruto = valorBruto + 100;
    }

    // Verifica se a locação tem 15 dias ou mais.
    if (qtd >= 15) {
      // Define o desconto de 10%.
      percentual = 10;

    // Caso tenha menos de 15 dias, verifica se tem 7 ou mais.
    } else if (qtd >= 7) {
      // Define o desconto de 5%.
      percentual = 5;

    // Se tiver menos de 7 dias, não há desconto.
    } else {
      // Define o desconto como zero.
      percentual = 0;
    }

    // Calcula o desconto em dinheiro sobre o valor bruto.
    desconto = valorBruto * percentual / 100;

    // Subtrai o desconto do valor bruto para obter o total.
    valorFinal = valorBruto - desconto;

    // Verifica se o valor final é de até R$ 1.000.
    if (valorFinal <= 1000) {
      // Define a categoria Bronze.
      categoria = "Cliente Bronze";

    // Verifica se o valor final é de até R$ 3.000.
    } else if (valorFinal <= 3000) {
      // Define a categoria Prata.
      categoria = "Cliente Prata";

    // Verifica se o valor final é de até R$ 5.000.
    } else if (valorFinal <= 5000) {
      // Define a categoria Ouro.
      categoria = "Cliente Ouro";

    // Se passar de R$ 5.000, entra na categoria Platinum.
    } else {
      // Define a categoria Platinum.
      categoria = "Cliente Platinum";
    }
  }

  // Método que monta o resumo da locação em formato de texto.
  String montarResumo() {

    // Começa considerando que o seguro não foi selecionado.
    String textoSeguro = "Não";

    // Verifica se o seguro está ativado.
    if (seguro) {
      // Altera o texto para Sim.
      textoSeguro = "Sim";
    }

    // Começa considerando que o GPS não foi selecionado.
    String textoGps = "Não";

    // Verifica se o GPS está ativado.
    if (gps) {
      // Altera o texto para Sim.
      textoGps = "Sim";
    }

    // Começa considerando que não há motorista adicional.
    String textoMotorista = "Não";

    // Verifica se o motorista adicional está ativado.
    if (motorista) {
      // Altera o texto para Sim.
      textoMotorista = "Sim";
    }

    // Retorna todas as informações da locação em um único texto.
    return "Veículo: $veiculo\n" +

        // Adiciona a quantidade de dias ao resumo.
        "Dias: $qtd\n" +

        // Adiciona a informação sobre o seguro.
        "Seguro: $textoSeguro\n" +

        // Adiciona a informação sobre o GPS.
        "GPS: $textoGps\n" +

        // Adiciona a informação sobre o motorista adicional.
        "Motorista adicional: $textoMotorista\n" +

        // Mostra o valor bruto com duas casas decimais.
        "Valor bruto: R\$ ${valorBruto.toStringAsFixed(2)}\n" +

        // Mostra a porcentagem e o valor do desconto.
        "Desconto (${percentual.toInt()}%): R\$ ${desconto.toStringAsFixed(2)}\n" +

        // Mostra o valor final com duas casas decimais.
        "Valor final: R\$ ${valorFinal.toStringAsFixed(2)}\n" +

        // Mostra a categoria do cliente.
        "Categoria: $categoria";
  }

  // Método que abre a janela para finalizar a reserva.
  void finalizarReserva() {

    // Abre um diálogo sobre a tela atual.
    showDialog(
      // Informa qual tela está abrindo o diálogo.
      context: context,

      // Constrói o conteúdo da janela de confirmação.
      builder: (contextDialogo) {

        // Cria a janela de diálogo.
        return AlertDialog(

          // Define o título da janela.
          title: Text("Confirmar Reserva"),

          // Mostra o resumo completo da locação.
          content: Text(montarResumo()),

          // Define os botões disponíveis na janela.
          actions: [

            // Cria o botão Cancelar.
            ElevatedButton(

              // Define o que acontece ao clicar no botão.
              onPressed: () {
                // Fecha a janela de confirmação.
                Navigator.pop(contextDialogo);
              },

              // Texto que aparece no botão.
              child: Text("Cancelar"),
            ),

            // Cria o botão Confirmar Reserva.
            ElevatedButton(

              // Define o que acontece ao confirmar a reserva.
              onPressed: () {

                // Fecha a janela de confirmação.
                Navigator.pop(contextDialogo);

                // Exibe uma mensagem na parte inferior da tela.
                ScaffoldMessenger.of(context).showSnackBar(

                  // Cria a mensagem de confirmação.
                  SnackBar(
                    // Define o texto exibido na mensagem.
                    content: Text("Reserva realizada com sucesso!"),
                  ),
                );
              },

              // Texto que aparece no botão.
              child: Text("Confirmar Reserva"),
            ),
          ],
        );
      },
    );
  }

  // Informa ao Flutter que este método constrói a interface da tela.
  @override
  Widget build(BuildContext context) {

    // Calcula os valores antes de mostrar o resumo na tela.
    calcular();

    // Cria a estrutura principal da tela.
    return Scaffold(

      // Cria a barra superior do aplicativo.
      appBar: AppBar(
        // Define o título da barra superior.
        title: Text("Locadora de Carros"),
      ),

      // Permite rolar a tela caso o conteúdo seja maior que o espaço disponível.
      body: SingleChildScrollView(

        // Adiciona espaçamento ao redor do conteúdo.
        child: Padding(
          // Define 20 pixels de espaçamento em todos os lados.
          padding: EdgeInsets.all(20),

          // Organiza os componentes da tela em uma coluna.
          child: Column(

            // Alinha os componentes à esquerda.
            crossAxisAlignment: CrossAxisAlignment.start,

            // Lista todos os componentes que aparecem na tela.
            children: [

              // ================= SEGMENTED BUTTON =================

              // Mostra os preços diários de cada veículo.
              Text(
                "Veículo (por dia): Econômico R\$ 120 | SUV R\$ 180 | Luxo R\$ 300",
              ),

              // Cria o seletor de veículos.
              SegmentedButton<String>(

                // Define as opções disponíveis no seletor.
                segments: [

                  // Opção de carro econômico.
                  ButtonSegment(
                    value: "Carro Econômico",
                    label: Text("Econômico"),
                  ),

                  // Opção de SUV.
                  ButtonSegment(
                    value: "SUV",
                    label: Text("SUV"),
                  ),

                  // Opção de carro de luxo.
                  ButtonSegment(
                    value: "Carro de Luxo",
                    label: Text("Luxo"),
                  ),
                ],

                // Marca o veículo que está selecionado.
                selected: {veiculo},

                // Executa quando o usuário seleciona outro veículo.
                onSelectionChanged: (novaSelecao) {
                  // Atualiza o veículo usando a primeira opção selecionada.
                  alterarVeiculo(novaSelecao.first);
                },
              ),

              // Adiciona 10 pixels de espaço vertical.
              SizedBox(height: 10),

              // ================= CHECKBOX SEGURO =================

              // Mostra a descrição e o preço do seguro.
              Text("Seguro Completo (+ R\$ 40 por dia)"),

              // Cria a caixa de seleção do seguro.
              Checkbox(
                // Mostra se a caixa está marcada.
                value: seguro,

                // Executa quando o usuário marca ou desmarca a caixa.
                onChanged: (valor) {
                  // Atualiza o estado do seguro.
                  alterarSeguro(valor ?? false);
                },
              ),

              // ================= CHECKBOX GPS =================

              // Mostra a descrição e o preço do GPS.
              Text("GPS (+ R\$ 15 por dia)"),

              // Cria a caixa de seleção do GPS.
              Checkbox(
                // Mostra se a caixa está marcada.
                value: gps,

                // Executa quando o usuário marca ou desmarca a caixa.
                onChanged: (valor) {
                  // Atualiza o estado do GPS.
                  alterarGps(valor ?? false);
                },
              ),

              // ================= SWITCH =================

              // Mostra a descrição da taxa do motorista adicional.
              Text("Motorista Adicional (taxa fixa R\$ 100)"),

              // Cria a chave para ativar ou desativar o motorista.
              Switch(
                // Mostra se a chave está ligada.
                value: motorista,

                // Executa quando a chave muda de posição.
                onChanged: (valor) {
                  // Atualiza a opção de motorista adicional.
                  alterarMotorista(valor);
                },
              ),

              // ================= SLIDER =================

              // Mostra a quantidade de dias selecionada.
              Text("Quantidade de dias: ${dias.toInt()}"),

              // Cria o controle deslizante para escolher os dias.
              Slider(
                // Define o menor valor permitido: 1 dia.
                min: 1,

                // Define o maior valor permitido: 30 dias.
                max: 30,

                // Permite selecionar somente números inteiros entre 1 e 30.
                divisions: 29,

                // Mostra a posição atual do controle deslizante.
                value: dias,

                // Executa quando o usuário movimenta o Slider.
                onChanged: (novoValor) {
                  // Atualiza a quantidade de dias.
                  alterarDias(novoValor);
                },
              ),

              // ================= RESUMO =================

              // Mostra o título da seção de resumo.
              Text("RESUMO DA LOCAÇÃO"),

              // Mostra os dados e os valores calculados da locação.
              Text(montarResumo()),

              // Adiciona 10 pixels de espaço vertical.
              SizedBox(height: 10),

              // ================= BOTÃO FINALIZAR =================

              // Cria o botão para finalizar a reserva.
              ElevatedButton(

                // Abre a janela de confirmação ao clicar.
                onPressed: finalizarReserva,

                // Define o texto do botão.
                child: Text("Finalizar Reserva"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}