import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

/* ------------ variaveis ----------------- */

String holder = 'Bubble Sort';
String botao = 'Bubble Sort';

String botaoSelect = 'Bubble Sort';

List<int> arrayExemplo = [
  12,
  8,
  6,
  17,
  5,
  3,
  1,
  18,
  9,
  4,
  25,
  16,
  2,
  23,
  14,
  27,
  19,
  21
];

List<int> arrayInput = [];

List<int> arrayOrdenado = [];

List<int> bubbleSortedArray = [];
List<int> insertionSortedArray = [];
List<int> mergeSortedArray = [];
List<int> quickSortedArray = [];
List<int> selectionSortedArray = [];
List<int> shellSortedArray = [];

var tempBubble;
var tempInsertion;
var tempMerge;
var tempQuick;
var tempSelection;
var tempShell;

var stopwatch = new Stopwatch();

/*--------------- classe myapp ----------------- */

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Metodos de Ordenação',
      theme: ThemeData(primarySwatch: Colors.blueGrey),
      home: MyHomePage(
        title: 'Metodos de Ordenação',
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Center(child: FormTexto()));
  }
}

/*-------------------Form de texto---------------------------*/
class FormTexto extends StatefulWidget {
  const FormTexto({Key? key}) : super(key: key);

  @override
  _FormTextoState createState() => _FormTextoState();
}

class _FormTextoState extends State<FormTexto> {
  final myController = TextEditingController();

  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        TextField(
          keyboardType: TextInputType.number,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          controller: myController,
        ),
        WidgetMenu(),
        SizedBox(
          height: 16,
        ),
        Text('Digite para adicionar ao array: ',
            style: TextStyle(fontWeight: FontWeight.normal, fontSize: 18)),
        SizedBox(
          height: 10,
        ),
        Text(arrayInput.toString(),
            style: TextStyle(fontWeight: FontWeight.normal, fontSize: 18)),
        SizedBox(
          height: 50,
        ),
        Text(
            'Avance para a página de ordenação \n sem adicionar '
            'elementos \n para visualizar um exemplo',
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18))
      ]),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Padding(
            padding: EdgeInsets.all(7.0),
            child: FloatingActionButton(
              onPressed: () {
                String textoForm = (myController.text);
                var valor;
                try {
                  valor = int.parse(textoForm);
                  arrayInput.add(valor);
                  setState(() {});
                } catch (FormatException) {}

                myController.clear();
              },
              tooltip: 'Adicionar elemento',
              child: const Icon(Icons.add),
            ),
          ),
          FloatingActionButton(
              tooltip: 'ordenar',
              child: const Icon(Icons.arrow_forward),
              heroTag: 'Tag',
              onPressed: () {
                if (arrayInput.isEmpty) {
                  arrayInput.addAll(arrayExemplo);
                }
                definirOrdenado();
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PaginaOrdem(),
                    ));
              }),
        ],
      ),
    );
  }
}

