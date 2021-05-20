[![Build Status](https://travis-ci.org/ilyapavlovru/job4j_todo.svg?branch=master)](https://travis-ci.org/ilyapavlovru/job4j_todo)
[![codecov](https://codecov.io/gh/ilyapavlovru/job4j_todo/branch/master/graph/badge.svg)](https://codecov.io/gh/ilyapavlovru/job4j_todo)

Проект "TODO список"
=====================

Проект для изучения Java EE.

Данное приложение - список дел.

Используемые технологии:
* Java 12
* Java EE Servlets
* Tomcat
* PostgresSQL, Hibernate
* Maven
* HTML, JavaScript, Bootstrap, JSON

Приложение имеет одну страницу со списком дел index.html.
Вверху страницы форма для добавления нового задания. 
Список всех категорий загружается на форму добавления нового задания, при этом для задания можно выбрать несколько категорий.
Если дело сделано, то его отмечают, как выполненное и оно исчезает из списка.

Регистрация пользователя
![ScreenShot](images/2021-05-20_111837.png)

Авторизация пользователя
![ScreenShot](images/2021-05-20_113014.png)

Добавление нового задания
![ScreenShot](images/2021-05-20_112339.png)

Список всех заданий
![ScreenShot](images/2021-05-20_112404.png)

Отмечая задания галочками, они исчезают из списка
![ScreenShot](images/2021-05-20_112433.png)

Список всех заданий, включая выполненные, можно увидеть установив галочку "Показать все задания"
![ScreenShot](images/2021-05-20_112455.png)
