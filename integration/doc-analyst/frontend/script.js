// Global State
let config = {
    apiUrl: localStorage.getItem('api_endpoint') || "",
    apiKey: localStorage.getItem('google_api_key') || "",
    currentFile: null
};

// CAIXA PRETA: Guarda logs de sistema sem mostrar no chat
let hiddenLogs = []; 

document.addEventListener('DOMContentLoaded', () => {
    // 1. Carregar Tema
    loadThemePreference();

    // 2. Carregar Configurações Salvas
    const apiUrlInput = document.getElementById('apiUrlInput');
    const apiKeyInput = document.getElementById('apiKeyInput');

    if (apiUrlInput && config.apiUrl) apiUrlInput.value = config.apiUrl;
    if (apiKeyInput && config.apiKey) apiKeyInput.value = config.apiKey;

    // 3. Log Inicial
    logSystemEvent("System initialized. UI Ready.");
    updateStatus('READY');

    // 4. Listeners
    initEventListeners();
});

function initEventListeners() {
    // File Upload (Atualiza nome e bolinha de status)
    const fileInput = document.getElementById('fileInput');
    if (fileInput) {
        fileInput.addEventListener('change', (e) => {
            if (e.target.files.length > 0) {
                config.currentFile = e.target.files[0];
                document.getElementById('fileName').textContent = config.currentFile.name;
                
                logSystemEvent(`File loaded: ${config.currentFile.name}`);
                
                // Pisca status laranja rapidinho para dar feedback visual
                updateStatus('BUSY');
                setTimeout(() => updateStatus('READY'), 800);
            }
        });
    }

    // Enter Key no Chat
    const userQuestion = document.getElementById('userQuestion');
    if (userQuestion) {
        userQuestion.addEventListener('keypress', (e) => {
            if (e.key === 'Enter') handleSubmission();
        });
    }
}

// --- CORE FUNCTIONS ---

// Função para registrar evento oculto
function logSystemEvent(text) {
    const timestamp = new Date().toLocaleString();
    hiddenLogs.push({
        timestamp: timestamp,
        sender: 'SYSTEM',
        text: text,
        visible: false
    });
    console.log(`[SYSTEM LOG]: ${text}`);
}

// Controle do LED de Status (Apenas a bolinha)
function updateStatus(state) {
    const statusDot = document.querySelector('.status-dot');
    if (!statusDot) return;
    
    // Reset estilo inline
    statusDot.style = '';

    // Cores baseadas nas variáveis do CSS
    switch(state) {
        case 'READY': 
            statusDot.style.backgroundColor = 'var(--status-success)'; 
            break;
        case 'BUSY': 
            statusDot.style.backgroundColor = 'var(--status-warning)'; 
            break;
        case 'ERROR': 
            statusDot.style.backgroundColor = 'var(--status-error)'; 
            break;
    }
}

// Adiciona Mensagem Visível ao Chat
function appendMessage(text, type) {
    const container = document.getElementById('chatContainer');
    
    // Wrapper recebe a classe 'user' ou 'bot' para alinhar Dir/Esq
    const wrapper = document.createElement('div');
    wrapper.className = `message-wrapper ${type}`;
    
    // Checkbox para seleção (Report Mode)
    const checkbox = document.createElement('input');
    checkbox.type = 'checkbox';
    checkbox.className = 'msg-checkbox';
    
    // Conteúdo da mensagem
    const msgContent = document.createElement('div');
    msgContent.className = 'msg-content message';
    msgContent.innerHTML = text.replace(/\n/g, '<br>'); // Suporte a quebra de linha
    
    // Montagem
    wrapper.appendChild(checkbox);
    wrapper.appendChild(msgContent);
    
    container.appendChild(wrapper);
    container.scrollTop = container.scrollHeight;
}

// Envio (Lógica Principal)
async function handleSubmission() {
    const input = document.getElementById('userQuestion');
    const question = input.value.trim();
    if (!question) return;

    // 1. UI Updates (Imediato)
    appendMessage(question, 'user');
    input.value = '';
    updateStatus('BUSY');

    // VERIFICAÇÃO: Se não tiver API Key, usa modo SIMULAÇÃO para não quebrar o visual
    if (!config.apiUrl && !config.apiKey) {
        logSystemEvent("No API Key. Running in Simulation Mode.");
        setTimeout(() => {
            appendMessage("Simulation Mode: Please configure the backend API in settings to get real answers. (Mock Response)", 'bot');
            updateStatus('READY');
        }, 1000);
        return;
    }

    // 2. Chamada Real (Se tiver config)
    try {
        const formData = new FormData();
        formData.append('question', question);
        formData.append('google_key', config.apiKey);
        if (config.currentFile) formData.append('file', config.currentFile);

        const response = await fetch(`${config.apiUrl}/analyze`, {
            method: 'POST',
            body: formData
        });

        if (!response.ok) throw new Error("API Response not OK");

        const data = await response.json();
        
        appendMessage(data.answer, 'bot');
        updateStatus('READY');
        logSystemEvent(`Analysis completed for query: "${question.substring(0, 20)}..."`);

    } catch (error) {
        updateStatus('ERROR');
        logSystemEvent(`Error: ${error.message}`);
        appendMessage("Connection failed. Please check your API settings or backend server.", 'bot'); 
    }
}

