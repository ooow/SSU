<%@ page language="java" contentType="text/html; UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ru">
<head>
    <title>Top Films</title>
</head>
<body>
<h1 class="title">Добро пожаловать на Топ Фильмы</h1>

<div class="addRole">
    <div class="add">
        <p class="title">Введите желаемы рейтинг фильмов</p>
        <form action="/search" method="post">
            <p><input type="text" id="rating" name="rating" placeholder="от 1 до 10"></p>
            <p><input type="submit" value="Вывести результаты"/></p>
        </form>
        <p class="title">${createRoleInfo}</p>
    </div>
</div>

<c:forEach var="film" items="${topfilms}">
    <p>${film.get("name")}</p>
    <img src="${film.get("img")}">
    <p>${film.get("rating")}</p>
</c:forEach>
<%--<div class="reportTable">
    <c:if test="${worktables != null}">
        <table class="reportTable" border="1px" style="border-color: black;">
            <tr>
                <pre><th>Year</th></pre>
                <pre><th> Month</th></pre>
                <pre><th> Day</th></pre>
                <pre><th> Start In</th></pre>
                <pre><th> End In</th></pre>
                <pre><th> Work</th></pre>
            </tr>
            <c:forEach var="worktabel" items="${worktables}">
                <tr>
                    <td>${worktabel.startTime.getYear()}</td>
                    <td>${worktabel.startTime.getMonthOfYear()}</td>
                    <td>${worktabel.startTime.getDayOfMonth()}</td>
                    <td> ${worktabel.startTime.getHourOfDay()} :
                            ${worktabel.startTime.getMinuteOfHour()} </td>
                    <td> ${worktabel.endTime.getHourOfDay()} :
                            ${worktabel.endTime.getMinuteOfHour()} </td>
                    <td>${worktabel.workTime.getHourOfDay()} :
                            ${worktabel.workTime.getMinuteOfHour()} :
                            ${worktabel.workTime.getSecondOfMinute()}
                    </td>
                </tr>
            </c:forEach>
        </table>
    </c:if>
</div>--%>

</body>
</html>