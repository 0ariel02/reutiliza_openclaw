# Optimización del Sistema - MacBook4,1

> 📚 **Este archivo fue migrado al proyecto completo:**
> 
> ## 🦊 Revive Old MacBook Project
> 
> Documentación completa disponible en: `REVIVE-OLD-MACBOOK/`
> 
> - [README principal](REVIVE-OLD-MACBOOK/README.md)
> - [Guía de Setup](REVIVE-OLD-MACBOOK/docs/SETUP.md)
> - [Optimización completa](REVIVE-OLD-MACBOOK/docs/OPTIMIZATION.md)
> - [Desarrollo Web](REVIVE-OLD-MACBOOK/docs/WEB-DEV.md)
> - [Troubleshooting](REVIVE-OLD-MACBOOK/docs/TROUBLESHOOTING.md)
> - [Upgrades de Hardware](REVIVE-OLD-MACBOOK/docs/HARDWARE.md)
> 
> ### Scripts disponibles:
> ```bash
> ./REVIVE-OLD-MACBOOK/scripts/optimize-system.sh    # Optimización automática
> ./REVIVE-OLD-MACBOOK/scripts/check-hardware.sh     # Diagnóstico
> ./REVIVE-OLD-MACBOOK/scripts/disable-services.sh   # Desactivar servicios
> ```
> 
> ---

## 🚨 Problema Crítico Detectado

**Firefox está consumiendo ~1.5GB de RAM** (más del 35% de la memoria total)

### Solución Inmediata
- Cierra pestañas innecesarias (máx 5-6 activas)
- Considera usar una extensión como "Auto Tab Discard"
- Alternativa: navegador más ligero (Midori, Falkon)

---

## Servicios que Puedes Desactivar

Si **NO usas** estos servicios, desactívalos para liberar recursos:

### Bluetooth (si no usas dispositivos BT)
```bash
sudo systemctl stop bluetooth
sudo systemctl disable bluetooth
```

### Impresión CUPS (si no tienes impresora)
```bash
sudo systemctl stop cups
sudo systemctl stop cups-browsed
sudo systemctl disable cups
sudo systemctl disable cups-browsed
```

**Ahorro estimado:** 50-100MB de RAM

---

## Script de Optimización

Ejecuta cuando sientas la máquina lenta:

```bash
~/workspace/scripts/optimize-system.sh
```

Este script:
- Limpia cachés del sistema
- Muestra procesos pesados
- Verifica espacio en disco
- Da recomendaciones

---

## Entorno de Desarrollo Web

Creado en: `~/workspace/projects/web-dev/`

### Usar la plantilla:
```bash
cd ~/workspace/projects/web-dev/template
npm install
npm run dev
```

### Comandos clave:
- `npm run dev` - Inicia servidor en puerto 3000
- `htop` - Monitorea recursos en tiempo real

---

## Reglas de Oro para esta Máquina

1. **Firefox:** Máx 5-6 pestañas, cerrar cuando no se use
2. **Editores:** vim/nano, NADA de VS Code o Electron
3. **Node.js:** Ya instalado (v24.14.0) ✅
4. **Build tools:** Evitar webpack/vite a menos que sea necesario
5. **Imágenes:** Optimizar antes de usar (tinyjpg, webp)
6. **Monitoreo:** Usar `htop` regularmente

---

## Comandos de Emergencia

```bash
# Ver qué está consumiendo RAM
ps aux --sort=-%mem | head -10

# Limpiar caché de memoria (si está muy lenta)
sudo sync && sudo sysctl -w vm.drop_caches=3

# Matar proceso específico
kill -9 <PID>

# Ver espacio en disco
df -h
```

---

🦊 Configurado por Yori para Papa's MacBook
