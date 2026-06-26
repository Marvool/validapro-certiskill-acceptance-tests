Feature: EP03 - Proceso de certificacion de habilidades
  Como candidato empirico
  Quiero completar evaluaciones y subir evidencias
  Para obtener una certificacion digital verificable

  Background:
    Given el candidato "Carlos Mamani" inicio sesion en CertiSkill
    And su perfil tiene al menos 70% de completitud

  Scenario Outline: US09 - Seleccionar una habilidad disponible
    Given el candidato esta en el catalogo de habilidades
    When selecciona la habilidad "<habilidad>"
    Then el sistema muestra la descripcion, requisitos y tiempo estimado
    And el boton "Iniciar evaluacion" queda habilitado

    Examples:
      | habilidad                | tiempo_estimado |
      | Reparacion de computadoras | 25 minutos      |
      | Desarrollo web basico      | 30 minutos      |
      | Gastronomia operativa      | 20 minutos      |

  Scenario: US10 - Completar evaluacion dentro del tiempo limite
    Given el candidato inicio la evaluacion de "Reparacion de computadoras"
    When responde todas las preguntas antes de que el temporizador llegue a cero
    And selecciona "Finalizar evaluacion"
    Then el sistema calcula la puntuacion en menos de 5 segundos
    And muestra el nivel obtenido: Basico, Intermedio o Avanzado

  Scenario: US10 - Tiempo agotado antes de finalizar
    Given el candidato esta respondiendo la evaluacion
    When el temporizador llega a cero
    Then el sistema cierra la evaluacion automaticamente
    And procesa las respuestas registradas
    And muestra la fecha desde la cual podra repetir la evaluacion

  Scenario Outline: US11 - Validar carga de video de demostracion
    Given el candidato aprobo la evaluacion teorica
    When intenta subir un video con formato "<formato>" y duracion "<duracion>"
    Then el resultado esperado es "<resultado>"

    Examples:
      | formato | duracion  | resultado                         |
      | MP4     | 02:40 min | video aceptado y estado En revision |
      | AVI     | 02:00 min | error por formato no compatible   |
      | MP4     | 04:20 min | error por duracion excedida       |

  Scenario: US12 - Emitir certificacion digital aprobada
    Given el evaluador aprobo la evidencia practica del candidato
    When registra la aprobacion en el panel de evaluacion
    Then el sistema genera un certificado digital en PDF
    And agrega un codigo QR verificable
    And vincula la certificacion al perfil publico del candidato
