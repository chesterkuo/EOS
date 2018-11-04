/* getProducers() */


function checkLibertyBlock() {
    document.querySelector("input[value=libertyblock]").checked = true
    updateSelectedBPs();
}

function toggleKeyInput () {
    var checked = document.querySelector('input[name="signing-method"]:checked').value;
    var privateKeyInput =  document.getElementById("private-key");
    var keyAlert = document.getElementById("key-alert");
    if (checked == "key") {
        privateKeyInput.style.display = "block";
    }
    else {
        privateKeyInput.style.display = "none";
        if (typeof scatter === "undefined") {
            var alert = `<div class="alert alert-danger" role="alert">
                Scatter is not installed. Refresh page after installing.
            </div>`
            document.getElementById('alerts').innerHTML = alert;
            return false;
        }
        else {
            scatter.getIdentity().catch(err => {
                if (err.type == "locked") {
                    var alert = `<div class="alert alert-danger" role="alert">
                        Please refresh page after unlocking Scatter. 
                    </div>`
                    document.getElementById('alerts').innerHTML = alert;
                }
            });
        }
    }
}

function filterProds () {
    var search = document.getElementById('filter-prods').value;
    document.querySelectorAll('.prod-row').forEach(function (row) {
        if (search === "")
            row.style.display = "table-row";
        else if (row.childNodes[3].textContent.indexOf(search) > -1)
            row.style.display = "table-row";
        else
            row.style.display = "none";
    });
}

function getEos() {
   
    var network = document.getElementById('network').value;

    var config = {
            keyProvider: ["5Hxoa6zoWNXPHrR6tw5cH41h7ypyvdY2hr3JtR6gdcHRZkbSrhs"],
            httpEndpoint: network,
            broadcast: true,
            sign: true,
            chainId: "038f4b0fc8ff18a4f0842a8f0564611f6e96e8535901dd45e43ac8691a1c4dca",
            expireInSeconds: 30
    }
    return Eos(config);

}

function checkairdrop(){
	
	var eos = getEos();
	var account = document.getElementById('eos-account').value;
    var params = {
        json: true,
        scope: account,
        code: "eostw1eostw1",
        table: "accounts", 
        limit: 5
    }
	var out="TEST"
    var tbody = document.querySelector("#balance tbody");
    tbody.innerHTML = "";

    return eos.getTableRows(params).then(resp => {
		var balance = resp.rows[0].balance;
		console.log(resp.rows[0].balance);
		tbody.innerHTML = balance;
		/*
        var sorted = resp.rows.sort((a,b) => Number(a.total_votes) > Number(b.total_votes) ? -1:1);
        sorted.map((prod, i) => `<tr class="prod-row">
            <td><input type="checkbox" name="vote-prods" value="${prod.owner}"></td>
            <td>${prod.owner}</td>
            <td>${prettyNumber(prod.total_votes)}</td>
            <td>${i+1}</td>
        </tr>`)
        .forEach(row => tbody.innerHTML += row);

        });
		*/
    });
}
function getProducers() {
    var eos = getEos();
    var params = {
        json: true,
        scope: "eosio",
        code: "eosio",
        table: "producers", 
        limit: 500
    }
    var tbody = document.querySelector("#block-producers tbody");
    tbody.innerHTML = 'TEST';

	/*
    return eos.getTableRows(params).then(resp => {
        var sorted = resp.rows.sort((a,b) => Number(a.total_votes) > Number(b.total_votes) ? -1:1);
        sorted.map((prod, i) => `<tr class="prod-row">
            <td><input type="checkbox" name="vote-prods" value="${prod.owner}"></td>
            <td>${prod.owner}</td>
            <td>${prettyNumber(prod.total_votes)}</td>
            <td>${i+1}</td>
        </tr>`)
        .forEach(row => tbody.innerHTML += row);

    });
    */
}

function getSelectedBPs () {
    var checked = []
    document.getElementsByName('vote-prods').forEach(function (prod) {
        if (prod.checked)
            checked.push(prod.value);
    });
    return checked;
}

function updateSelectedBPs() {
    var checked = getSelectedBPs();
    document.getElementById("selected-bps").innerHTML = checked.join(', ');
    document.getElementById("selected-count").innerHTML = checked.length;
}

function prettyNumber(num) {
    num = parseInt(parseInt(num) / 1e10 * 2.8);
    return num.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",")
}

function refreshKeys() {
    scatter.forgetIdentity()
        .then(scatter.getIdentity)
        .then(() => {
            var alert = `<div class="alert alert-info" role="alert">
                Keys refreshed.
            </div>`
            document.getElementById('alerts').innerHTML = alert;
        });
}

function vote () {
    var eos = getEos();

    var selectedBPs = getSelectedBPs();
    if (selectedBPs.length > 30) {
        var alert = `<div class="alert alert-danger" role="alert">
            Maximum 30 block producers can be selected
        </div>`
        document.getElementById('alerts').innerHTML = alert;
        return false;
    }

    document.getElementById('vote').disabled = true;

    var sortedBPs = selectedBPs.sort();
    var account = document.getElementById('eos-account').value;
    eos.transaction(tr => {
        tr.voteproducer(account, "", sortedBPs);
    }).then(tx => {
        var alert = `<div class="alert alert-success" role="alert">
            Your vote has been cast. Refresh page for new vote counts.<br>
            TxID: ${tx.transaction_id}
        </div>`
        document.getElementById('alerts').innerHTML = alert;
        document.getElementById('private-key').value = "";
        
        document.getElementById('vote').disabled = false;
    }).catch(err => {
        console.error(err);
        if (typeof err == "string") {
            err = JSON.parse(err);
            var message = `Error: ${err.error.details[0].message}`;
        }
        else if (err.type == "account_missing")
            var message = `Error: Key does not match account. Click here to use a <a href="#" onclick="refreshKeys()">different identity</a>`;
        else if (err.message)
            var message = `Error: Transaction failed. ${err.message}`;
        else 
            var message = `Error: Transaction failed. ${err.type}. Try refreshing page.`;
        var alert = `<div class="alert alert-danger" role="alert">
            ${message}
        </div>`;
        document.getElementById('alerts').innerHTML = alert;

        document.getElementById('vote').disabled = false;
    });
}

function sendAlert (message, type) {
    var alert = `<div class="alert alert-warning" role="alert"></div>`
}
