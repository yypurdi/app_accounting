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
    Title:'AppCurrencyRevaluationWrite',
    Heading:'AppCurrencyRevaluation',
    CurrencyRevaluationId:{label :'CurrencyRevaluationId'},
    Date:{label :'Date'},
    CurrencyId:{label :'CurrencyId'},
    ExchangeRate:{label :'ExchangeRate'},
    IsActivateAccountFilterType:{label :'IsActivateAccountFilterType'},
    IsActivateAccountCodeFilter:{label :'IsActivateAccountCodeFilter'},
    IsRecalculateAccountEndBalance:{label :'IsRecalculateAccountEndBalance'},
    }

router.get('/', sessionChecker, function(req, res, next) {
    var jsonObj = req.query;
    parameter = {
        session: req.session,
        cookies: req.cookies,
        resource: appresource,
        dateFormat: dateFormat,
        statusCode:100,
        statusMessage:'',
    }
    dao.readAppCurrencyRevaluation(jsonObj,function(err,rows) {
        parameter.record = rows[0];
        res.render('AppCurrencyRevaluationWritePage',parameter);
        console.log(parameter);        
    });
});
router.post('/', sessionChecker, function(req, res, next) {
    var jsonObj = req.body;
    parameter = {
        session: req.session,
        cookies: req.cookies,
        resource: appresource,
        dateFormat: dateFormat,        
    }
    dao.writeAppCurrencyRevaluation(jsonObj,function(err,rows) {    
        if(err==null){
            parameter.statusCode = 200;
            parameter.statusMessage = 'Successfully created';
        }else{
            parameter.statusCode = err.code;
            parameter.statusMessage = err.message;
        }
        parameter.record = jsonObj;
        res.render('AppCurrencyRevaluationWritePage',parameter);
        console.log(parameter);        
    });
});

module.exports = router;
