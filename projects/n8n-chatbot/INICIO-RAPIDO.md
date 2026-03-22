# 🚀 Guía Rápida: Tu Primer Chatbot en 15 Minutos

## Paso 1: Instalar n8n (5 min)

```bash
# Opción más fácil con Docker
docker run -it --rm \
  --name n8n \
  -p 5678:5678 \
  -v ~/.n8n:/home/node/.n8n \
  docker.n8n.io/n8nio/n8n
```

Abre tu navegador: **http://localhost:5678**

---

## Paso 2: Crear Bot de Telegram (3 min)

1. Abre Telegram y busca **@BotFather**
2. Envía: `/newbot`
3. Ponle nombre: `Mi Chatbot Soporte`
4. Ponle username: `mi_soporte_bot`
5. **Guarda el token** que te da (se ve así: `123456789:ABCdefGHIjklMNOpqrsTUVwxyz`)

---

## Paso 3: Configurar n8n (3 min)

1. En n8n, ve a **Credentials** → **Add Credential**
2. Busca **Telegram API**
3. Pega tu token de BotFather
4. Guarda como: `Telegram Bot`

---

## Paso 4: Importar Workflow (2 min)

1. En n8n, click en **Workflows** → **Add Workflow**
2. Click en los 3 puntos **⋮** → **Import from File**
3. Selecciona: `workflow-ejemplo.json` (de este proyecto)
4. **Edita las credenciales** en cada nodo (selecciona las que creaste)

---

## Paso 5: Activar y Probar (2 min)

1. Click en **Activate** (toggle arriba a la derecha)
2. En Telegram, busca tu bot: `@mi_soporte_bot`
3. Envía: `/start`
4. Prueba mensajes como:
   - "¿Cuáles son los precios?"
   - "Tengo un problema con mi pedido"
   - "Necesito mi factura"

---

## ✅ ¡Listo!

Tu chatbot ya está funcionando. Ahora puedes:

- **Mejorar las respuestas** (edita los nodos Function)
- **Agregar más categorías** (añade casos al Switch)
- **Conectar IA** (agrega nodo OpenAI/Claude)
- **Guardar en tu propia hoja** (configura Google Sheets)

---

## 🆘 Problemas Comunes

### "Bot no responde"
- Verifica que el workflow esté **Activado** (toggle verde)
- Revisa que las credenciales de Telegram estén correctas

### "Error de credenciales"
- Ve a Credentials y vuelve a guardar
- Asegúrate de seleccionarlas en cada nodo

### "n8n no inicia"
```bash
# Limpia y reinicia
docker rm -f n8n
docker run -d --name n8n -p 5678:5678 -v ~/.n8n:/home/node/.n8n docker.n8n.io/n8nio/n8n
```

---

## 📚 Siguiente Nivel

Una vez domines esto, aprende:

1. **Base de conocimiento** → Conectar Google Sheets con FAQs
2. **IA para respuestas** → Nodo OpenAI para respuestas inteligentes
3. **Memoria** → Recordar conversaciones previas
4. **Multi-canal** → WhatsApp, Web chat, etc.

---

*¡Éxito, Papa! 🦊*
