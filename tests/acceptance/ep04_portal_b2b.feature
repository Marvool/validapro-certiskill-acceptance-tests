Feature: EP04 - Portal B2B para reclutadores
  Como reclutador B2B
  Quiero buscar y contactar candidatos certificados
  Para reducir el tiempo y riesgo de contratacion

  Background:
    Given la reclutadora "Sandra Torres" inicio sesion en el portal B2B
    And existen candidatos certificados publicados

  Scenario Outline: US13 - Buscar candidatos certificados con filtros
    Given la reclutadora esta en la vista de busqueda
    When aplica filtro de habilidad "<habilidad>", nivel "<nivel>" y ubicacion "<ubicacion>"
    Then el sistema muestra candidatos que cumplen todos los filtros
    And ordena los resultados por puntaje de certificacion

    Examples:
      | habilidad                 | nivel       | ubicacion |
      | Reparacion de computadoras | Intermedio  | Lima      |
      | Desarrollo web basico      | Avanzado    | Callao    |
      | Gastronomia operativa      | Basico      | Lima      |

  Scenario: US13 - Busqueda sin resultados
    Given la reclutadora aplica filtros sin coincidencias
    When ejecuta la busqueda
    Then el sistema muestra "No encontramos candidatos con esos criterios"
    And sugiere ampliar filtros

  Scenario: US14 - Visualizar perfil detallado de candidato
    Given la reclutadora ve la lista de candidatos certificados
    When selecciona el perfil de un candidato
    Then el sistema muestra datos generales, certificaciones, evidencias y puntajes
    And permite reproducir el video de demostracion si esta disponible

  Scenario: US15 - Contactar candidato desde la plataforma
    Given la reclutadora visualiza un candidato de interes
    When escribe un mensaje y selecciona "Enviar contacto"
    Then el sistema registra el mensaje en el historial
    And notifica al candidato por plataforma y correo

  Scenario: US16 - Agregar candidato a favoritos
    Given la reclutadora visualiza el perfil de un candidato
    When selecciona el icono de favorito
    Then el candidato queda guardado en la lista de favoritos de la empresa
