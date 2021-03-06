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
    Title:'AppBankDataNew',
    Heading:'AppBankData',
    BankDataId:{label :'BankDataId'},
    BankAccount:{label :'BankAccount'},
    BankAddress1:{label :'BankAddress1'},
    BankAddress2:{label :'BankAddress2'},
    CityId:{label :'CityId'},
    ZipCode:{label :'ZipCode'},
    }

router.get('/', sessionChecker, function(req, res, next) {
    parameter = {
        session: req.session,
        cookies: req.cookies,
        resource: appresource,
        dateFormat: dateFormat,
        statusCode:100,
        statusMessage:'',        
        record:{bankDataId:'',
        bankAccount:'',
        bankAddress1:'',
        bankAddress2:'',
        cityId:'',
        zipCode:'',
        }
    }
    res.render('AppBankDataNewPage',parameter);
    console.log(parameter);
});
router.post('/', sessionChecker, function(req, res, next) {
    var jsonObj = req.body;
    parameter = {
        session: req.session,
        cookies: req.cookies,
        resource: appresource,
        dateFormat: dateFormat,
    }    
    dao.newAppBankData(jsonObj,function(err,rows) {
        if(err==null){
            parameter.statusCode = 200;
            parameter.statusMessage = 'Successfully created';
        }else{
            parameter.statusCode = err.code;
            parameter.statusMessage = err.message;
        }
        parameter.record = jsonObj;
        res.render('AppBankDataNewPage',parameter);
        console.log(parameter);        
    });
});

module.exports = router;
