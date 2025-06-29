# 🫘 Comité de Semillas – CoopeTarrazú (Base de Datos)

Este repositorio contiene el diseño y la implementación del esquema de base de datos para el sistema de gestión del **Comité de Semillas de la Asociación CoopeTarrazú Ficticio**, desarrollado como parte del curso **Diseño e Implementación de Bases de Datos - I Ciclo 2025** en la **Universidad Nacional**.

---

## 🎯 Objetivo del Proyecto

Diseñar e implementar una base de datos en **Oracle 21c XE** que permita la gestión de:

- Información de la asociación y sus contactos
- Junta Directiva y asociados
- Clasificación y cuotas de afiliación
- Fincas, lotes y cosechas
- Reproducción de semillas
- Ensayos agrícolas
- Plagas, enfermedades, inspecciones y análisis de laboratorio
- Gestión de parámetros generales y unidades de medida
- Procedimientos y funciones almacenadas para operaciones clave

---

## 🧱 Tecnologías y Herramientas

- Oracle 21c XE (instalado mediante Docker)
- SQL Developer / DBeaver (recomendado para la gestión)
- Scripts SQL y PL/SQL

---

## 📁 Estructura del Repositorio

```
📦 comite-semillas-db
├── scripts/
├── procedures/
│   └── .sql
├── README.md
```

---

## ⚙️ Instalación y Configuración

### 1. Instalar Oracle 21c XE usando Docker

```bash
docker run --name oracle-db -p 1521:1521 -p 1521:1521 -e ORACLE_PWD=your_password container-registry.oracle.com/database/express:21.3.0-xe
```

### 2. Verificar el estado del contenedor

```bash
docker ps
```
El servidor Oracle está listo cuando el campo STATUS muestra (healthy).

### 3. Conectarse a la base de datos

Desde fuera del contenedor:
```sql
sqlplus sys/your_password@//localhost:1521/XE as sysdba
sqlplus system/your_password@//localhost:1521/XE
sqlplus pdbadmin/your_password@//localhost:1521/XEPDB1
```

Desde dentro del contenedor:
```bash
docker exec -it oracle-db sqlplus / as sysdba
```
---

## 📦 Paquete PL/SQL - PckCSemilla

Contiene los siguientes procedimientos y funciones:

-
- **💡 Extra**: Procedimiento adicional a elección del estudiante.

---

## 📚 Consideraciones

- Todas las tablas tienen restricciones de llaves primarias, foráneas, no nulos y valores válidos.
- Se utilizan secuencias para los identificadores automáticos.
- El diseño cumple con las buenas prácticas de normalización y modularidad.

---

## 🧑‍💻 Autor

[Kevin Arauz]  
Estudiante de la Universidad Nacional  
Curso Diseño e Implementación de Bases de Datos – I Ciclo 2025

---

## 🏛️ Universidad Nacional 
Profesor: Mati HRomero