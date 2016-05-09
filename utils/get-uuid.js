var https = require('https');

var options = {
  host: 'wakatime.com',
  path: '/api/v1/xcode_releases'
};

callback = function(response) {
  var str = '';

  response.on('data', function (chunk) {
    str += chunk;
  });

  response.on('end', function () {
    if(JSON.parse(str)) {
      var data = JSON.parse(str)
      if (data.data && data.data.length) {
        var arr = {} // Use object to don't duplicate keys
        data.data.forEach(function(el, index){
          arr["<string>" + el.dvt_uuid + "</string>"] = true
        })

        Object.keys(arr).forEach(function(key) {
          console.log(key);
        });
      } else {
        throw new Error("Can't find data array in response's JSON")
      }
    } else {
      throw new Error("Wrong JSON data")
    }
  });
}

https.request(options, callback).end();
