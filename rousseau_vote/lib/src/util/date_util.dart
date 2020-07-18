
const List<String> ITALIAN_MONTHS = <String>[
  'Gennaio',
  'Febbraio',
  'Marzo',
  'Aprile',
  'Maggio',
  'Giugno',
  'Luglio',
  'Agosto',
  'Settembre',
  'Ottobre',
  'Novembre',
  'Dicembre',
];

extension DateParsing on DateTime {
  String get monthString {
    return ITALIAN_MONTHS[month - 1];
  }
}
