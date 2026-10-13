import 'package:flutter_test/flutter_test.dart';
import 'package:loteria_dolores/logica/baraja.dart';
import 'package:loteria_dolores/logica/tabla.dart';
import 'package:loteria_dolores/modelos/carta.dart';

void main() {
  test('una tabla nueva contiene las 16 cartas, sin repetir', () {
    final cartas = Baraja.crearBarajaCompleta().cartasRestantes;
    final tabla = Tabla.generar(cartas);
    final todas = tabla.filas.expand((fila) => fila).toList();
    expect(todas.length, 16);
    expect(todas.toSet().length, 16);
  });

  test('una tabla nueva no tiene ninguna celda marcada', () {
    final cartas = Baraja.crearBarajaCompleta().cartasRestantes;
    final tabla = Tabla.generar(cartas);
    expect(tabla.marcadas.every((fila) => fila.every((m) => m == false)), true);
  });

  test('marcar encuentra la carta en la tabla y marca su celda', () {
    final cartas = Baraja.crearBarajaCompleta().cartasRestantes;
    final tabla = Tabla.generar(cartas);
    final cartaEnTabla = tabla.filas[0][0];
    tabla.marcar(cartaEnTabla);
    expect(tabla.marcadas[0][0], true);
  });

  test('marcar una carta que no esta en la tabla no cambia nada', () {
    final cartas = Baraja.crearBarajaCompleta().cartasRestantes;
    final tabla = Tabla.generar(cartas);
    const cartaAjena = Carta(id: 999, nombre: 'Carta inexistente');
    tabla.marcar(cartaAjena);
    expect(tabla.marcadas.every((fila) => fila.every((m) => m == false)), true);
  });
}
