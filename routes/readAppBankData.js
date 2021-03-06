/*
 * script route generated by KOMA
 * @author : Yan Yan Purdiansah
 */    
var express = require('express');
var router = express.Router();
var dateFormat = require('dateformat');    
var database = require('./dao');
var dao = new database.Dao();    
var sessionChecker = require('./security');
var appresource = {
    Title:'AppBankDataRead',
    Heading:'AppBankData',
    BankDataId:{label :'BankDataId'},
    BankAccount:{label :'BankAccount'},
    BankAddress1:{label :'BankAddress1'},
    BankAddress2:{label :'BankAddress2'},
    CityId:{label :'CityId'},
    ZipCode:{label :'ZipCode'},
    }

router.get('/', sessionChecker, function(req, res, next) {
    var jsonObj = req.query;
    jsonObj.rowid = 0;
    req.session.previouspath = 'readAppBankData?'+req._parsedUrl.query;
    parameter = {
        session: req.session,
        cookies: req.cookies,
        resource: appresource,
        dateFormat: dateFormat,
    }
    var readAppBankData = new Promise((resolve, reject) => {
        setTimeout(() => {
            dao.readAppBankData(jsonObj,function(err,rows) {
                if(err) res.status(err.code).end();
                else{
                    if(rows[0]===undefined) res.redirect('/searchAppBankData');
                    else{ 
                        jsonObj = rows[0];
                        resolve(jsonObj);
                    }
                }
            });
        },1000);
    });
    
    var sendResult = (results) => {
        console.log(jsonObj)
        parameter.record = jsonObj;        
        res.render('AppBankDataReadPage',parameter);
    }    
    Promise.all([readAppBankData]).then(sendResult);
});

module.exports = router;
