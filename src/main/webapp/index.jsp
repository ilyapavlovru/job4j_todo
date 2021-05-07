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

    <title>TODO список</title>
</head>
<body>

<script>

    $(document).ready(function () {
        $.ajax({
            type: 'GET',
            url: 'http://localhost:8080/todo/items',
            dataType: 'json'
        }).done(function (data) {
            for (let x = 0; x < data.length; x++) {
                let a = "place" + data[x].row + data[x].cell;
                document.getElementById(a).disabled = true;
            }
        }).fail(function (err) {
            alert(err);
        });
    });


    function validate() {
    }
</script>

<div class="container">
    <h2>Добавить новое задание</h2>

    <form action="/action_page.php">

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
            <table class="table table-bordered">
                <thead>
                <tr>
                    <th scope="col">Описание</th>
                    <th scope="col">Выполнено</th>

                </tr>
                </thead>
                <tbody>
                <tr>
                    <td>Bootstrap 4 CDN and Starter Template</td>
                    <td>
                        <div class="custom-control custom-checkbox">
                            <input type="checkbox" class="custom-control-input" id="customCheck1" checked>
                            <label class="custom-control-label" for="customCheck1"></label>
                        </div>
                    </td>

                </tr>
                <tr>
                    <td>Bootstrap Grid 4 Tutorial and Examples</td>
                    <td>
                        <div class="custom-control custom-checkbox">
                            <input type="checkbox" class="custom-control-input" id="customCheck2">
                            <label class="custom-control-label" for="customCheck2"></label>
                        </div>
                    </td>

                </tr>
                <tr>
                    <td>Bootstrap Flexbox Tutorial and Examples</td>
                    <td>
                        <div class="custom-control custom-checkbox">
                            <input type="checkbox" class="custom-control-input" id="customCheck3">
                            <label class="custom-control-label" for="customCheck3"></label>
                        </div>
                    </td>

                </tr>
                </tbody>
            </table>
        </div>
    </div>
</div>

</body>
</html>
