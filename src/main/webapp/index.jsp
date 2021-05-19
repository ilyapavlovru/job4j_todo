<%@ page contentType="text/html; charset=UTF-8" %>

<!doctype html>
<html lang="en">
<head>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <link type="text/css" rel="stylesheet" href="styles.css"/>

    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css"
          integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
    <script src="https://code.jquery.com/jquery-3.4.1.slim.min.js"
            integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"
            integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"
            integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>

    <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>

    <title>TODO список</title>
</head>
<body>

<div class="container">
    <div class="row">
        <ul class="nav">
            <li class="nav-item">
                <a class="nav-link" href="<%=request.getContextPath()%>/login.jsp">Войти</a>
            </li>
        </ul>
    </div>
    <hr align="left" size="5">
</div>



<script>

    let allLoadedItems;

    $(document).ready(function () {
        loadItemsFromDB();
    });

    function loadItemsFromDB() {
        $.ajax({
            type: 'GET',
            url: 'http://localhost:8080/todo/items.do',
            dataType: 'json'
        }).done(function (data) {
            allLoadedItems = data;
            fillItemsTable();
        })
    }

    function validate() {
        const description = $('#description').val();
        if (description === "") {
            alert("Укажите описание задания");
            return false;
        }
    }

    function addAllItemsToTable() {
        for (let x = 0; x < allLoadedItems.length; x++) {
            var checkBoxValue = allLoadedItems[x].done ? ' checked="checked"' : '';
            $('#table tr:last').after(
                '<tr>' +
                '<td>' + allLoadedItems[x].description + '</td>' +
                '<td>' + allLoadedItems[x].userName + '</td>' +
                '<td><div class="custom-control custom-checkbox">' +
                '<input type="checkbox"' + checkBoxValue + ' class="custom-control-input" id="customCheck' +
                allLoadedItems[x].id + '"' + allLoadedItems[x].done + ' onclick="return checkBoxSelected(this)">' +
                '<label class="custom-control-label" for="customCheck' + allLoadedItems[x].id + '"></label></div>' +
                '</td>' +
                '</tr>');
        }
    }

    function addNotDoneItemsToTable() {
        for (let x = 0; x < allLoadedItems.length; x++) {
            if (allLoadedItems[x].done === false) {
                $('#table tr:last').after(
                    '<tr>' +
                    '<td>' + allLoadedItems[x].description + '</td>' +
                    '<td>' + allLoadedItems[x].userName + '</td>' +
                    '<td><div class="custom-control custom-checkbox">' +
                    '<input type="checkbox" class="custom-control-input" id="customCheck' + allLoadedItems[x].id + '"' +
                    allLoadedItems[x].done + ' onclick="return checkBoxSelected(this)">' +
                    '<label class="custom-control-label" for="customCheck' + allLoadedItems[x].id + '"></label></div>' +
                    '</td>' +
                    '</tr>');
            }
        }
    }

    function isShowAllTasksCheckBoxChecked() {
        return !!document.getElementById('showAllTasks').checked;
    }

    function fillItemsTable() {
        clearTable();
        if (isShowAllTasksCheckBoxChecked()) {
            addAllItemsToTable();
        } else {
            addNotDoneItemsToTable();
        }
    }

    function clearTable() {
        const tableHeaderRowCount = 1;
        const table = document.getElementById('table');
        const rowCount = table.rows.length;
        for (let i = tableHeaderRowCount; i < rowCount; i++) {
            table.deleteRow(tableHeaderRowCount);
        }
    }

    function checkBoxSelected(me) {
        const itemId = me.id.substring(11);
        $.ajax({
            url: 'http://localhost:8080/todo/items.do',
            type: 'POST',
            data: {itemId: itemId},
        }).done(function () {
            loadItemsFromDB();
        }).fail(function (err) {
            alert(err);
        });
    }
</script>

<div class="container pt-1">
    <div class="row">
        <div class="card" style="width: 100%">
            <div class="card-header" style="font-weight: bold; font-size: larger">
                Форма для создания задания
            </div>
            <div class="card-body">
                <form action="<%=request.getContextPath()%>/items.do" method="post">
                    <div class="form-group row">
                        <label class="col-form-label col-sm-3" for="description" style="font-weight: 900">Описание</label>
                        <div class="col-sm-5">
                            <input type="text" class="form-control" id="description" placeholder="Введите описание" name="description">
                        </div>
                    </div>
                    <div class="form-group row">
                        <label class="col-form-label col-sm-3" for="cIds" style="font-weight: 900">Выбор категорий</label>
                        <div class="col-sm-5">
                            <select class="form-control" name="cIds" id="cIds" multiple>
                                <c:forEach items="${allCities}" var="city">
                                    <option value=<c:out value="${city.id}"/>><c:out value="${city.name}"/></option>
                                </c:forEach>
                            </select>
                        </div>
                    </div>
                    <input type="hidden" name="action" value="add"/>
                    <div class="form-group row">
                        <label class="col-form-label col-sm-3" style="font-weight: 900"></label>
                        <div class="col-sm-5">
                            <button type="submit" class="btn btn-success" onclick="return validate()">Добавить</button>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<%--<div class="container">--%>
<%--    <h2>Добавить новое задание</h2>--%>
<%--    <form action="<%=request.getContextPath()%>/items.do" method="post">--%>
<%--        <div class="form-group">--%>
<%--            <label for="description1">Описание:</label>--%>
<%--            <input type="text" class="form-control" id="description1" placeholder="Введите описание" name="description">--%>
<%--        </div>--%>
<%--        <input type="hidden" name="action" value="add"/>--%>
<%--        <button type="submit" class="btn btn-success" onclick="return validate()">Добавить</button>--%>
<%--    </form>--%>
<%--</div>--%>

<div class="container">
    <h2>Список заданий</h2>
    <div class="form-check">
        <input type="checkbox" class="form-check-input" id="showAllTasks" onclick="fillItemsTable();">
        <label class="form-check-label" for="showAllTasks">Показать все задания</label>
    </div>
    <div class="row">
        <div class="col-12">
            <table class="table table-bordered" id='table'>
                <thead>
                <tr>
                    <th scope="col">Описание</th>
                    <th scope="col">Автор</th>
                    <th scope="col">Выполнено</th>
                </tr>
                </thead>
                <tbody id="todoListTable">
                </tbody>
            </table>
        </div>
    </div>
</div>
</body>
</html>
