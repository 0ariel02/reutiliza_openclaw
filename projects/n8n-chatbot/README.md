# 🤖 Chatbot de Atención al Cliente con n8n

Guía completa para aprender a crear chatbots automatizados con n8n.

---

## 📚 ¿Qué es n8n?

**n8n** (pronunciado "n-eight-n") es una herramienta de automatización de workflows que te permite conectar diferentes aplicaciones y servicios sin necesidad de escribir mucho código.

### Características principales:
- **Node-based**: Flujos visuales con nodos interconectados
- **Self-hostable**: Puedes instalarlo en tu propio servidor (gratis)
- **Cloud disponible**: También tiene versión cloud (pago)
- **Extensible**: +200 integraciones nativas + funciones personalizadas
- **JavaScript/TypeScript**: Para lógica avanzada cuando la necesites

---

## 🚀 Instalación de n8n

### Opción 1: Docker (Recomendada)

```bash
docker run -it --rm \
  --name n8n \
  -p 5678:5678 \
  -v ~/.n8n:/home/node/.n8n \
  docker.n8n.io/n8nio/n8n
```

Accede a: `http://localhost:5678`

### Opción 2: npm (Global)

```bash
npm install n8n -g
n8n start
```

### Opción 3: n8n.cloud

Simplemente regístrate en [n8n.io](https://n8n.io) y usa su versión cloud.

---

## 💡 Ejemplo: Chatbot de Atención al Cliente

### Escenario
Un chatbot que:
1. Recibe mensajes de clientes (WhatsApp/Telegram/Web)
2. Clasifica la consulta (ventas, soporte, facturación)
3. Responde automáticamente preguntas frecuentes
4. Escala a humano si es necesario
5. Registra todo en una base de datos/Google Sheets

---

## 🔧 Workflow de Ejemplo

### Estructura del flujo:

```
[Webhook/Telegram] 
       ↓
[Clasificar intención] → (AI/Keyword matching)
       ↓
   ┌───┴───┬─────────┬────────────┐
   ↓       ↓         ↓            ↓
[Ventas] [Soporte] [Facturación] [Otros]
   ↓       ↓         ↓            ↓
[Responder] [Buscar KB] [Generar ticket] [Escalar humano]
   ↓       ↓         ↓            ↓
   └───────┴────┬────┴────────────┘
                ↓
        [Guardar en Google Sheets/DB]
```

---

## 📝 Paso a Paso para Crear el Chatbot

### Paso 1: Configurar el Trigger

**Nodo: Webhook** o **Telegram Trigger**

- **Webhook**: Para chat embebido en tu web
- **Telegram**: Para bot de Telegram (necesitas @BotFather)

```json
{
  "nombre": "Telegram Trigger",
  "configuración": {
    "botToken": "TU_TOKEN_DE_BOTFATHER",
    "updates": ["message"]
  }
}
```

### Paso 2: Clasificar la Intención

**Opción A: Con AI (OpenAI/Claude)**

```json
{
  "nombre": "OpenAI",
  "modelo": "gpt-4o-mini",
  "prompt": "Clasifica este mensaje en una categoría: ventas, soporte, facturación, otros. Responde solo con la categoría.\n\nMensaje: {{ $json.message }}",
  "output": "category"
}
```

**Opción B: Con palabras clave (más simple, gratis)**

```javascript
// Nodo Function
const message = $input.first().json.message.toLowerCase();

let category = 'otros';

if (message.includes('precio') || message.includes('comprar') || message.includes('producto')) {
  category = 'ventas';
} else if (message.includes('problema') || message.includes('error') || message.includes('no funciona')) {
  category = 'soporte';
} else if (message.includes('factura') || message.includes('pago') || message.includes('recibo')) {
  category = 'facturación';
}

return [{ json: { category, originalMessage: message } }];
```

### Paso 3: Responder Según Categoría

**Nodo: Switch** (para ramificar según categoría)

```
Switch basado en: {{ $json.category }}
Cases:
  - ventas → Nodo: Respuesta Ventas
  - soporte → Nodo: Búsqueda Base de Conocimiento
  - facturación → Nodo: Generar Ticket
  - otros → Nodo: Escalar a Humano
```

### Paso 4: Respuestas Automatizadas

**Nodo: Responder (Telegram/Send Webhook)**

```javascript
// Para ventas
const respuestasVentas = [
  "¡Gracias por tu interés! Nuestros productos van desde $50 hasta $500. ¿Qué te gustaría conocer?",
  "Tenemos envío gratis en compras mayores a $100. ¿Te ayudo con algo específico?",
  "¡Claro! ¿Qué producto te interesa? Te puedo dar detalles y precios."
];

return [{ json: { 
  text: respuestasVentas[Math.floor(Math.random() * respuestasVentas.length)],
  chatId: $input.first().json.chatId
}}];
```

### Paso 5: Base de Conocimiento (Soporte)

**Nodo: Google Sheets / Airtable / Database**

- Buscar en una hoja con preguntas frecuentes
- Match por palabras clave
- Devolver la respuesta más relevante

Estructura de la KB:
| Pregunta | Palabras Clave | Respuesta |
|----------|---------------|-----------|
| ¿Cómo reseteo mi contraseña? | contraseña, reset, olvidar | Ve a configuración > seguridad > resetear contraseña |
| ¿Dónde está mi pedido? | pedido, envío, tracking | Tu pedido se envía en 24-48hrs. Recibirás un email con tracking |

### Paso 6: Escalar a Humano

**Nodo: Notificación (Email/Slack/Telegram)**

```json
{
  "nombre": "Notificar a Humano",
  "destino": "slack-channel o email",
  "mensaje": "🚨 Chatbot necesita ayuda humana\n\nCliente: {{ $json.userId }}\nMensaje: {{ $json.message }}\nHora: {{ $now }}"
}
```

### Paso 7: Guardar Registro

**Nodo: Google Sheets / Database**

| Fecha | Usuario | Mensaje | Categoría | Respuesta | Estado |
|-------|---------|---------|-----------|-----------|--------|
| 2025-03-22 | @usuario | ¿Dónde está mi pedido? | soporte | Tu pedido... | Resuelto |

---

## 🎯 Funciones Avanzadas

### 1. Memoria de Conversación

Usa **n8n Memory** o una base de datos para recordar el contexto:

```javascript
// Guardar contexto
const context = {
  userId: $json.userId,
  lastTopic: $json.category,
  conversationHistory: [...previousMessages, $json.message]
};

// En el siguiente mensaje, recuperar y usar
```

### 2. Integración con IA

**OpenAI / Claude / Local LLM** para respuestas más inteligentes:

```javascript
// Prompt para IA
const prompt = `Eres un asistente de atención al cliente amable y útil.

Historial: {{ $json.conversationHistory }}
Nuevo mensaje: {{ $json.message }}

Responde de manera concisa y útil. Si no sabes algo, ofrece escalar a un humano.`;
```

### 3. Horarios de Atención

```javascript
// Nodo Function: Verificar horario
const now = new Date();
const hour = now.getHours();
const day = now.getDay(); // 0 = Domingo

const isBusinessHours = day >= 1 && day <= 5 && hour >= 9 && hour <= 18;

return [{ json: { isBusinessHours } }];

// Si no es horario → Respuesta automática "Te respondemos mañana"
```

### 4. Sentiment Analysis

```javascript
// Detectar si el cliente está enojado
const negativeWords = ['enojado', 'terrible', 'horrible', 'malo', 'pésimo', 'fraude'];
const message = $input.first().json.message.toLowerCase();

const isAngry = negativeWords.some(word => message.includes(word));

return [{ json: { isAngry, priority: isAngry ? 'alta' : 'normal' } }];
```

---

## 📦 Export: Workflow JSON de Ejemplo

Aquí tienes un workflow base que puedes importar en n8n:

```json
{
  "name": "Chatbot Atención al Cliente",
  "nodes": [
    {
      "id": "trigger",
      "name": "Telegram Trigger",
      "type": "n8n-nodes-base.telegramTrigger",
      "parameters": {
        "botToken": "TU_TOKEN_AQUI"
      }
    },
    {
      "id": "classify",
      "name": "Clasificar Intención",
      "type": "n8n-nodes-base.function",
      "parameters": {
        "functionCode": "// Código de clasificación (ver arriba)"
      }
    },
    {
      "id": "switch",
      "name": "Switch Categoría",
      "type": "n8n-nodes-base.switch",
      "parameters": {
        "propertyName": "category"
      }
    },
    {
      "id": "respond",
      "name": "Responder",
      "type": "n8n-nodes-base.telegram",
      "parameters": {
        "operation": "sendMessage"
      }
    }
  ],
  "connections": {
    "Telegram Trigger": {
      "main": [[{ "node": "Clasificar Intención", "type": "main", "index": 0 }]]
    },
    "Clasificar Intención": {
      "main": [[{ "node": "Switch Categoría", "type": "main", "index": 0 }]]
    }
  }
}
```

---

## 🎓 Recursos para Aprender

### Oficiales
- 📖 [Documentación n8n](https://docs.n8n.io)
- 🎬 [n8n YouTube Channel](https://youtube.com/c/n8n-io)
- 💬 [Comunidad n8n](https://community.n8n.io)

### Templates Gratuitos
- [n8n Workflow Templates](https://n8n.io/workflows)
- Busca: "chatbot", "customer service", "telegram bot"

### Cursos
- [n8n Beginner Course](https://docs.n8n.io/courses/) - Gratis
- [Udemy: n8n Automation](https://udemy.com) - Varios cursos pagos

---

## 🔐 Mejores Prácticas

1. **Credenciales**: Usa n8n Credentials, no hardcodees tokens
2. **Error Handling**: Agrega nodos Error Trigger para fallos
3. **Rate Limiting**: Respeta límites de APIs externas
4. **Logging**: Guarda todos los intercambios para auditoría
5. **Testing**: Prueba cada nodo individualmente antes de conectar todo

---

## 🚀 Siguientes Pasos

1. **Instala n8n** (Docker recomendado)
2. **Crea tu primer workflow** siguiendo esta guía
3. **Conecta un canal** (Telegram es el más fácil para empezar)
4. **Agrega inteligencia** (IA o reglas simples)
5. **Itera y mejora** basado en interacciones reales

---

## ❓ ¿Necesitas Ayuda?

Puedo ayudarte a:
- Crear workflows específicos para tu caso de uso
- Depurar nodos que no funcionan
- Integrar APIs personalizadas
- Optimizar flujos existentes

¡Solo dime qué necesitas! 🦊

---

*Última actualización: 2025-03-22*
*Creado para: Papa - Proyecto REVIVE-OLD-MACBOOK*
