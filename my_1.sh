#!/bin/bash
echo "Адрес лог файла:" 
path="$( cd "$(dirname "$0")" ; pwd -P )"
f="/logfile"
log="$path$f"
echo "Тестовый скрипт"
echo "---------------"
echo "Список команд:"
echo "1 - Создать каталог+"
echo "2 - Сменить текущий каталог+"
echo "3 - Напечатать содержимое текущего каталога+"
echo "4 - Напечатать текущий каталог+"
echo "5 - Создать файл+"
echo "6 - Удалить файл"
echo "7 - Выйти из программы"
echo "Введите номер команды"
read Function
case $Function in
	1)
		clear;
		echo "Введите имя каталога";
		read name;
		mkdir $name 2>> $log;
			if [[ "$?" != "0" ]]; then
				tail -n 1 -q $log;
			fi
		. $0;;	
	2)
		clear;
		echo "Введите путь до необходимого каталога";
		read path;
			cd $path 2>> $log;
			if [[ "$?" != "0" ]]; then
				tail -n 1 -q $log;
			fi
			. $0;;
	3)	
		clear;
		echo "Список файлов в текущем каталоге:";
		echo "------------";
		ls;
		echo "------------";
		. $0;;

	4)
		clear;
		echo "------------";
		echo "Текущий каталог: $PWD";
		echo "------------";
		. $0;;
	5)	
		clear;
		echo "Введите имя файла";
		read name;
		touch $name 2>> $log;
		if [[ "$?" != "0" ]]; then
				tail -n 1 -q $log;
		else
			ls;
		fi
		. $0;;
	6)  
		clear;
		echo "Что удаляем: file / directory ?"
		read ff;
		case $ff in
			file)
				echo "Список файлов:";
				ls;
				echo "";
				echo "Введите имя файла";
				read name;
				echo "Вы уверены? y/n";
				read ans;
				case $ans in
					y)
						rm $name 2>> $log;
						if [[ "$?" != "0" ]]; then
							tail -n 1 -q $log;
						fi
						ls;;
					n)
						echo "Ничего не удаляем)";
						ls;;
				esac;
				. $0;;
			directory)
				echo "Список директорий (только их, без файлов!!!):";
				ls -d */;
				echo "";
				echo "Введите имя директории";
				read name;
				echo "Вы уверены, что хотите удалить директорию и все вложенные в нее файлы???? y/n";
				read ans;
				case $ans in
					y)
						rm -r -f $name 2>> $log;
						if [[ "$?" != "0" ]]; then
							tail -n 1 -q $log;
						fi
						ls;;
					n)
						echo "Ничего не удаляем)";
						ls;;
				esac;
				. $0;;
		esac;;
	7) 
		clear;
		exit;;

esac
