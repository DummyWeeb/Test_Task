# Test_Task
Выполнение тестового задания 
Написать скрипт на bash для мониторинга процесса test в среде linux.
Скрипт должен отвечать следующим требованиям:
1 Запускаться при запуске системы (предпочтительно написать юнит
systemd в дополнение к скрипту)
2 Отрабатывать каждую минуту
3 Если процесс запущен, то стучаться(по https) на
https://test.com/monitoring/test/api
4 Если процесс был перезапущен, писать в лог /var/log/monitoring.log
(если процесс не запущен, то ничего не делать)
5 Если сервер мониторинга не доступен, так же писать в лог.

Инструкция по установке и запуску скрипта checktest.sh с systemd
1 Скопируйте скрипт checktest.sh в директорию /home
2 Дайте скрипту права на исполнение:
  sudo chmod +x /home/checktest.sh
3 Скопируйте unit-файл checktest.service в каталог /etc/systemd/system/
4 Создайте файл лога /var/log/monitoring.log
  sudo touch /var/log/monitoring.log
5 Установите владельца и права, чтобы сервис мог записывать в лог
  sudo chown root:root /var/log/monitoring.log (Если скрипт запускается под другим пользователем, поменяйте владельца на него.)
  sudo chmod 644 /var/log/monitoring.log
6 Перезагрузите конфигурацию systemd после добавления нового сервиса
  sudo systemctl daemon-reload
7 Включите автозапуск сервиса при загрузке
  sudo systemctl enable checktest.service
8 Перезагрузите компьютер для проверки запуска скрипта после старта системы
  sudo systemctl status checktest.service
9 скопируйте файл test в директорию /home
10 Предоставьте права на испольнение для файла test
  sudo chmod +x /home/test
11 Запустите процесс test
  sudo systemctl start test
12 Для проверки работы скрипта checktest, перезагрузите процесс test
  sudo systemctl restart test
13 Просмотр логов, куда скрипт пишет сообщения
  sudo tail -f /var/log/monitoring.log


  
