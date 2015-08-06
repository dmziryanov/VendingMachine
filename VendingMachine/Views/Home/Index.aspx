<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "htopTablep://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="htopTablep://www.w3.org/1999/xhtml">
       

<head runat="server">
        <link type="text/css" href="../../Content/jquery-ui-1.8.12.custom.css" rel="stylesheet" />
        <script type="text/javascript" src="../../Scripts/jquery-1.8.3.min.js"></script>
		<script type="text/javascript" src="../../Scripts/jquery-ui.min.js"></script>
        <script type="text/javascript" src="../../Scripts/javascript_security.js"></script>
        <script type="text/javascript" src="../../Scripts/knockout-3.1.0.js"></script>
    <title>Index</title>
    <style type="text/css">
        /*demo page css*/
        body {
            font: 62.5% "Trebuchet MS", sans-serif;
            margin: 50px;
        }

        .demoHeaders {
            margin-top: 2em;
        }

        #enter_link {
            padding: .4em 1em .4em 20px;
            text-decoration: none;
            position: relative;
        }

            #enter_link span.ui-icon {
                margin: 0 5px 0 0;
                position: absolute;
                left: .2em;
                top: 50%;
                margin-top: -8px;
            }

        #reg_link {
            padding: .4em 1em .4em 20px;
            text-decoration: none;
            position: relative;
        }

            #reg_link span.ui-icon {
                margin: 0 5px 0 0;
                position: absolute;
                left: .2em;
                top: 50%;
                margin-top: -8px;
            }

        #exit {
            padding: .4em 1em .4em 20px;
            text-decoration: none;
            position: relative;
        }

            #exit span.ui-icon {
                margin: 0 5px 0 0;
                position: absolute;
                left: .2em;
                top: 50%;
                margin-top: -8px;
            }

        #gotoVM {
            padding: .4em 1em .4em 20px;
            text-decoration: none;
            position: relative;
        }

            #gotoVM span.ui-icon {
                margin: 0 5px 0 0;
                position: absolute;
                left: .2em;
                top: 50%;
                margin-top: -8px;
            }

        #save {
            padding: .4em 1em .4em 20px;
            text-decoration: none;
            position: relative;
        }

            #save span.ui-icon {
                margin: 0 5px 0 0;
                position: absolute;
                left: .2em;
                top: 50%;
                margin-top: -8px;
            }

        ul#icons {
            margin: 0;
            padding: 0;
        }

            ul#icons li {
                margin: 2px;
                position: relative;
                padding: 4px 0;
                cursor: pointer;
                float: left;
                list-style: none;
            }

            ul#icons span.ui-icon {
                float: left;
                margin: 0 4px;
            }
    </style>	
</head>
<body>
    <div>
    <script type="text/javascript">
        function GetRes(res) {
            var isAuth = res;
            if (isAuth != null && isAuth === "True") {
                $('#authblock').hide();
                $('#topTable').show();
                $('#Password1').val('');
                $('#Password2').val('');
                $('#pass').val('');
                pendingRequests();
            }
            else {
                $('#authblock').show();
                $('#topTable').hide();
                $('#Password1').val('');
                $('#Password2').val('');
                $('#pass').val('');
            }
        }

        function update() {
            if ($("#Password3").val() !== $("#Password4").val()) { alert("Пароли не совпадают"); return; };
            ResultViewModel.password = hex_md5($("#Password3").val());
            var jsonData = ko.toJSON(ResultViewModel);
            $.ajax({
                type: "GET",
                datatype: "json",
                url: "/Home/Update",
                data: jsonData
            });
        }

        function refreshView() {
            $.ajax({
                type: "GET",
                url: "/Home/IsAuthenticated",
                success: GetRes,
                error: function () { alert('нет связи с сервером'); }
            });
        }

        $(document).ready(function () {
            refreshView();

            ResultViewModel = {
                login: ko.observable("login"),
                password: ko.observable("password"),
                email: ko.observable("email"),
                age: ko.observable("12")
            };

            ko.applyBindings(ResultViewModel);
        });


        $(function () {
            // Dialog Link
            $('#enter_link').click(function () {
                $('#enter_dialog').dialog('open');
                return false;
            });

            $('#reg_link').click(function () {
                $('#reg_dialog').dialog("open");
                return false;
            });

            $('#tabs').tabs();

            $('#exit').click(function () {
                $.ajax({
                    type: "GET",
                    url: "/Home/Exit",
                    success: refreshView
                });

            });

            $('#gotoVM').click(function () {
                location = 'VM/MainScreen';
            });

            $('#enter_dialog').dialog({
                autoOpen: false,
                width: 600,
                buttons: {
                    "Ok": function () {
                        $.ajax({
                            type: "GET",
                            url: "/Home/Login",
                            data: "login=" + $('#login').val() + "&pass=" + hex_md5($('#pass').val()),
                            success: refreshView
                        });

                        $(this).dialog("close");
                    },
                    "Cancel": function () {
                        $(this).dialog("close");
                    }
                }
            });

            $('#reg_dialog').dialog({
                autoOpen: false,
                width: 600,
                buttons: {
                    "Ok": function () {
                        if ($("#Password1").val() === $("#Password2").val()) {
                            $.ajax({
                                type: "GET",
                                url: "/Home/Register",
                                data: "login=" + $('#Text1').val() + "&pass=" + hex_md5($('#Password1').val()),
                                success: function (data) {
                                    refreshView();
                                    if (data === "True")
                                        alert('Вы успешно зарегистрированы');
                                }
                            });

                            $(this).dialog("close");
                        }
                        else {
                            alert('пароли не совпадают');
                        }
                    },
                    "Cancel": function () {
                        $(this).dialog("close");
                    }
                }
            });
        });
    </script>
    </div >
      <div id="authblock" style= "display:none; white-space: nowrap;"  >
