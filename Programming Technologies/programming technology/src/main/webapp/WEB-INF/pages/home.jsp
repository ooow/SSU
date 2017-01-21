<%@ page language="java" contentType="text/html; UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ru">
<head>
    <title>Top Films</title>
</head>
<body>
<h1 class="title">Top Films</h1>

<div class="mainHead">
    <form action="/search" method="get">
        <p><input type="text" id="title" name="title" placeholder="фильм">
            <input type="submit" value="Поиск фильма"/>
        </p>
    </form>
    <form action="/search" method="post">
        <p><input type="text" id="rating" name="rating" placeholder="от 1 до 10">
            <input type="submit" value="Поиск по рейтингу"/>
        </p>
    </form>
    <form action="/search" method="post">
        <c:if test="${isUp == 0}">
            <input type="hidden" id="isUp" name="isUp" value="1">
            <input type="hidden" name="rating" value="${oldrating}">
            <input type="submit" value="По убыванию рейтинга"/>
        </c:if>
    </form>
    <form action="/search" method="post">
        <c:if test="${isUp == 1}">
            <input type="hidden" id="isUp" name="isUp" value="0">
            <input type="hidden" name="rating" value="${oldrating}">
            <input type="submit" value="По возрастанию рейтинга"/>
        </c:if>
    </form>
    <p>${errorMessage}</p>
</div>

<c:forEach var="film" items="${topfilms}">
    <p>${film.get("rating")} <a href="${film.get("href")}">${film.get("name")}</a></p>
    <%-- <img src="${film.get("img")}">--%>
</c:forEach>

</body>
</html>