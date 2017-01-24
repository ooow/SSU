<%@ page language="java" contentType="text/html; UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ru">
<head>
    <title>Top Films</title>
</head>
<style>

    a {
        margin-left: 30px;
        color: white;
        text-decoration: none;
    }

    .rating {
        color: goldenrod;
        margin-left: 10px;
    }

    .form1 {
        margin: 10px;
    }

    h1 {
        color: white;
        font-family: Georgia;
        padding-top: 20px;
        padding-bottom: 20px;
    }

    body {
        background-color: black;
    }

    .mainHead {
        width: 50%;
        position: absolute;
        top: 0;
        right: 0;
        bottom: 0;
        left: 0;
        margin: auto;
    }

    .element {
        width: 40%;
        margin: auto;
    }

    .btn {
        background-color: black;
        color: white;
        border-radius: 32px;
        padding: 4px;
    }

    .submitt {
        margin-left: 25%;
        width: 48px;
        height: 48px;
        padding: 4px;
        border-radius: 32px;
        background-color: #000000;
        color: azure;
    }

    .input {
        background: black;
        color: white;
        border-radius: 32px;
        padding: 4px;
    }
</style>

<body>
<div class="mainHead">
    <h1 class="element">TOP FILMS</h1>
    <table>
        <tr>
            <td>
                <form class="form1" action="/search" method="get">
                    <p>
                        <input class="input" type="text" id="title" name="title" placeholder="фильм">
                        <input class="btn" type="submit" value="Поиск фильма"/>
                    </p>
                </form>
            </td>
            <td>
                <form class="form1" action="/search" method="post">
                    <p>
                        <input class="input" type="text" id="rating" name="rating" placeholder="от 1 до 10">
                        <input class="btn" type="submit" value="Поиск по рейтингу"/>
                    </p>
                </form>
            </td>
        </tr>
    </table>
    <form class="element" action="/search" method="post">
        <c:if test="${isUp == 0}">
            <input type="hidden" id="isUp" name="isUp" value="1">
            <input type="hidden" name="rating" value="${oldrating}">
            <input class="submitt" type="submit" value="↓"/>
        </c:if>
    </form>
    <form class="element" action="/search" method="post">
        <c:if test="${isUp == 1}">
            <input type="hidden" id="isUp" name="isUp" value="0">
            <input type="hidden" name="rating" value="${oldrating}">
            <input class="submitt" type="submit" value="↑">
        </c:if>
    </form>

    <p style="color: white">${errorMessage}</p>

    <c:forEach var="film" items="${topfilms}">
        <table>
            <tr>
                <td>
                    <div class="rating">${film.get("rating")} </div>
                </td>
                <td>
                    <a href="${film.get("href")}">${film.get("name")}</a>
                        <%-- <img src="${film.get("img")}">--%>
                </td>
            </tr>
        </table>
    </c:forEach>
</div>

</body>
</html>