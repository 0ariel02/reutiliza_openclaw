# Web Dev Environment - MacBook4,1 Optimizado

Entorno de desarrollo web ligero para recursos limitados (4GB RAM, Core2 Duo).

## Stack Ligero

- **Node.js:** v24.14.0 (ya instalado)
- **Editor:** vim / nano (nada de VS Code)
- **Servidor local:** http-server o live-server
- **Navegador:** Firefox (máx 5-6 pestañas)

## Comandos Útiles

```bash
# Iniciar servidor de desarrollo
npm run dev

# Instalar dependencias ligeras
npm install --save-dev http-server

# Ver uso de recursos
htop

# Limpiar node_modules si ocupa mucho
rm -rf node_modules && npm install
```

## Estructura del Proyecto

```
project-name/
├── index.html
├── css/
│   └── style.css
├── js/
│   └── main.js
├── assets/
│   └── images/
└── package.json
```

## Optimizaciones

- No usar webpack/vite a menos que sea necesario
- CSS vanilla en lugar de frameworks pesados
- JavaScript modular sin bundlers
- Imágenes optimizadas (webp, comprimidas)

## Tips de Rendimiento

1. **Cerrar Firefox** cuando no se use (consume ~600MB idle)
2. **Una pestaña de dev** a la vez
3. **Usar DevTools con moderación** (consumen RAM)
4. **Preferir archivos pequeños** y carga diferida

---
🦊 Configurado por Yori para Papa's MacBook