/* ------------------- pagina de ordenação ---------------------- */
class PaginaOrdem extends StatelessWidget {
  const PaginaOrdem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Center(
          child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 3),
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
                //color: Colors.blueGrey,
              ),
              //height: 250,
              padding: EdgeInsets.all(30),
              margin: EdgeInsets.all(20),
              child: Column(
                children: [
                  Text('Array original:',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                  Text('$arrayInput',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
                  Text('Lista ordenada por ',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                  Text('$holder :',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
                  Text('$arrayOrdenado',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
                ],
              )),
        ),
        floatingActionButton: FloatingActionButton(
            tooltip: 'Comparativo',
            child: const Icon(Icons.arrow_forward),
            heroTag: 'Tag',
            onPressed: () async {
              stopwatch.start();
              holder = 'Bubble Sort';
              definirOrdenado();
              await Future.delayed(const Duration(milliseconds: 50));
              stopwatch.stop();
              tempBubble = stopwatch.elapsedMilliseconds;
              stopwatch.reset();

              stopwatch.start();
              holder = 'Insertion Sort';
              definirOrdenado();
              await Future.delayed(const Duration(milliseconds: 50));
              stopwatch.stop();
              tempInsertion = stopwatch.elapsedMilliseconds;
              stopwatch.reset();

              stopwatch.start();
              holder = 'Merge Sort';
              definirOrdenado();
              await Future.delayed(const Duration(milliseconds: 50));
              stopwatch.stop();
              tempMerge = stopwatch.elapsedMilliseconds;
              stopwatch.reset();

              stopwatch.start();
              holder = 'Quick Sort';
              definirOrdenado();
              await Future.delayed(const Duration(milliseconds: 50));
              stopwatch.stop();
              tempQuick = stopwatch.elapsedMilliseconds;
              stopwatch.reset();

              stopwatch.start();
              holder = 'Selection Sort';
              definirOrdenado();
              await Future.delayed(const Duration(milliseconds: 50));
              stopwatch.stop();
              tempSelection = stopwatch.elapsedMilliseconds;
              stopwatch.reset();

              stopwatch.start();
              holder = 'Shell Sort';
              definirOrdenado();
              await Future.delayed(const Duration(milliseconds: 50));
              stopwatch.stop();
              tempShell = stopwatch.elapsedMilliseconds;
              stopwatch.reset();

              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PaginaComp(),
                  ));
            }));
  }
}

