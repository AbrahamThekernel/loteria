import 'motor_juego.dart';

class Partida {
  final List<MotorJuego> jugadores;

  Partida({required this.jugadores});

  MotorJuego? jugar() {
    var hayCartas = true;
    while (hayCartas) {
      hayCartas = false;
      for (final jugador in jugadores) {
        final carta = jugador.cantarYMarcar();
        if (carta != null) hayCartas = true;
        if (jugador.haGanado) return jugador;
      }
    }
    return null;
  }
}