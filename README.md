# ProyectoTesting

Construido sobre el código del profesor Juan P. Sandoval

Instalación:
- Usar ruby version `2.7`
- Correr `bundler install`

Para jugar:
- Correr `ruby lib/main.rb`
- Los barcos se ponen de forma horizontal (eligiendo la posición más a la izquierda) o vertical (eligiendo la posición más arriba).
- Una vez puestos los barcos se elige la file y la columna del disparo. Si se acierta a un barco, se repite.
- Una vez que un jugador haya hundido todos los barcos del contrincante, el juego termina y este es el ganador.

Para desarrollar:
- El código del juego va en `lib/`
- Los test van en `test/`
- Para instalar las dependencias: `bundle install`
- Para correr el juego: `ruby lib/main.rb`
- Para correr los test: `bundle exec rake test`
- Para correr el linter (rubocop): `bundle exec rubocop` (ó `bundle exec lint`)
- Para correr el linter y autocorregir errores simples: `bundle exec rubocop -A`

Consideraciones Rubocop:
- La regla:
```
AllCops:
   SuggestExtensions: false
```
No afecta en nada la ejecución del linter, solo es para que no entregue un output con sugerencias de nuevas extensiones.

- Aumentamos la class length de 100 a 160 y el method length de 10 a 20. Ambas medidas nos parecían muy restrictivas, y más que ayudar simplemente hacian el desarrollo más engorroso. Nos pareció una buena medida el aflojar los máximos un poco, para poder tener funciones y clases que tengan la lógica necesaria, sin modularizar cuando no tiene sentido hacerlo.
