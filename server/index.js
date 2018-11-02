let fs = require('fs');
let express = require('express');
let app = express();

// Home page route
app.get('/', function (req, res) {
    res.send('Your local server running! \n Follow me on Twitter <a href="https://twitter.com/omoseisreal">@Omoseisreal</a>');
});

// sample-data page
app.get('/sample-data', function (req, res) {
    fs.readFile('./sample-data/news_data.json', function(err, data) {
    res.setHeader('Content-Type', 'application/json');
    res.send(data.toString('utf8'));
    });
});

app.listen(8080, function(){ });
