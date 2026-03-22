#!/bin/bash
# optimize-system.sh - Optimización para MacBook4,1 con recursos limitados
# Papa's MacBook - 4GB RAM, Core2 Duo

set -e

echo "🦊 Yori's System Optimizer para MacBook4,1"
echo "==========================================="

# 1. Limpiar caché del sistema
echo "[1/5] Limpiando cachés..."
sudo apt clean
sudo apt autoclean
rm -rf ~/.cache/thumbnails/*
rm -rf /tmp/*

# 2. Verificar procesos pesados
echo "[2/5] Analizando procesos..."
echo "Top 5 procesos por memoria:"
ps aux --sort=-%mem | head -6 | tail -5

# 3. Alerta Firefox
FIREFOX_MEM=$(ps aux | grep firefox | grep -v grep | awk '{sum+=$6} END {print sum/1024}')
if (( $(echo "$FIREFOX_MEM > 1000" | bc -l) )); then
    echo "⚠️  ALERTA: Firefox está usando ${FIREFOX_MEM}MB de RAM"
    echo "   Recomendación: Cierra pestañas o usa un navegador más ligero"
fi

# 4. Optimizar swap
echo "[3/5] Verificando swap..."
swapon --show

# 5. Servicios que se pueden desactivar
echo "[4/5] Servicios innecesarios detectados:"
systemctl list-unit-files --state=enabled | grep -E "(bluetooth|cups|modemmanager)" || echo "   Nada crítico encontrado"

# 6. Espacio en disco
echo "[5/5] Espacio en disco:"
df -h / | tail -1

echo ""
echo "✅ Optimización completada"
echo ""
echo "💡 Tips para esta máquina:"
echo "   - Firefox: máx 5-6 pestañas"
echo "   - Usar vim/nano en lugar de editores pesados"
echo "   - Evitar Electron apps (VS Code, Slack, etc)"
echo "   - Usar 'htop' para monitorear recursos"