// --- SETTINGS & TOOLS ---

function toggleSettings() {
    const panel = document.getElementById('settingsPanel');
    if (panel) panel.classList.toggle('active');
}

function saveConfig() {
    const urlInput = document.getElementById('apiUrlInput');
    const keyInput = document.getElementById('apiKeyInput');
    
    const url = urlInput.value.trim().replace(/\/$/, "");
    const key = keyInput.value.trim();
    
    // Salva mesmo se vazio (para limpar)
    config.apiUrl = url;
    config.apiKey = key;
    localStorage.setItem('api_endpoint', url);
    localStorage.setItem('google_api_key', key);
    
    toggleSettings();
    
    if (url || key) {
        updateStatus('READY');
        logSystemEvent("Credentials updated by user.");
        alert("Configuration Saved.");
    }
}

// --- REPORT MODE ---

function toggleSelectionMode() {
    document.body.classList.toggle('selection-mode');
    const chatBar = document.getElementById('chatInputBar');
    const selectBar = document.getElementById('selectionBar');
    
    if (document.body.classList.contains('selection-mode')) {
        chatBar.style.display = 'none';
        selectBar.style.display = 'flex';
    } else {
        chatBar.style.display = 'flex';
        selectBar.style.display = 'none';
        // Limpa seleções
        document.querySelectorAll('.msg-checkbox').forEach(cb => cb.checked = false);
    }
}

function selectAllMessages() {
    const cbs = document.querySelectorAll('.msg-checkbox');
    // Se todos marcados, desmarca. Se algum desmarcado, marca todos.
    const allChecked = Array.from(cbs).every(c => c.checked);
    cbs.forEach(c => c.checked = !allChecked);
}

function confirmDownload() {
    // 1. Pega mensagens visíveis selecionadas
    const selectedWrappers = document.querySelectorAll('.message-wrapper:has(.msg-checkbox:checked)');
    const targets = selectedWrappers.length > 0 ? selectedWrappers : document.querySelectorAll('.message-wrapper');

    if (targets.length === 0 && hiddenLogs.length === 0) {
        alert("Nothing to export.");
        return;
    }

    let visibleLogs = [];
    
    targets.forEach(wrapper => {
        const isBot = wrapper.classList.contains('bot');
        const textDiv = wrapper.querySelector('.msg-content');
        const text = textDiv ? textDiv.innerText : "";
        
        visibleLogs.push({
            timestamp: new Date().toLocaleString(), 
            sender: isBot ? 'AI ANALYST' : 'OPERATOR',
            text: text,
            visible: true
        });
    });

    // 2. Gera Relatório
    let reportContent = `ANALYSIS REPORT\nDate: ${new Date().toLocaleString()}\n`;
    reportContent += `Document: ${config.currentFile ? config.currentFile.name : 'None'}\n`;
    reportContent += "==================================================\n\n";

    // Seção 1: Conversa (Visíveis)
    reportContent += "[TRANSCRIPT]\n";
    visibleLogs.forEach(log => {
        reportContent += `[${log.timestamp}] ${log.sender}:\n${log.text}\n\n`;
    });

    // Seção 2: Auditoria de Sistema (Opcional - Interno)
    if (hiddenLogs.length > 0) {
        reportContent += "--------------------------------------------------\n";
        reportContent += "[SYSTEM AUDIT LOGS]\n";
        hiddenLogs.forEach(log => {
            reportContent += `[${log.timestamp}] ${log.text}\n`;
        });
    }

    // Download
    const blob = new Blob([reportContent], { type: 'text/plain' });
    const url = window.URL.createObjectURL(blob);
    const a = document.createElement('a');
    a.href = url;
    a.download = `Analysis_Report_${Date.now()}.txt`;
    a.click();
    window.URL.revokeObjectURL(url);
    
    toggleSelectionMode();
}

// --- THEME LOGIC ---

function loadThemePreference() {
    const savedTheme = localStorage.getItem('app_theme');
    if (savedTheme === 'dark' || (!savedTheme && window.matchMedia('(prefers-color-scheme: dark)').matches)) {
        applyTheme('dark');
    } else {
        applyTheme('light');
    }
}

function toggleTheme() {
    const html = document.documentElement;
    const current = html.getAttribute('data-theme');
    const next = current === 'dark' ? 'light' : 'dark';
    
    applyTheme(next);
    localStorage.setItem('app_theme', next);
}

function applyTheme(theme) {
    document.documentElement.setAttribute('data-theme', theme);
    
    const moon = document.getElementById('moonIcon');
    const sun = document.getElementById('sunIcon');
    
    if (!moon || !sun) return;

    if (theme === 'dark') {
        moon.style.display = 'none';
        sun.style.display = 'block';
    } else {
        moon.style.display = 'block';
        sun.style.display = 'none';
    }
}