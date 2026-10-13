import 'package:flutter_test/flutter_test.dart';
import 'package:loteria_dolores/logica/baraja.dart';
import 'package:loteria_dolores/logica/motor_juego.dart';
import 'package:loteria_dolores/logica/tabla.dart';

void main() {
  test('el motor detecta Loteria al completar una fila', () {
    final cartas =
        Baraja.crearBarajaCompleta().cartasRestantes; // orden fijo, sin mezclar
    final baraja = Baraja.desdeCartas(cartas);
    final tabla = Tabla.desdeFilas([
      cartas.sublist(0, 4),
      cartas.sublist(4, 8),
      cartas.sublist(8, 12),
      cartas.sublist(12, 16),
    ]);
    final motor = MotorJuego(baraja: baraja, tabla: tabla);

    // cantarSiguiente() usa removeLast(), asi que canta primero
    // las ultimas 4 cartas de la lista: exactamente la fila 3 de la tabla.
    for (var i = 0; i < 4; i++) {
      motor.cantarYMarcar();
    }

    expect(motor.haGanado, true);
  });

  test('el motor NO reporta Loteria si aun no se completa ningun patron', () {
    final cartas = Baraja.crearBarajaCompleta().cartasRestantes;
    final baraja = Baraja.desdeCartas(cartas);
    final tabla = Tabla.desdeFilas([
      cartas.sublist(0, 4),
      cartas.sublist(4, 8),
      cartas.sublist(8, 12),
      cartas.sublist(12, 16),
    ]);
    final motor = MotorJuego(baraja: baraja, tabla: tabla);

    motor.cantarYMarcar();
    motor.cantarYMarcar();

    expect(motor.haGanado, false);
  });
}
