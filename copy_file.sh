#!/usr/bin/env bash

totalSkipped=0
totalCopied=0
totalFiles=0
replaceAll=0
skipAll=0

file_found() {
  if [[ $replaceAll == 0 && $skipAll == 0 ]]; then
    echo "Найдено слияние между $1 и $2/$3"
    echo "Хотите заменить файл?"
    echo "1. Заменить"
    echo "2. Заменить для всех"
    echo "3. Пропустить"
    echo "4. Пропустить для всех"
    echo -n "Ввод: "
    while true; do
      read -r variant
      case "$variant" in
        1) file_copy "$1" "$2"
          break;;
        2) replaceAll=$((replaceAll=1))
         break;;
        3) totalSkipped=$((totalSkipped+1))
          break;;
        4) skipAll=$((skipAll=1))
          break;;
        *) echo "Некорректный ввод. Попробуйте ещё раз!"
          file_found "$1" "$2"
          break;;
      esac
    done
  fi
  if [[ $replaceAll == "1" ]]; then
    file_copy "$1" "$2"
  else
    totalSkipped=$((totalSkipped+1))
  fi
}
file_copy() {
  if cp "$1" -r "$2"/ &>/dev/null; then
    echo "Копирование: $1 в $2"
    totalCopied=$((totalCopied+1))
  else
    echo "При копировании $1 в $2 произошла ошибка!"
    exit 1
  fi
}
copy_files() {
  for FILE in "$1"/*; do
    totalFiles=$((totalFiles+1))
    if state=$(find "$2" -name "${FILE##*/}"); then
      if [[ $state != "" ]]; then
        file_found "$FILE" "$2" "${FILE##*/}"
      else file_copy "$FILE" "$2"
      fi
    else
      echo "Произошла ошибка при поиске файлов"
      exit 1
    fi
  done
  echo "Копирование $1 в $2 завершено!"
  echo "Итого всего файлов: $totalFiles | заменено: $totalCopied | пропущено: $totalSkipped"
}
process() {
  if find "$1" &>/dev/null && find "$2" &>/dev/null; then
    copy_files "$1" "$2"
  else echo "В указанных путях содержится ошибка (некорректный путь)"
  fi
}
main() {
  if [[ $# != 2 ]]; then
    echo "Используйте: $0 [Исходный каталог] [Конечный каталог]"
    else process "$1" "$2"
  fi
}
main "$@"
