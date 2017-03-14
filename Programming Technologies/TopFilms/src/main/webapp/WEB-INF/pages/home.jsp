<%@ page language="java" contentType="text/html; UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ru">
<head>
    <title>Top Films</title>

    <script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.8.2/jquery.min.js"></script>
    <script src="https://code.highcharts.com/highcharts.js"></script>
    <script src="https://code.highcharts.com/modules/exporting.js"></script>
</head>
<style>

    a {
        margin-left: 30px;
        color: #000000;
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
        color: #000000;
        font-family: Georgia;
        padding-top: 20px;
        padding-bottom: 20px;
    }

    body {
        background-color: white;
    }

    .element {
        width: 20%;
        margin: auto;
    }

    .btn {
        margin-left: 12px;
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
            <td>
                <form class="form1" action="/search-by-year" method="get">
                    <p>
                        <input class="input" type="text" id="year" name="year" placeholder="2016">
                        <input class="btn" type="submit" value="Поиск по году"/>
                    </p>
                </form>
            </td>
            <td>
                <form class="form1" action="/graph" method="get">
                    <p>
                        <input class="input" type="text" id="syear" name="syear" placeholder="2000">
                        <input class="input" type="text" id="eyear" name="eyear" placeholder="2016">
                        <input class="btn" type="submit" value="Построить график"/>
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

    <div class="error"><p style="color: black">${errorMessage}</p></div>
    <div class="films">
        <c:forEach var="film" items="${topfilms}">
            <table>
                <tr>
                    <td>
                        <div class="rating">${film.get("rating")} </div>
                    </td>
                    <td>
                        <a href="${film.get("href")}">${film.get("name")}</a>
                            <%--<img src="${film.get("img")}">--%>
                    </td>
                </tr>
            </table>
        </c:forEach>
    </div>
</div>

<c:if test="${showGraph == 1}">
    <div id="container" style="min-width: 310px; height: 400px; margin: 0 auto"></div>
</c:if>

<script type="text/javascript">
    $(function () {
        Highcharts.chart('container', {
            chart: {
                type: 'column'
            },
            title: {
                text: 'Films Chart'
            },
            xAxis: {
                categories: [${xAxis}]
            },
            yAxis: {
                min: 0,
                title: {
                    text: 'Count'
                },
                stackLabels: {
                    enabled: true,
                    style: {
                        fontWeight: 'bold',
                        color: (Highcharts.theme && Highcharts.theme.textColor) || 'gray'
                    }
                }
            },
            legend: {
                align: 'right',
                x: -30,
                verticalAlign: 'top',
                y: 25,
                floating: true,
                backgroundColor: (Highcharts.theme && Highcharts.theme.background2) || 'white',
                borderColor: '#CCC',
                borderWidth: 1,
                shadow: false
            },
            tooltip: {
                headerFormat: '<b>{point.x}</b><br/>',
                pointFormat: '{series.name}: {point.y}<br/>Total: {point.stackTotal}'
            },
            plotOptions: {
                column: {
                    stacking: 'normal',
                    dataLabels: {
                        enabled: true,
                        color: (Highcharts.theme && Highcharts.theme.dataLabelsColor) || 'white'
                    }
                }
            },
            series: [{
                name: '9-10',
                data: [${data10}]
            }, {
                name: '8-9',
                data: [${data9}]
            }, {
                name: '7-8',
                data: [${data8}]
            }, {
                name: '6-7',
                data: [${data7}]
            }, {
                name: '5-6',
                data: [${data6}]
            }, {
                name: '4-5',
                data: [${data5}]
            }, {
                name: '3-4',
                data: [${data4}]
            }, {
                name: '2-3',
                data: [${data3}]
            }, {
                name: '1-2',
                data: [${data2}]
            }, {
                name: '0-1',
                data: [${data1}]
            }]
        });
    });
</script>

</body>
</html>