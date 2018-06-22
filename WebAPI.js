

function addZero(i) {
    if (i < 10) i = "0" + i;
    return i;
}

/* 1 Day */
function get_Method(m_url) {

    if (m_url != "") {
        var xhr = new XMLHttpRequest;
        xhr.open("GET", m_url);

        xhr.onreadystatechange = function() {
            if (xhr.readyState === XMLHttpRequest.DONE) {
                var a = JSON.parse(xhr.responseText);
                parse_JSON_Data(a);
            }
        }
        xhr.send();
    } else {
        console.log("ERROR: No App Key")
    }
}

function parse_JSON_Data(jsonData) {

    var userId = jsonData[0].user_id
    root.userConnectedId = userId
    console.log("userId : "+userId)


}
