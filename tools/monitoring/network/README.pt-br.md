#### Arquivo: `README.pt-br.md`

```markdown
# Monitor de Disponibilidade de Rede

[![en](https://img.shields.io/badge/lang-en-red.svg)](README.md)

Este repositório contém ferramentas CLI desenvolvidas para cenários de convergência IT/OT.

### Sobre a Ferramenta
Um script modular em Python projetado para diagnósticos de rede. Valida o status de múltiplos endpoints (Sites, APIs, CLPs, IHMs), tratando timeouts e códigos de status HTTP de forma robusta.

**Funcionalidades:**
- Verificação em lote (entradas separadas por vírgula).
- Tratamento de exceções (Timeouts, Erros de Conexão, SSL).
- Formato de saída padronizado para logs (`[TAG] Mensagem`).

**Como Executar:**

1. **Instalar dependências**
   ```bash
   pip install -r requirements.txt

### 2. Execute
```bash
python site_monitor.py
```