# hotel-# Sistema de Gestión Hotelera — Hotel Hacaritama

## Descripción del proyecto

Proyecto académico de diseño e implementación de una base de datos relacional para el Hotel Hacaritama, desarrollado en la asignatura Bases de Datos Relacionales de la Universidad Francisco de Paula Santander, Seccional Ocaña.

La solución busca organizar y centralizar la información relacionada con clientes, empleados, habitaciones, reservas y servicios hoteleros, facilitando su almacenamiento, consulta y administración mediante PostgreSQL.

## Objetivo general

Diseñar e implementar una base de datos relacional para apoyar la gestión de la información del Hotel Hacaritama, garantizando la integridad, consistencia y organización de los datos.

## Objetivos específicos

- Analizar los requisitos de información y las reglas del negocio.
- Elaborar los modelos conceptual, lógico y físico de la base de datos.
- Implementar las tablas, relaciones y restricciones mediante SQL.
- Incorporar registros de prueba para validar la estructura.
- Documentar la arquitectura de la solución mediante el modelo C4.
- Definir pruebas de aceptación de usuario (UAT).
- Utilizar PostgreSQL y Supabase como tecnologías de gestión y alojamiento de datos.

## Tecnologías utilizadas

- PostgreSQL: sistema gestor de bases de datos relacionales.
- Supabase: plataforma de alojamiento de PostgreSQL en la nube.
- pgAdmin: herramienta de administración y ejecución de consultas SQL.
- SQL: lenguaje para definir, insertar y consultar datos.
- Git y GitHub: control de versiones y almacenamiento del proyecto.

## Estructura de la base de datos

El diseño contempla diez tablas:

| Tabla | Descripción |
| --- | --- |
| country | Información de países. |
| state | Departamentos o estados. |
| city | Ciudades. |
| customer | Información de clientes. |
| employee | Información de empleados. |
| room | Habitaciones del hotel. |
| service | Servicios hoteleros. |
| reservation | Reservas realizadas. |
| reservation_room | Relación entre reservas y habitaciones. |
| reservation_service | Relación entre reservas y servicios. |

La estructura utiliza claves primarias, claves foráneas y restricciones de integridad para mantener relaciones consistentes entre los datos.

## Organización del repositorio

```text
hotel-hacaritama-bd/
├── README.md
├── documento
    └── Proyecto_BD
└── scripts/
    ├── DDL.sql
    └── DML.sql
```

Los nombres de los archivos SQL pueden variar según los archivos incluidos en la carpeta scripts.

## Instalación y ejecución

### Requisitos

- PostgreSQL.
- pgAdmin o un editor SQL compatible.
- Acceso a una base de datos PostgreSQL con permisos para crear tablas e insertar registros.

### Procedimiento

1. Clonar el repositorio:
   ```bash
   git clone https://github.com/Pirlopower420/hotel-hacaritama-bd.git
   ```
2. Abrir pgAdmin y conectarse a una base de datos PostgreSQL de desarrollo.
3. Abrir el script DDL y ejecutar las instrucciones para crear las tablas y restricciones.
4. Abrir el script DML y ejecutar las instrucciones para cargar los datos de prueba.
5. Verificar las tablas y relaciones mediante consultas SQL.

**Nota:** Se recomienda ejecutar los scripts sobre una base de datos vacía de desarrollo, siguiendo su orden de dependencias. No se deben ejecutar nuevamente sobre una base de datos que ya contiene la información sin verificar sus efectos.

## Documentación

El documento del proyecto incluye el análisis de requisitos, las reglas de negocio, los modelos de datos, las especificaciones de diseño, los scripts SQL, el modelo C4, las pruebas de aceptación de usuario y las conclusiones.

## Pruebas de aceptación

El informe contempla las siguientes categorías de pruebas:

- Integridad de datos.
- Consultas y reportes.
- Concurrencia.
- Seguridad.
- Rendimiento.
- Recuperación ante fallos.

La inclusión de estas pruebas en la documentación no implica que todas hayan sido ejecutadas o aprobadas.

## Equipo de trabajo

| Integrante | Código |
| --- | --- |
| Gerardo Durán | 0192199 |
| Jhon Gómez | 0192436 |
| Johan Trigos | 0192206 |
| Kevin Pérez | 0192388 |

## Información académica

**Universidad:** Universidad Francisco de Paula Santander, Seccional Ocaña (UFPSO)  
**Programa:** Ingeniería de Sistemas  
**Asignatura:** Bases de Datos Relacionales  
**Docente:** Byron Cuesta Quintero  
**Año:** 2026  
**Versión del documento:** 2.0

## Uso del repositorio

Este repositorio tiene fines académicos y reúne la documentación y los scripts SQL correspondientes al proyecto de base de datos del Hotel Hacaritama.
hacaritama-bd
