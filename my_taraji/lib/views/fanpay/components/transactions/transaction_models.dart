class Transaction {
  String id;
  String title;
  DateTime date;
  String description;
  String xp;
  String coin;
  String imageName;

  Transaction({
    required this.id,
    required this.title,
    required this.date,
    required this.description,
    required this.xp,
    required this.coin,
    required this.imageName,
  });
}

class FanPayFakeData {
  List<Transaction> fakeData = [
    Transaction(
      id: '1',
      title: 'Taraji Store',
      date: DateTime.now(),
      description: '3:02 PM • Aug 22,2022',
      xp: 'XP : +300',
      coin: '-100 DT',
      imageName: 'Recharge',
    ),
    Transaction(
      id: '2',
      title: 'Recharge',
      date: DateTime.now(),
      description: '15:02 PM • Aug 02,2022',
      xp: 'XP : +100',
      coin: '-10.000 DT',
      imageName: 'Paypal',
    ),
    Transaction(
      id: '3',
      title: 'Don',
      date: DateTime.now(),
      description: '18:12 PM • Juin, 15,2022',
      xp: 'XP : +200',
      coin: '-15.000 DT',
      imageName: 'Don',
    ),
    Transaction(
      id: '4',
      title: 'Transfer',
      date: DateTime.now(),
      description: '11:26 PM • Mai 12,2022',
      xp: 'XP : +500',
      coin: '-20.000 DT',
      imageName: 'transfer',
    ),
    Transaction(
      id: '5',
      title: 'Taraji Store',
      date: DateTime.now(),
      description: '3:02 PM • Aug 22,2022',
      xp: 'XP : +300',
      coin: '-1000 DT',
      imageName: 'Recharge',
    ),
    Transaction(
      id: '6',
      title: 'Recharge',
      date: DateTime.now(),
      description: '15:02 PM • Aug 02,2022',
      xp: 'XP : +100',
      coin: '-10.000 DT',
      imageName: 'Paypal',
    ),
    Transaction(
      id: '7',
      title: 'Don',
      date: DateTime.now(),
      description: '18:12 PM • Juin, 15,2022',
      xp: 'XP : +200',
      coin: '-15.000 DT',
      imageName: 'Don',
    ),
    Transaction(
      id: '8',
      title: 'Transfer',
      date: DateTime.now(),
      description: '11:26 PM • Mai 12,2022',
      xp: 'XP : +500',
      coin: '-20.000 DT',
      imageName: 'transfer',
    ),
    Transaction(
      id: '9',
      title: 'Taraji Store',
      date: DateTime.now(),
      description: '3:02 PM • Aug 22,2022',
      xp: 'XP : +300',
      coin: '-1000 DT',
      imageName: 'Recharge',
    ),
    Transaction(
      id: '10',
      title: 'Recharge',
      date: DateTime.now(),
      description: '15:02 PM • Aug 02,2022',
      xp: 'XP : +100',
      coin: '-10.000 DT',
      imageName: 'Paypal',
    ),
  ];
}
