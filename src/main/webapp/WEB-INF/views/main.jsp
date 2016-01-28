<%--
  Created by IntelliJ IDEA.
  User: RAYANT
  Date: 26.01.2016
  Time: 17:47
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Excel editor</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="/resources/css/bootstrap.css" rel="stylesheet">
</head>
<body>

<div class="container">
    <div class="row">
        <div class="col-md-4">
            <h2 align="center">Строка управления</h2>
            <input type="file" id="files" name="files[]" multiple accept="application/vnd.ms-excel"/>
            <h2 align="center">Загруженные файлы</h2>
            <br>
            <div id="control"></div>
        </div>
        <div class="col-md-8">
            <br>
            <div class="row" >
                <div class="col-xs-6">
                    <input class="form-control input-lg" id="title" type="text" value="Название таблицы">
                </div>
                <div class="col-xs-3">
                    <button type="button" id="save" class="btn btn-success btn-block btn-lg">Сохранить</button>
                </div>
                <div class="col-xs-3">
                    <button type="button" id="delete" class="btn btn-danger btn-block btn-lg">Удалить</button>
                </div>

            </div>
            <br>
            <div class="row">
                <div id="noContentAlert" class="modal fade">
                    <div class="modal-dialog">
                    <div class="modal-content alert alert-danger"><h2 align="center">Таблица пустая</h2></div>
                    </div>
                </div>
                <div id="saveAlert" class="modal fade">
                    <div class="modal-dialog">
                        <div class="modal-content alert alert-success"><h2 align="center">Таблица успешно сохранена</h2></div>
                    </div>
                </div>
                <div id="deleteAlert" class="modal fade">
                    <div class="modal-dialog">
                        <div class="modal-content alert alert-success"><h2 align="center">Таблица успешно удалена</h2></div>
                    </div>
                </div>
            </div>
            <table class="table table-bordered">
                <thead id="head"></thead>
                <tbody id="body"></tbody>
            </table>
        </div>
    </div>
</div>

</body>

