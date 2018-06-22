

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

    var currency = jsonData.getdashboarddata.data.pool.info.currency
    var name = jsonData.getdashboarddata.data.pool.info.name
    var m_balance_confirmed = jsonData.getdashboarddata.data.balance.confirmed ;
    var m_balance_unconfirmed = jsonData.getdashboarddata.data.balance.unconfirmed ;
    var m_personal_hashrate = jsonData.getdashboarddata.data.personal.hashrate ;

    if(myCoin=="ZEC")
    {
        zecId.myConfirmedValue =  m_balance_confirmed;
        zecId.myUnconfirmedValue =  m_balance_unconfirmed;
        zecId.myHashrate = m_personal_hashrate
    }
    else if(myCoin=="XMR")
    {

        xmrId.myConfirmedValue =  m_balance_confirmed;
        xmrId.myUnconfirmedValue =  m_balance_unconfirmed;
        xmrId.myHashrate = m_personal_hashrate

    }
    else if(myCoin=="ETN")
    {
        etnId.myConfirmedValue =  m_balance_confirmed;
        etnId.myUnconfirmedValue =  m_balance_unconfirmed;
        etnId.myHashrate = m_personal_hashrate

    }
    else if(myCoin=="ZCL")
    {
        zclId.myConfirmedValue =  m_balance_confirmed;
        zclId.myUnconfirmedValue =  m_balance_unconfirmed;
        zclId.myHashrate = m_personal_hashrate

    }

    console.log("update done : "+ name)
}









