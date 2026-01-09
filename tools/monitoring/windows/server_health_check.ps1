<#
.SYNOPSIS
    Server Health Check - Industrial Edition
.DESCRIPTION
    Ferramenta unificada para diagnóstico rápido de servidores SCADA/OT.
    Verifica: Portas Críticas (Modbus/S7), Processos Pesados, Segurança e Logs recentes.
.AUTHOR
    engcontrol-alv
.VERSION
    1.0
#>

Clear-Host
Write-Host "==========================================================" -ForegroundColor Cyan
Write-Host "   INDUSTRIAL SERVER HEALTH CHECK v1.0" -ForegroundColor Cyan
Write-Host "   Diagnóstico Iniciado em: $(Get-Date)" -ForegroundColor DarkGray
Write-Host "==========================================================" -ForegroundColor Cyan
Write-Host ""

# --- 1. VERIFICAÇÃO DE PORTAS CRÍTICAS (Conectividade SCADA) ---
Write-Host "[1] VERIFICANDO PORTAS INDUSTRIAIS..." -ForegroundColor Yellow
$portas = @(80, 443, 502, 102) # 502=Modbus, 102=Siemens, 80/443=Web
foreach ($p in $portas) {
    # Tenta conectar (simulação rápida). Se a porta estiver aberta localmente, daria True.
    # Em um cenário real, testaríamos contra um PLC. Aqui testamos se o servidor escuta.
    $status = Get-NetTCPConnection -LocalPort $p -ErrorAction SilentlyContinue
    if ($status) {
        Write-Host "    [OK] Porta $p está ABERTA (Ouvindo)" -ForegroundColor Green
    } else {
        Write-Host "    [--] Porta $p não detectada ou fechada" -ForegroundColor Gray
    }
}
Write-Host ""

# --- 2. MONITORAMENTO DE PROCESSOS (Performance) ---
Write-Host "[2] PROCESSOS DE ALTO CONSUMO (Top 5 CPU)..." -ForegroundColor Yellow
$processos = Get-Process | Sort-Object CPU -Descending | Select-Object -First 5
foreach ($proc in $processos) {
    if ($proc.CPU -gt 100) { # Apenas um threshold de exemplo
        Write-Host "    [ALERTA] $($proc.Name) - CPU: $($proc.CPU)" -ForegroundColor Red
    } else {
        Write-Host "    [OK] $($proc.Name) - CPU: $($proc.CPU)" -ForegroundColor Green
    }
}
Write-Host ""

# --- 3. POLÍTICAS DE SEGURANÇA (Compliance) ---
Write-Host "[3] STATUS DE SEGURANÇA (Windows Defender)..." -ForegroundColor Yellow
$defender = Get-MpComputerStatus | Select-Object AntivirusEnabled, RealTimeProtectionEnabled
if ($defender.AntivirusEnabled -and $defender.RealTimeProtectionEnabled) {
    Write-Host "    [SEGURO] Antivírus e Proteção em Tempo Real: ATIVOS" -ForegroundColor Green
} else {
    Write-Host "    [PERIGO] Proteção do Windows está DESATIVADA!" -ForegroundColor Red
}
Write-Host ""

# --- 4. ATIVIDADES DE LOGON (Auditoria - Últimos 3 logins) ---
Write-Host "[4] ÚLTIMOS LOGONS (Auditoria)..." -ForegroundColor Yellow
# O Event ID 4624 é "Logon com êxito" no Windows Security Log
try {
    $logs = Get-EventLog -LogName Security -InstanceId 4624 -Newest 3 -ErrorAction Stop
    foreach ($log in $logs) {
        Write-Host "    User: $($log.ReplacementStrings[5]) | Data: $($log.TimeGenerated)" -ForegroundColor Cyan
    }
} catch {
    Write-Host "    [INFO] Não foi possível ler logs de segurança (Requer Admin)" -ForegroundColor DarkGray
}

Write-Host ""
Write-Host "==========================================================" -ForegroundColor Cyan
Write-Host "   DIAGNÓSTICO CONCLUÍDO." -ForegroundColor Cyan
Write-Host "==========================================================" -ForegroundColor Cyan