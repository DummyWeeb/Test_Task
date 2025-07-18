#!/bin/bash

PROCESS_NAME="test"
LOG_FILE="/var/log/monitoring.log"
MONITOR_URL="https://test.com/monitoring/test/api"
INTERVAL=60

write_log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') | $1" >> "$LOG_FILE"
}

last_pid=""

while true; do
    current_pid=$(pgrep -x "$PROCESS_NAME" | head -n1)

    # Проверка процесса и логирование перезапуска
    if [[ -n "$current_pid" ]]; then
        if [[ "$last_pid" != "$current_pid" ]]; then
            if [[ -n "$last_pid" ]]; then
                write_log "Внимание! Процесс '$PROCESS_NAME' перезапущен."
            fi
            last_pid=$current_pid
        fi
    else
        last_pid=""
    fi

    # Проверка мониторинг URL
    http_status=$(curl -s -o /dev/null -w "%{http_code}" --max-time 10 "$MONITOR_URL")

    if [[ "$http_status" -ne 200 ]]; then
        write_log "Ошибка доступа к серверу мониторинга! HTTP статус: $http_status."
    fi

    sleep "$INTERVAL"
done