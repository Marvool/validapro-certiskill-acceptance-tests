Feature: Requisitos no funcionales de calidad
  Como usuario de CertiSkill
  Quiero que la plataforma sea rapida, disponible, segura y responsive
  Para confiar en el servicio durante el proceso de certificacion y contratacion

  Scenario Outline: US21 - Rendimiento de carga de paginas criticas
    Given el usuario tiene conexion estable de al menos 5 Mbps
    When abre la pagina "<pagina>"
    Then la carga completa debe tardar como maximo <segundos> segundos
    And el puntaje Lighthouse debe ser al menos <score>

    Examples:
      | pagina              | segundos | score |
      | Dashboard candidato | 3        | 80    |
      | Catalogo habilidades| 3        | 80    |
      | Portal B2B          | 3        | 80    |

  Scenario: US22 - Disponibilidad mensual minima
    Given el sistema esta desplegado en produccion
    When se revisa el monitoreo mensual
    Then la disponibilidad debe ser igual o mayor a 99.5%
    And no deben existir caidas criticas sin registro de incidente

  Scenario Outline: US23 - Responsividad en dispositivos moviles
    Given el usuario accede desde un smartphone de "<tamano>"
    When navega por "<flujo>"
    Then la interfaz no debe mostrar scroll horizontal
    And los botones principales deben ser tactiles y visibles

    Examples:
      | tamano       | flujo                 |
      | 5 pulgadas   | Registro candidato    |
      | 6.1 pulgadas | Evaluacion tecnica    |
      | 6.5 pulgadas | Busqueda B2B          |

  Scenario: US24 - Almacenamiento seguro de contrasenas
    Given un usuario registra o actualiza su contrasena
    When el sistema almacena la credencial
    Then la contrasena debe guardarse como hash con salt
    And nunca debe almacenarse en texto plano

  Scenario: US24 - Redireccion HTTPS obligatoria
    Given el usuario intenta abrir la plataforma con HTTP
    When realiza la solicitud
    Then el sistema debe redirigir automaticamente a HTTPS
