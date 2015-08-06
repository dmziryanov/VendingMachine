<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>

<!DOCTYPE html>

<html>
<head runat="server">
    <link type="text/css" href="/Content/jquery-ui-1.8.12.custom.css" rel="stylesheet" />
    <script type="text/javascript" src="../../Scripts/jquery-1.8.3.min.js"></script>
    <script type="text/javascript" src="../../Scripts/jquery-ui.min.js"></script>
    <script type="text/javascript" src="../../Scripts/javascript_security.js"></script>
    <script type="text/javascript" src="../../Scripts/knockout-3.1.0.js"></script>
    <script type="text/javascript" src="../../Scripts/SystemFunctions.js"></script>
    <title>Index</title>
    <style type="text/css">
        fieldset {
            border: 0;
        }

        label {
            display: block;
            margin: 30px 0 0 0;
        }

        select {
            width: 200px;
        }

        .overflow {
            height: 200px;
        }

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

        .ui-spinner-button {
            padding: .4em 1em .4em 20px;
            text-decoration: none;
            position: relative;
            margin: 5px 5px 0 0;
            left: .2em;
            top: 50%;
            margin: -1em;
        }

        #Selector {
            width: 110px;
        }
    </style>
</head>
<body>
    <script>

        function viewModel() {
                self.Goods = ko.observableArray([
                    { name: "Tea", type: 2, price: 20, quantity: 20 }
            ]);
        }

        VMMachineGoodTemplate = "<p><h3>{0}</h3><input id='Buy{2}' type='submit' value='Buy {1}'/></p>";
        WalletStringTemplate = "<p><h3>Coin {0}. Available {1}</h3>";

        SetVMView = function (data) {
            htmlString = "";
            var j = 0;
            for (j in data.Goods) {
                htmlString += String.format(VMMachineGoodTemplate, data.Goods[j].Name + ". Price per unit: " + data.Goods[j].Price + " roubles. Available " + data.Goods[j].Quantity, data.Goods[j].Name, data.Goods[j].Type);
            };


            $.ajax({
                type: "GET",
                url: "/VM/GetAssortment",
                datatype: "json",
                success: function (data) {
                    viewModel.Goods(data.Goods);
                }
            });

            // $("#Assortment").html(htmlString);

            $("input[id*='Buy']").click(function () {
                var button = $(this);
                $.ajax({
                    type: "GET",
                    url: "/VM/Buy",
                    data: "Type=" + button[0].id.replace("Buy", ""),
                    success: RefreshView
                });
            });
            $("input[type='submit']").button();
        };

        SetCustomerWallet = function (data) {
            htmlString = "";
            var j = 0;
            for (j in data) {
                htmlString += String.format(WalletStringTemplate, data[j].Key, data[j].Value);

            };

            $("#CustomerWallet").html(htmlString);
        }

        SetMachineWallet = function (data) {
            htmlString = "";
            var j = 0;
            for (j in data) {
                htmlString += String.format(WalletStringTemplate, data[j].Key, data[j].Value);
            };

            $("#MachineWallet").html(htmlString);
        }

        RefreshView = function (data) {
            $.ajax({
                type: "GET",
                dataType: 'json',
                url: "/VM/GetAssortment",
                success: SetVMView
            });

            $.ajax({
                type: "GET",
                dataType: 'json',
                url: "/VM/GetCustomerWallet",
                success: SetCustomerWallet
            });

            $.ajax({
                type: "GET",
                dataType: 'json',
                url: "/VM/GetMachineWallet",
                success: SetMachineWallet
            });

            $('#UserBalance').html('(You may bought goods up to ' + data.CustomerBalance + ' roubles)');
            if (data.res == 0) {
                $("#NotEnoughMoneyDialog").dialog();
            }
            if (data.res == 1) {
                $("#SuccessDialog").dialog();
            }
        }

        $(document).ready(function () {
            RefreshView({ CustomerBalance: 0, res: -1 });

            ko.applyBindings(viewModel);

            $("#SubmitPayment").click(function () {
                $.ajax({
                    type: "GET",
                    url: "/VM/MakePayment",
                    data: "Amount=" + $('#Selector').val(),
                    success: RefreshView
                });
            });

            $("#ReturnMoney").click(function () {
                $.ajax({
                    type: "GET",
                    url: "/VM/CustomerPayBack",
                    success: RefreshView
                });
            });

            $("#StartItAgain").click(function () {
                $.ajax({
                    type: "GET",
                    url: "/VM/StartItAgain",
                    success: RefreshView
                });
            });
        });
    </script>

    <div>
    </div>

    <table style="width: 100%;">
        <tr>
            <td colspan="2" style="font-size: large">Insert coins please</td>
            <td style="font-size: large">What would you prefer?</td>
            <td>
                <input id="StartItAgain" type="submit" value="Start it again" /></td>
        </tr>
        <tr>
            <td colspan="2" style="font-size: large"></td>
            <td id="UserBalance"></td>
        </tr>
        <tr>
            <td>
                <select id="Selector" name="D1">
                    <option selected="selected">1</option>
                    <option>2</option>
                    <option>5</option>
                    <option>10</option>
                </select>
                <input id="SubmitPayment" type="submit" value="Insert" />
                <input id="ReturnMoney" type="submit" value="Take ALL money back" />
            <td></td>
            <td>
                <div id="Assortment">
                    <ul data-bind="foreach: Goods">
                        <li>
                                    Name at position <span data-bind="text: $index"> </span>: 
                                    <span data-bind="text: name"> </span>
                                    <h3 data-bind="content: name"></h3>
                                    <input data-bind="id: name" type='submit' value='Buy$index' />
                        </li>
                    </ul>
                </div>
            </td>
        </tr>
        <tr>
            <td colspan="2" style="font-size: large">Your wallet</td>
            <td style="font-size: large">Coins available in machine</td>
        </tr>
        <tr>
            <td colspan="2" id="CustomerWallet"></td>
            <td id="MachineWallet"></td>
        </tr>
    </table>
    <div hidden="true" id="SuccessDialog" title="Successful">
        <p>You may took good from machine.</p>
    </div>

    <div hidden="true" id="NotEnoughMoneyDialog" title="Something wrong">
        <p>Please insert more coins</p>
    </div>
</body>
</html>
