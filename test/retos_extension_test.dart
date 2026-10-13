import 'package:flutter_test/flutter_test.dart';
import 'package:loteria_dolores/logica/baraja.dart';
import 'package:loteria_dolores/logica/motor_juego.dart';
import 'package:loteria_dolores/logica/partida.dart';
import 'package:loteria_dolores/logica/tabla.dart';
import 'package:loteria_dolores/logica/verificador_patrones.dart';

void main() {
  group('RETO 1: tabla llena como premio mayor', () {
    test('detecta la tabla llena (las 16 celdas marcadas)', () {
      final marcadas = List.generate(4, (_) => List.generate(4, (_) => true));
      expect(VerificadorPatrones.estaLlena(marcadas), true);
    });

    test('no reporta tabla llena si falta una sola celda', () {
      final marcadas = List.generate(4, (_) => List.generate(4, (_) => true));
      marcadas[3][3] = false;
      expect(VerificadorPatrones.estaLlena(marcadas), false);
    });
  });

  group('RETO 2: contador de cartas cantadas', () {
    test('el motor lleva la cuenta de cuantas cartas se han cantado', () {
      final cartas = Baraja.crearBarajaCompleta().cartasRestantes;
      final motor = MotorJuego(
        baraja: Baraja.desdeCartas(cartas),
        tabla: Tabla.generar(cartas),
      );

      motor.cantarYMarcar();
      motor.cantarYMarcar();
      motor.cantarYMarcar();

      expect(motor.cartasCantadas, 3);
    });
  });

  group('RETO 3: marcado manual', () {
    test('marcar manualmente una celda correcta devuelve true', () {
      final cartas = Baraja.crearBarajaCompleta().cartasRestantes;
      final tabla = Tabla.desdeFilas([
        cartas.sublist(0, 4),
        cartas.sublist(4, 8),
        cartas.sublist(8, 12),
        cartas.sublist(12, 16),
      ]);

      final resultado = tabla.marcarCelda(0, 0, cartas[0]);

      expect(resultado, true);
      expect(tabla.marcadas[0][0], true);
    });

    test('un marcado incorrecto no cuenta como valido', () {
      final cartas = Baraja.crearBarajaCompleta().cartasRestantes;
      final tabla = Tabla.desdeFilas([
        cartas.sublist(0, 4),
        cartas.sublist(4, 8),
        cartas.sublist(8, 12),
        cartas.sublist(12, 16),
      ]);

      final resultado = tabla.marcarCelda(0, 1, cartas[0]);

      expect(resultado, false);
      expect(tabla.marcadas[0][1], false);
    });
  });

  group('RETO 4: segundo jugador simulado', () {
    test('detecta quien completa un patron primero', () {
      final cartas = Baraja.crearBarajaCompleta().cartasRestantes;

      final jugador1 = MotorJuego(
        baraja: Baraja.desdeCartas(cartas),
        tabla: Tabla.desdeFilas([
          cartas.sublist(0, 4),
          cartas.sublist(4, 8),
          cartas.sublist(8, 12),
          cartas.sublist(12, 16),
        ]),
      );
      final jugador2 = MotorJuego(
        baraja: Baraja.desdeCartas(cartas),
        tabla: Tabla.desdeFilas([
          cartas.sublist(12, 16),
          cartas.sublist(8, 12),
          cartas.sublist(4, 8),
          cartas.sublist(0, 4),
        ]),
      );

      final ganador = Partida(jugadores: [jugador1, jugador2]).jugar();

      expect(ganador, isNotNull);
    });
  });
}
