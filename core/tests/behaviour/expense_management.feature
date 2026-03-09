Feature: Gestión de gastos
  Como estudiante
  Quiero registrar mis gastos
  Para controlar cuánto dinero gasto

  Scenario: Crear un gasto y comprobar cual es el total que llevo gastado
    Given un gestor de gastos vacío
    When añado un gasto de 5 euros llamado Café
    Then el total de dinero gastado debe ser 5 euros

  Scenario: Eliminar un gasto y comprobar cual es el total que llevo gastado
    Given un gestor con un gasto de 5 euros
    When elimino el gasto con id 1
    Then debe haber 0 gastos registrados

  Scenario: Crear y eliminar un gasto y comprobar que no he gastado dinero
    Given un gestor de gastos vacío
    When añado un gasto de 5 euros llamado Café
    And elimino el gasto con id 1
    Then debe haber 0 gastos registrados

  Scenario: Crear dos gastos diferentes y comprobar que el total que llevo gastado es la suma de ambos
    Given un gestor de gastos vacío
    When añado un gasto de 5 euros llamado Café
    And añado un gasto de 10 euros llamado Comida
    Then el total de dinero gastado debe ser 15 euros

  Scenario: Crear tres gastos diferentes que sumen 30 euros hace que el total sean 30 euros
    Given un gestor de gastos vacío
    When añado un gasto de 10 euros llamado Desayuno
    And añado un gasto de 10 euros llamado Almuerzo
    And añado un gasto de 10 euros llamado Cena
    Then el total de dinero gastado debe ser 30 euros
    And debe haber 3 gastos registrados

  Scenario: Crear tres gastos de 10, 30, 30 euros y elimino el ultimo gasto la suma son 40 euros
    Given un gestor de gastos vacío
    When añado un gasto de 10 euros llamado Libro
    And añado un gasto de 30 euros llamado Curso
    And añado un gasto de 30 euros llamado Software
    And elimino el gasto con id 3
    Then el total de dinero gastado debe ser 40 euros
    And debe haber 2 gastos registrados

  Scenario: Crear varios gastos y borrar un gasto intermedio mantiene la suma correcta
    Given un gestor de gastos vacío
    When añado un gasto de 10 euros llamado Transporte
    And añado un gasto de 30 euros llamado Comida
    And añado un gasto de 30 euros llamado Cine
    And elimino el gasto con id 2
    Then el total de dinero gastado debe ser 40 euros

# BONUS

  Scenario: Modificar el titulo de un gasto existente
    Given un gestor con un gasto de 20 euros
    When actualizo el titulo del gasto con id 1 a "Suscripcion"
    Then el titulo del gasto con id 1 debe ser "Suscripcion"

  Scenario: Actualizar el monto de un gasto existente cambia el total
    Given un gestor con un gasto de 20 euros
    When actualizo el monto del gasto con id 1 a 50
    Then el total de dinero gastado debe ser 50 euros

  Scenario: Comprobar el resumen de gastos del mes actual
    Given un gestor de gastos vacío
    When añado un gasto de 100 euros llamado Alquiler
    Then el total del mes actual debe ser 100 euros