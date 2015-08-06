<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
       

<head runat="server">
        <link type="text/css" href="/Content/jquery-ui-1.8.12.custom.css" rel="stylesheet" />	
		<script type="text/javascript" src="../Scripts/jquery-1.4.1.min.js"></script>
		<script type="text/javascript" src="../Scripts/jquery-ui-1.8.12.custom.min.js"></script>
        <script type="text/javascript" src="../Scripts/javascript_security.js"></script>
    <title>Index</title>
    <style type="text/css">
			/*demo page css*/
			body{ font: 62.5% "Trebuchet MS", sans-serif; margin: 50px;}
			.demoHeaders { margin-top: 2em; }
			#enter_link {padding: .4em 1em .4em 20px;text-decoration: none;position: relative;}
			#enter_link span.ui-icon {margin: 0 5px 0 0;position: absolute;left: .2em;top: 50%;margin-top: -8px;}
			
			#reg_link {padding: .4em 1em .4em 20px;text-decoration: none;position: relative;}
			#reg_link span.ui-icon {margin: 0 5px 0 0;position: absolute;left: .2em;top: 50%;margin-top: -8px;}
			
		    #exit {padding: .4em 1em .4em 20px;text-decoration: none;position: relative;}
			#exit span.ui-icon {margin: 0 5px 0 0;position: absolute;left: .2em;top: 50%;margin-top: -8px;}
			
			#save {padding: .4em 1em .4em 20px;text-decoration: none;position: relative;}
			#save span.ui-icon {margin: 0 5px 0 0;position: absolute;left: .2em;top: 50%;margin-top: -8px;}
			
			ul#icons {margin: 0; padding: 0;}
			ul#icons li {margin: 2px; position: relative; padding: 4px 0; cursor: pointer; float: left;  list-style: none;}
			ul#icons span.ui-icon {float: left; margin: 0 4px;}
		</style>	
</head>
<body>
    <div>
    <script type="text/javascript">

        function GetRes(res) {
            isAuth = res;
            if (isAuth != null && isAuth == "True") {
                $('#authblock').hide();
                $('#tt').show();
            }
            else {
                $('#authblock').show();
                $('#tt').hide();
            } 
        }

        function refresh () {
            
         
            $.ajax({
                            type: "GET",
                            url: "/Home/IsAuthenticated",
                            success: GetRes
                        });
            

        }        
        
        $(document).ready(refresh);

        
        $(function () {
            // Dialog Link
            $('#enter_link').click(function () {
                $('#enter_dialog').dialog('open');
                return false;
            });

            $('#reg_link').click(function () {
                $('#reg_dialog').dialog('open');
                return false;
            });

            $('#tabs').tabs(); 

            $('#exit').click(function () {
                        $.ajax({
                            type: "GET",
                            url: "/Home/Exit",
                            success: refresh
                        });
    
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
                            success: refresh
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
                        $.ajax({
                            type: "GET",
                            url: "/Home/Register",
                            data: "login=John&pass=Boston",
                            success: refresh
                        });

                        $(this).dialog("close");
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
Вы не авторизованы

<a id="enter_link" class="ui-state-default ui-corner-all ui-state-hover" href="#">
<span class="ui-icon ui-icon-newwin"></span>
Войдите
</a>
&nbsp или 
<a id="reg_link" class="ui-state-default ui-corner-all ui-state-hover" href="#">
<span class="ui-icon ui-icon-newwin"></span>
Зарегистрируйтесь
</a>
</div>

<div id="tt" style= "display:table-caption; white-space: nowrap;">
<div style="margin-bottom: 10px;" >
Вы можете
<a id="exit" class="ui-state-default ui-corner-all ui-state-hover"  href="#">
<span class="ui-icon ui-icon-newwin"></span>
 Выйти
</a>
&nbsp или редактировать свои данные    
</div>
<br/>
</br>

<div id="tabs" class="ui-tabs ui-widget ui-widget-content ui-corner-all">
<ul class="ui-tabs-nav ui-helper-reset ui-helper-clearfix ui-widget-header ui-corner-all">
<li class="ui-state-default ui-corner-top ui-tabs-selected ui-state-active">
<a href="#tabs-1">Данные логина</a>
</li>
<li class="ui-state-default ui-corner-top ui-tabs-selected ui-state-active">
<a href="#tabs-2">Личные данные</a>
</li>
</ul>
<div id="tabs-1" class="ui-tabs-panel ui-widget-content ui-corner-bottom">   Логин <input type="text" id="Text2"  style="border-style:none; margin-bottom: 4px" /> <br></br>
               Пароль <input type="password" id="Password3" style="border-style:none;  margin-bottom: 4px"  /> <br></br>
               Еще раз пароль <input type="password" id="Password4" style="border-style:none"  /></div>
<div id="tabs-2" class="ui-tabs-panel ui-widget-content ui-corner-bottom ui-tabs-hide">   E-mail: <input type="text" id="Text3"  style="border-style:none; margin-bottom: 4px" /> <br></br>
               Возраст: <input type="text" id="Text4"  style="border-style:none; margin-bottom: 4px" /> <br></br>
               </div>
</div>
<br/>
</br>

<a id="save" class="ui-state-default ui-corner-all ui-state-hover"  href="#">
<span class="ui-icon ui-icon-disk"></span>Сохранить
</a>
</div>

    <div id="enter_dialog" title="Для входа введите">
			<p>Логин <input type="text" id="login"  style="border-style:none; margin-bottom: 4px" /> <br></br>
               Пароль <input type="password" id="pass" style="border-style:none"  />
             </p>
		</div>

    <div id="reg_dialog" title="Для регистрации введите">
			   Логин <input type="text" id="Text1"  style="border-style:none; margin-bottom: 4px" /> <br></br>
               Пароль <input type="password" id="Password1" style="border-style:none;  margin-bottom: 4px"  /> <br></br>
               Еще раз пароль <input type="password" id="Password2" style="border-style:none"  />

		</div>

     
    <%--    <input type="button" id="ss1" onclick="check_auth();" />
        <input type="button" id="ss2" onclick="save_cookie();" />--%>
</body>
</html>
