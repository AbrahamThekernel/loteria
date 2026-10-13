import 'package:flutter_test/flutter_test.dart';
import 'package:loteria_dolores/logica/verificador_patrones.dart';

void main() {
  test('detecta una linea horizontal completa', () {
    final marcadas = [
      [true, true, true, true],
      [false, false, false, false],
      [false, false, false, false],
      [false, false, false, false],
    ];
    expect(VerificadorPatrones.hayLinea(marcadas), true);
  });

  test('no detecta linea si ninguna fila esta completa', () {
    final marcadas = [
      [true, true, true, false],
      [false, false, false, false],
      [false, false, false, false],
      [false, false, false, false],
    ];
    expect(VerificadorPatrones.hayLinea(marcadas), false);
  });

  test('detecta una columna vertical completa', () {
    final marcadas = [
      [true, false, false, false],
      [true, false, false, false],
      [true, false, false, false],
      [true, false, false, false],
    ];
    expect(VerificadorPatrones.hayColumna(marcadas), true);
  });

  test('no detecta columna si ninguna esta completa', () {
    final marcadas = [
      [true, false, false, false],
      [true, false, false, false],
      [false, false, false, false],
      [true, false, false, false],
    ];
    expect(VerificadorPatrones.hayColumna(marcadas), false);
  });

  test('detecta la diagonal principal completa', () {
    final marcadas = [
      [true, false, false, false],
      [false, true, false, false],
      [false, false, true, false],
      [false, false, false, true],
    ];
    expect(VerificadorPatrones.hayDiagonal(marcadas), true);
  });

  test('detecta la diagonal secundaria completa', () {
    final marcadas = [
      [false, false, false, true],
      [false, false, true, false],
      [false, true, false, false],
      [true, false, false, false],
    ];
    expect(VerificadorPatrones.hayDiagonal(marcadas), true);
  });
}
