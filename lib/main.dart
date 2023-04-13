import 'package:flutter/material.dart';
import './widgets/chart.dart';
import './widgets/new_transaction.dart';
import './widgets/transaction_list.dart';

import 'models/transaction.dart';

void main() {
  //спосіб вимкнення landScape mode;
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitUp,
  //   DeviceOrientation.portraitDown,
  // ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  //Таким чином, context є всюди, і кожен віджет має свій власний context.
  // Тепер, можна сказати, context є елемент віджета в дереві елементів.
  // Це якась мета інформація про віджет і його розташування в дереві віджетів.
  //Flutter внутрішньо використовує context, щоб зрозуміти, куди належить цей віджет і всі context усіх віджетів
  //також це спосіб передачі данних між всіма віджетами в дереві. Конструктор може бути громізтким.
  // Отже в такому випадку можна юзати InheritedWidget який наприклад юзає MediaQuery & theme під капотом
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App',
      theme: ThemeData(
        primaryColor: Colors.purple,
        primarySwatch: Colors.deepOrange,
        fontFamily: 'Quicksand',
        textTheme: ThemeData.light().textTheme.copyWith(
            subtitle1: const TextStyle(
                fontFamily: 'OpenSans',
                fontWeight: FontWeight.bold,
                fontSize: 18),
            button: const TextStyle(color: Colors.white)),
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
  });

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with WidgetsBindingObserver { //клей між шаром віджетів і движком флатера
  final List<Transaction> _userTransactions = [
    // Transaction(
    //   id: 't1',
    //   title: 'New Shoes',
    //   amount: 69.99,
    //   date: DateTime.now(),
    // ),
    // Transaction(
    //   id: 't2',
    //   title: 'New cat',
    //   amount: 16.53,
    //   date: DateTime.now(),
    // ),
  ];

  @override
  void initState() {
    //щоразу, коли змінюється стан мого життєвого циклу, я хочете, щоб
    // ви перейшли до певного спостерігача та викликали метод didChangeAppLifeCycleState,
    WidgetsBinding.instance.addObserver(this);
    print('${this} - this');
    super.initState();
  }

  //this method will be called wherever app state changes
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print('${state} - state');
  }

  @override
  dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();

  }

  List<Transaction> get _recentTransactions {
    return _userTransactions.where((transaction) {
      return transaction.date
          .isAfter(DateTime.now().subtract(const Duration(days: 7)));
    }).toList();
  }

  void _addNewTransaction(String title, double amount, DateTime chosenDate) {
    final newTransaction = Transaction(
        id: DateTime.now().toString(),
        title: title,
        amount: amount,
        date: chosenDate);

    setState(() {
      _userTransactions.add(newTransaction);
    });
  }

  void _startAddNewTransaction(ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return GestureDetector(
          onTap: () {},
          behavior: HitTestBehavior.opaque,
          child: NewTransaction(_addNewTransaction),
        );
      },
    );
  }

  void _deleteTransaction(String id) {
    setState(() {
      _userTransactions.removeWhere((element) => element.id == id);
    });
  }

  Widget buildPortraitContent(mediaQuery, appBar){
    return SizedBox(
      height: (mediaQuery.size.height -
          appBar.preferredSize.height -
          mediaQuery.padding.top) *
          0.3,
      child: Chart(recentTransactions: _recentTransactions),
    );
  }

  Widget buildLandscapeContent(mediaQuery, appBar){
    return SizedBox(
      height: (mediaQuery.size.height -
          appBar.preferredSize.height -
          mediaQuery.padding.top) *
          0.7,
      child: Chart(recentTransactions: _recentTransactions),
    );
  }

  PreferredSizeWidget appBarContent(){
    return AppBar(
      title: const Text('Flutter App'),
      actions: [
        IconButton(
            onPressed: () => _startAddNewTransaction(context),
            icon: const Icon(Icons.add))
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    //булеан змінна для перевірки landscape
    final mediaQuery = MediaQuery.of(context);
    final isLandscape =
        mediaQuery.orientation == Orientation.landscape;

    final PreferredSizeWidget  appBar = appBarContent();

    final transactionListWidget = SizedBox(
      height: (mediaQuery.size.height -
              appBar.preferredSize.height -
          mediaQuery.padding.top) *
          0.7,
      child: TransactionList(_userTransactions, _deleteTransaction),
    );



    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            isLandscape
                //horizontal album
                ? buildLandscapeContent(mediaQuery, appBar)
                //front mobile oriental
                : buildPortraitContent(mediaQuery, appBar),
            transactionListWidget
            // Chart(recentTransactions: _recentTransactions),
            // transactionListWidget,
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => _startAddNewTransaction(context),
      ),
    );
  }
}
