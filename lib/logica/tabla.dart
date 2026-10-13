import '../modelos/carta.dart';

class Tabla {
  final List<List<Carta>> filas;
  final List<List<bool>> marcadas;

  Tabla.desdeFilas(this.filas)
      : marcadas = List.generate(4, (_) => List.generate(4, (_) => false));

  static Tabla generar(List<Carta> cartas) {
    final copia = List<Carta>.from(cartas)..shuffle();
    final filas = <List<Carta>>[];
    for (var f = 0; f < 4; f++) {
      filas.add(copia.sublist(f * 4, f * 4 + 4));
    }
    return Tabla.desdeFilas(filas);
  }

  void marcar(Carta carta) {
    for (var f = 0; f < filas.length; f++) {
      for (var c = 0; c < filas[f].length; c++) {
        if (filas[f][c] == carta) {
          marcadas[f][c] = true;
          return;
        }
      }
    }
  }

  bool marcarCelda(int fila, int columna, Carta carta) {
    if (fila < 0 || fila >= filas.length) return false;
    if (columna < 0 || columna >= filas[fila].length) return false;
    if (filas[fila][columna] != carta) return false;
    marcadas[fila][columna] = true;
    return true;
  }
}
