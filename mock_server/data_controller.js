const path = require('path');
const fs = require('fs');

const basePathToData = path.join(__dirname, 'db.json');

const getJsonData = function (basePathToData, fileName){
    var fileName = path.join(basePathToData, fileName);
    return JSON.parse(fs.readFileSync(fileName, 'utf-8'));
};

exports.getData = function(req, res){
    var data = getData(basePathToData, 'db.json');
    setTimeout(function(){
        return res.send(data);
    }, 100);
}