You are not logged in

<a id="enter_link" class="ui-state-default ui-corner-all ui-state-hover" href="#">
<span class="ui-icon ui-icon-newwin"></span>
log in
</a>
&nbsp or
<a id="reg_link" class="ui-state-default ui-corner-all ui-state-hover" href="#">
<span class="ui-icon ui-icon-newwin"></span>
register
</a>
</div>

<div id="topTable" style= "display:table-caption; white-space: nowrap;">
<div style="margin-bottom: 20px;" >
You may 
<a id="exit" class="ui-state-default ui-corner-all ui-state-hover"  href="#">
<span class="ui-icon ui-icon-newwin"></span>
 exit
</a>
edit your personal data or go to 
<a id="gotoVM" class="ui-state-default ui-corner-all ui-state-hover"  href="#">
    <span class="ui-icon ui-icon-newwin">
    </span>
    Vending Machine
</a>
</div>
<br/>

<div id="tabs" class="ui-tabs ui-widget ui-widget-content ui-corner-all">
<ul class="ui-tabs-nav ui-helper-reset ui-helper-clearfix ui-widget-header ui-corner-all">
<li class="ui-state-default ui-corner-top ui-tabs-selected ui-state-active">
<a href="#tabs-1">login data</a>
</li>
<li class="ui-state-default ui-corner-top ui-tabs-selected ui-state-active">
    <a href="#tabs-2">personal data</a>
</li>
<%--<li class="ui-state-default ui-corner-top ui-tabs-selected ui-state-active">
    <a href="#tabs-3">images</a>
</li>--%>
</ul>

<div id="tabs-1" class="ui-tabs-panel ui-widget-content ui-corner-bottom">   
    login name<input type="text" id="RegisterLogin"  style="border-style:none; margin-bottom: 4px" data-bind="value: login" /> <br/>
    password <input type="password" id="Password3" style="border-style:none;  margin-bottom: 4px" data-bind="value: password" /> <br/>
    same password again <input type="password" id="Password4" style="border-style:none" data-bind="value: password"  />
</div>
<div id="tabs-2" class="ui-tabs-panel ui-widget-content ui-corner-bottom ui-tabs-hide">   
    E-mail: <input type="text" id="RegisterEmail" data-bind="value: email"  style="border-style:none; margin-bottom: 4px" /> <br/>
    age: <input type="text" id="RegisterAge"  data-bind="value: age" style="border-style:none; margin-bottom: 4px" /> <br/>
</div>
<div id="tabs-3" class="ui-tabs-panel ui-widget-content ui-corner-bottom ui-tabs-hide">   
    <label for="file">Upload Image:</label> 
    <input type="file" id="FileUpload" multiple />
    <input type="button" id="Upload" value="Upload" />
</div>        

       <%-- <pre data-bind="text: ko.toJSON($root, null, 2)"></pre>--%>
</div>
    <br/>


<a id="save" class="ui-state-default ui-corner-all ui-state-hover"  onclick="update();" href="#">
<span class="ui-icon ui-icon-disk"></span>Save
</a>
</div>

    <div id="enter_dialog" title="Enter please">
        <p>login <input type="text" id="login" style="border-style: none; margin-bottom: 4px"/> <br/>
               password <input type="password" id="pass" style="border-style:none"  />
             </p>
		</div>

    <div id="reg_dialog" title="Registration">
        login <input type="text" id="Text1" style="border-style: none; margin-bottom: 4px"/> <br/>
        password <input type="password" id="Password1" style="border-style: none; margin-bottom: 4px"/> <br/>
               same password again <input type="password" id="Password2" style="border-style:none"  />
        </div>
</body>
</html>