<script src='/resources/js/xls.core.min.js'></script>
<script src="/resources/js/jquery.min.js"></script>
<script src="/resources/js/bootstrap.js"></script>
<script>
    var worksheet;
    var loadedTables;



    function handleFileSelect(evt) {
        var files = evt.target.files; // FileList object
        // files is a FileList of File objects. List some properties.
        var output = [];
        for (var i = 0, f; f = files[i]; i++) {
            output.push('<li><strong>', escape(f.name), '</strong> (', f.type || 'n/a', ') - ',
                    f.size, ' bytes, last modified: ',
                    f.lastModifiedDate.toLocaleDateString(), '</li>');

            var reader = new FileReader();
            var name = f.name;
            reader.onload = function (e) {
                var data = e.target.result;
                var value = '';
                var workbook = XLS.read(data, {type: 'binary'});
                var first_sheet_name = workbook.SheetNames[0];
                worksheet = workbook.Sheets[first_sheet_name];
                destroyTable();
                drowTable(worksheet);
                $('#delete').attr("name","");
                $('#save').attr("name","");
            };
            reader.readAsBinaryString(f);
        }
    }
    document.getElementById('files').addEventListener('change', handleFileSelect, false);

    $(document).ready(function (){
        downlodAndDrowLeftBar();
    });

    $('#delete').click(function(){
        if($('#head').html() === "" || $('#body').html() === ""){
            var popup = $('#noContentAlert');
            popup.modal("show");
            setTimeout(function(){
                popup.modal("hide");
            },1000);
            return;
        }
        var table = {};
        if(this.name!=="") {
            table.id = this.name;
        }else{
            destroyTable();
            $('#deleteAlert').show().fadeOut(1500);
            return;
        }
        table.name = $('#title').val();
        table.content = JSON.stringify(worksheet);
        $.ajax({
            type: "POST",
            url: "/delete",
            data: JSON.stringify(table),
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            statusCode: {
                200: function () {
                    downlodAndDrowLeftBar();
                    destroyTable();
                    var popup = $('#deleteAlert');
                    popup.modal("show");
                    setTimeout(function(){
                        popup.modal("hide");
                    },1000);
                }
            }
        });
    });

    $('#save').click(function(){
        if($('#head').html() === "" || $('#body').html() === ""){
            var popup = $('#noContentAlert');
            popup.modal("show");
            setTimeout(function(){
                popup.modal("hide");
            },1000);
            return;
        }
        var table = {};
        table.name = $('#title').val();
        table.content = JSON.stringify(worksheet);
        if(this.name!=="") table.id = this.name;
        $.ajax({
            type: "POST",
            url: "/save",
            data: JSON.stringify(table),
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            statusCode: {
                200: function () {
                    downlodAndDrowLeftBar();
                    var popup = $('#saveAlert');
                    popup.modal("show");
                    setTimeout(function(){
                        popup.modal("hide");
                    },1000);
                }
            }
        });
    });

    var destroyTable = function(){
        $('#title').val("Введите название таблицы");
        var head = $('#head').html("");
        var body = $('#body').html("");
    };

    var drowTable = function(table){
        var head = $('#head');
        var body = $('#body');
        var newHead = '<tr>';
        var newBody = '';
        var rowsCount = 0;
        var columnCount = 0;
        for (var i in table) {
            var row = 0;
            var column = 0;
            var columnIndex = "";
            for (var j = 0; j < i.length; j++) {
                // Code of A - 65, code of 9 - 57
                if (i.charCodeAt(j) > 64 && i.charCodeAt(j) < 91) {
                    columnIndex += i.charAt(j);
                } else if (i.charCodeAt(j) > 47 && i.charCodeAt(j) < 58) {
                    row += (i.charCodeAt(j) - 48) * Math.pow(10, i.length - j - 1);
                }
            }
            for (j = 0; j < columnIndex.length; j++) {
                column += (i.charCodeAt(j) - 64) * Math.pow(26, columnIndex.length - j - 1);
            }
            if (rowsCount < row)rowsCount = row;
            if (columnCount < column)columnCount = column;
        }

        for (i = 0; i < columnCount; i++) {
            var index = String.fromCharCode(65 + i) + 1;
            if (table[index] === undefined || table[index]["v"] === undefined) {
                value = '';
            } else {
                value = table[index]["v"];
            }

            newHead += '<th id="">' + value + '</th>';
        }
        for (j = 1; j < rowsCount; j++) {
            newBody += '<tr>';
            for (i = 0; i < columnCount; i++) {
                index = String.fromCharCode(65 + i) + (j + 1);
                if (table[index] === undefined || table[index]["v"] === undefined) {
                    value = '';
                } else {
                    value = table[index]["v"];
                }
                newBody += '<td id=""><input type="text" name="cell" class="form-control" id="' + index + '" value="' + value + '"></td>';
            }
            newBody += '</tr>';
        }

        newHead += '</tr>';
        head.html(newHead);
        body.html(newBody);
        $('input[name="cell"]').change(function () {
            if (worksheet[this.id] === undefined) {
                worksheet[this.id] = {"v": this.value};
            } else {
                worksheet[this.id]["v"] = this.value;
            }

        });
    };

    var downlodAndDrowLeftBar = function(){
        $.ajax({
            type: "POST",
            url: "/read/all",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (response) {
                loadedTables = response;
                var body="";
                for(var i in response){
                    body += ('<div><button type="button" name="'+i+'" class="btn btn-default btn-block loaded">');
                    body+= response[i].name;
                    body += '</button></div>';
                }
                $('#control').html("").append(body);
                $('.loaded').click(function(){
                    worksheet = JSON.parse(loadedTables[this.name].content);
                    destroyTable();
                    drowTable(JSON.parse(loadedTables[this.name].content));
                    $('#title').val(loadedTables[this.name].name);
                    $('#delete').attr("name",response[this.name].id);
                    $('#save').attr("name",response[this.name].id);
                })
            }
        });
    };

    var convertNuberToCharSequence = function (number) {
        var chars = recursionNumToCharSeq(number, []);
        var result = "";
        for (var k = 0; k < chars.length; k++) {
            result += String.fromCharCode(chars[k] + 64);
        }
        return result;
    };
    var recursionNumToCharSeq = function (num, chars) {
        var result = chars;
        if ((num - (num % 26)) / 26 > 0) {
            result.unshift(num % 26);
            num = (num - (num % 26)) / 26;
            recursionNumToCharSeq(num, result);
        } else {
            result.unshift(num % 26);
        }
        return result;
    };
</script>
</html>
