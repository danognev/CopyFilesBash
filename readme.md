# Bash скрипт для копирования одной директории в другую
### Обучающее задание в рамках it школы НТЦ Протей

Цель скрипта: копировать файлы и каталоги одной директории в другую

Возможности:
 1) Вывод подсказки при несоответствии количества аргументов при запуске скрипта;
 2) Проверка введеных директорий;
 3) Проверка наличия файлов в конечной директории;
 4) В случае возникновения слияния (если файл найден с таким же именем) пользователю выводится меню с предложением:
    * Перезаписать файл;
    * Перезаписывать все файлы;
    * Пропустить;
    * Пропустить все файлы;
 5) В случае успешного завершения копирования - будет выведено сообщение со статистикой (сколько всего файлов, сколько заменено, сколько пропущено);
 6) В случае возникновения ошибок - отправляется сообщение;

 В скрипте основные используемые команды: cp (копирование), find (поиск)