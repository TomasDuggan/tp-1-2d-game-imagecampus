## TP 1: Juego 2D

Este repositorio sirve entrega del trabajo práctico 1 del trayecto de image campus 2025 de Desarrollo de Videojuegos con Godot.

## Como se usa este repositorio

Pueden crearse tranquilamente un repositorio de cero, pero si quieren tener uno con configuración para subir el juego a itch automáticamente, pueden generar un repositorio a partir de este:

https://github.com/user-attachments/assets/dbf1368c-6b99-4b02-bf84-7b63d299d5db


## Como subir a itch automáticamente

Se puede subir el juego a itch exportando normalmente y subiendo un zip con los archivos exportados, pero, si quieren ahorrarse el exportar cada vez, este repositorio está configurado para que, al recibir un push a la rama main, se suban los cambios a itch siempre que se tenga configurado los siguientes secretos en el repositorio:

- BUTLER_API_KEY -> lo obtienen aquí: https://itch.io/user/settings/api-keys
- ITCHIO_GAME -> nombre de su juego
- ITCHIO_USERNAME -> su usuario de itch
