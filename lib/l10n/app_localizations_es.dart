// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appTitle => 'Pájaro Volador';

  @override
  String get playerId => 'ID de Jugador';

  @override
  String get enterNickname => 'Ingresa tu apodo de juego';

  @override
  String get selectDifficulty => 'Seleccionar Dificultad';

  @override
  String get easy => 'Fácil';

  @override
  String get normal => 'Normal';

  @override
  String get hard => 'Difícil';

  @override
  String highScore(int score) {
    return 'Puntuación Alta: $score';
  }

  @override
  String get startGame => 'Iniciar Juego';

  @override
  String get gameOver => 'Fin del Juego';

  @override
  String get newRecord => '🎉 ¡Nuevo Récord!';

  @override
  String score(int score) {
    return 'Puntuación: $score';
  }

  @override
  String get tryAgain => 'Intentar de Nuevo';

  @override
  String get backToHome => 'Volver al Inicio';

  @override
  String get playerIdRequired => 'Por favor ingresa ID de Jugador';

  @override
  String get aboutVersion => 'Versión 1.0.0';

  @override
  String get aboutDescription =>
      'Una demostración del juego Flappy Bird basada en Flutter que muestra el desarrollo de juegos con el motor Flame.';

  @override
  String get aboutPurpose =>
      'Creado con fines de aprendizaje y demostración del desarrollo de juegos en Flutter.';

  @override
  String get aboutAuthor => 'Autor: Evil0ctal';

  @override
  String get aboutDate => 'Creado: 27 de mayo de 2025';

  @override
  String get aboutOpenSource => 'Ver en GitHub';

  @override
  String get close => 'Cerrar';

  @override
  String get settings => 'Configuración';

  @override
  String get soundEffects => 'Efectos de Sonido';

  @override
  String get soundEffectsDesc => 'Sonidos de salto, puntuación y colisión';

  @override
  String get backgroundMusic => 'Música de Fondo';

  @override
  String get backgroundMusicDesc => 'Música relajante del juego';

  @override
  String get soundVolume => 'Volumen de Efectos';

  @override
  String get musicVolume => 'Volumen de Música';

  @override
  String get linesOfCode => 'Líneas de Código';

  @override
  String get supportedLanguages => 'Idiomas';

  @override
  String get funLevel => 'Nivel de Diversión';

  @override
  String get aboutFlutterPowered => 'Desarrollado con Flutter y Flame Engine';

  @override
  String get aboutGameDescription =>
      'Experimenta el clásico juego Flappy Bird reimaginado con tecnología Flutter moderna. Incluye animaciones fluidas, efectos de partículas, múltiples niveles de dificultad y seguimiento global de puntuaciones altas.';

  @override
  String get developerName => 'Evil0ctal';

  @override
  String get developerTitle => 'Desarrollador de Juegos Flutter';

  @override
  String get developerMessage =>
      '¡Gracias por jugar! Este juego muestra las capacidades de Flutter para el desarrollo de juegos. ¡Siéntete libre de explorar el código fuente y crear tus propios juegos increíbles!';

  @override
  String get viewSourceCode => 'Ver Código';

  @override
  String get backToGame => 'Volver al Juego';
}