/* ------------------- pagina de comparação ---------------------- */
class PaginaComp extends StatelessWidget {
  const PaginaComp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Center(
          child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 3),
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              padding: EdgeInsets.all(30),
              margin: EdgeInsets.all(20),
              child: Column(
                children: [
                  Text('Bubble Sort:',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                  Text('$tempBubble ms',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
                  Text('Insertion Sort:',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                  Text('$tempInsertion ms',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
                  Text('Merge Sort:',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                  Text('$tempMerge ms',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
                  Text('Quick Sort:',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                  Text('$tempQuick ms',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
                  Text('Selection Sort:',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                  Text('$tempSelection ms',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
                  Text('Shell Sort:',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                  Text('$tempShell ms',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
                ],
              )),
        ),
        floatingActionButton: FloatingActionButton(
            tooltip: 'Home',
            child: const Icon(Icons.home),
            heroTag: 'Tag',
            onPressed: () {
              holder = botaoSelect;
              Navigator.pop(
                context,
              );
              Navigator.pop(
                context,
              );
              arrayOrdenado.clear();
              arrayInput.clear();
            }));
  }
}

/* --------------------------------------------------- 
-------------- inicio dos metodos de ordenação --------
------------------------------------------------------ */

//----------------------- bubble Sort

_bubbleSort(List<int> array) {
  List<int> SortedArray = List.of(array);
  int tamanho = SortedArray.length;
  for (int i = 0; i < tamanho - 1; i++) {
    for (int j = 0; j < tamanho - i - 1; j++) {
      if (SortedArray[j] > SortedArray[j + 1]) {
        int temp = SortedArray[j];
        SortedArray[j] = SortedArray[j + 1];
        SortedArray[j + 1] = temp;
      }
    }
  }

  return SortedArray;
}

//-------------------- Insertion Sort

_insertionSort(List<int> array) {
  List<int> SortedArray = List.of(array);
  int tamanho = SortedArray.length;
  for (var i = 0; i < tamanho; i++) {
    for (var j = i; j > 0 && SortedArray[j] < SortedArray[j - 1]; j--) {
      final tmp = SortedArray[j];
      SortedArray[j] = SortedArray[j - 1];
      SortedArray[j - 1] = tmp;
    }
  }
  return SortedArray;
}

//---------------------- merge Sort

_mergeSort(List<int> array) {
  List<int> SortedArray = List.of(array);
  if (SortedArray.length <= 1) {
    return SortedArray;
  }

  int splitIndex = SortedArray.length ~/ 2;

  List<int> arrayDireita = _mergeSort(SortedArray.sublist(0, splitIndex));
  List<int> arrayEsquerda = _mergeSort(SortedArray.sublist(splitIndex));

  return merge(arrayEsquerda, arrayDireita);
}

List<int> merge(array_Esquerda, array_Direita) {
  List<int> result = [];
  int? i = 0;
  int? j = 0;

  while (i! < array_Esquerda.length && j! < array_Direita.length) {
    if (array_Esquerda[i] <= array_Direita[j]) {
      result.add(array_Esquerda[i]);
      i++;
    } else {
      result.add(array_Direita[j]);
      j++;
    }
  }

  while (i! < array_Esquerda.length) {
    result.add(array_Esquerda[i]);
    i++;
  }

  while (j! < array_Direita.length) {
    result.add(array_Direita[j]);
    j++;
  }
  return result;
}

//------------------------ quick Sort

List<int> _quickSort<E extends Comparable<dynamic>>(
  List<int> array,
) {
  List<int> SortedArray = List.of(array);
  int tamanho = SortedArray.length;
  if (tamanho < 2) return SortedArray;
  final pivo = SortedArray[0];
  final menor = SortedArray.where(
    (value) => value.compareTo(pivo) < 0,
  );
  final igual = SortedArray.where(
    (value) => value.compareTo(pivo) == 0,
  );
  final maior = SortedArray.where(
    (value) => value.compareTo(pivo) > 0,
  );
  return [
    ..._quickSort(menor.toList()),
    ...igual,
    ..._quickSort(maior.toList()),
  ];
}

//------------------------ selection Sort

_selectionSort(array) {
  List<int> SortedArray = List.of(array);
  int tamanho = SortedArray.length;
  for (var i = 0; i < tamanho - 1; i++) {
    var index_min = i;
    for (var j = i + 1; j < tamanho; j++) {
      if (SortedArray[j] < SortedArray[index_min]) {
        index_min = j;
      }
    }
    if (index_min != i) {
      var temp = SortedArray[i];
      SortedArray[i] = SortedArray[index_min];
      SortedArray[index_min] = temp;
    }
  }
  return SortedArray;
}

//---------------- shell Sort

_shellSort(List<int> array) {
  List<int> SortedArray = List.of(array);
  int i, j, h, temp;
  int n = SortedArray.length;

  h = 1;

  do {
    h = 3 * h + 1;
  } while (h < n);
  do {
    h = (h / 3).truncate();
    for (i = h; i < n; i++) {
      temp = SortedArray[i];
      j = i;
      while (SortedArray[j - h] > temp) {
        SortedArray[j] = SortedArray[j - h];
        j -= h;
        if (j < h) break;
      }
      SortedArray[j] = temp;
    }
  } while (h != 1);

  return SortedArray;
}

/* ------------------ Menu DropDown -------------------- */

class WidgetMenu extends StatefulWidget {
  const WidgetMenu({Key? key}) : super(key: key);

  @override
  State<WidgetMenu> createState() => _WidgetMenuState();
}

class _WidgetMenuState extends State<WidgetMenu> {
  String dropdownValue = 'Bubble Sort';

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: dropdownValue,
      elevation: 16,
      style: const TextStyle(color: Colors.deepPurple),
      underline: Container(
        height: 2,
        color: Colors.blueAccent,
      ),
      onChanged: (String? newValue) {
        setState(() {
          dropdownValue = newValue!;
          botaoSelect = dropdownValue;
          holder = botaoSelect;
        });
      },
      items: <String>[
        'Bubble Sort',
        'Insertion Sort',
        'Merge Sort',
        'Quick Sort',
        'Selection Sort',
        'Shell Sort'
      ].map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}

/* ----------------------definir array ordenado------------------------ */
void definirOrdenado() {
  if (holder == 'Bubble Sort') {
    arrayOrdenado = _bubbleSort(arrayInput);
  } else if (holder == 'Insertion Sort') {
    arrayOrdenado = _insertionSort(arrayInput);
  } else if (holder == 'Merge Sort') {
    arrayOrdenado = _mergeSort(arrayInput);
  } else if (holder == 'Quick Sort') {
    arrayOrdenado = _quickSort(arrayInput);
  } else if (holder == 'Selection Sort') {
    arrayOrdenado = _selectionSort(arrayInput);
  } else if (holder == 'Shell Sort') {
    arrayOrdenado = _shellSort(arrayInput);
  } else {
    print('ta errado isso aqui');
  }
}
