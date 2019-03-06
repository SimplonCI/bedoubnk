class Lesson {
  String title;
  String level;
  double indicatorValue;
  int price;
  String content;

  Lesson(
      {this.title, this.level, this.indicatorValue, this.price, this.content});
}

class Historique {
  String libelle;
  String emetteur;
  String recepteur;
  int price;
  String dateValidation;
  double indicatorValue;
  Historique({this.libelle,this.emetteur,this.recepteur,this.price,this.dateValidation,this.indicatorValue});
}