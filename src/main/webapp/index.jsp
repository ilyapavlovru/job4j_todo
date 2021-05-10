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

<script>

    $(document).ready(function () {
        $.ajax({
            type: 'GET',
            url: 'http://localhost:8080/todo/items.do',
            dataType: 'json'
        }).done(function (data) {

            console.log(data)

            for (let x = 0; x < data.length; x++) {

                console.log('id =' + data[x].id);
                console.log('description = ' + data[x].description);
                console.log('created = ' + data[x].created);
                console.log('done = ' + data[x].done);

                $('#table tr:last').after(
                    '<tr>' +

                    '<td>' + data[x].description +'</td>' +

                    '<td><div class="custom-control custom-checkbox">' +
                    '<input type="checkbox" class="custom-control-input" id="customCheck' + data[x].id + '"' + data[x].done + '>' +
                    '<label class="custom-control-label" for="customCheck' + data[x].id + '"></label></div>' +
                    '</td>' +

                    '</tr>');

            }
        }).fail(function (err) {
            alert(err);
        });
    });

    function validate() {
        const description = $('#description').val();
        if (description === "") {
            alert("Укажите описание задания");
            return false;
        }
    }
</script>

<div class="container">
    <h2>Добавить новое задание</h2>

    <form action="<%=request.getContextPath()%>/items.do" method="post">

        <div class="form-group">
            <label for="description">Описание:</label>
            <input type="text" class="form-control" id="description" placeholder="Введите описание" name="description">
        </div>
        <button type="submit" class="btn btn-success" onclick="return validate()">Добавить</button>
    </form>

</div>


<div class="container">

    <div class="form-check">
        <input type="checkbox" class="form-check-input" id="showAllTasks">
        <label class="form-check-label" for="showAllTasks">Показать все задания</label>
    </div>

    <div class="row">
        <div class="col-12">
            <table class="table table-bordered" id='table'>
                <thead>
                <tr>
                    <th scope="col">Описание</th>
                    <th scope="col">Выполнено</th>

                </tr>
                </thead>
                <tbody>

                </tbody>
            </table>
        </div>
    </div>
</div>

</body>
</html>
