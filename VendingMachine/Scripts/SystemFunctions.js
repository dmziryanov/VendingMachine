String.format = function () {
    // The string containing the format items (e.g. "{0}")
    // will and always has to be the first argument.
    var theString = arguments[0];

    // start with the second argument (i = 1)
    for (var i = 1; i < arguments.length; i++) {
        // "gm" = RegEx options for Global search (more than one instance)
        // and for Multiline search
        var regEx = new RegExp("\\{" + (i - 1) + "\\}", "gm");
        theString = theString.replace(regEx, arguments[i]);
    }

    return theString;
}

var pendingRequests = $.ajax({
    type: "GET",
    url: "/VM/GetAssortment",
    datatype: "json",
    success: function (data) {
        var keys = Object.keys(data);
        for (var i in keys) {
            if (viewModel[keys[i]] != undefined) {
                viewModel[keys[i]](data[keys[i]]);
            }
        }
    }
});