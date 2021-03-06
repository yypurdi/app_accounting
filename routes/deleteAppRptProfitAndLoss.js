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
    Title:'AppRptProfitAndLossDelete',
    Heading:'AppRptProfitAndLoss',
    RptProfitAndLossId:{label :'RptProfitAndLossId'},
    RptProfitAndLossName:{label :'RptProfitAndLossName'},
    DepartmentFrom:{label :'DepartmentFrom'},
    DepartmentTo:{label :'DepartmentTo'},
    CurrencyId:{label :'CurrencyId'},
    Revenue:{label :'Revenue'},
    RevenueExpenditure:{label :'RevenueExpenditure'},
    GrossMargin:{label :'GrossMargin'},
    OperationalExpenditure:{label :'OperationalExpenditure'},
    OperatingProfit:{label :'OperatingProfit'},
    OtherRevenue:{label :'OtherRevenue'},
    OtherExpenditure:{label :'OtherExpenditure'},
    NetProfit:{label :'NetProfit'},
    ComparativeRevenue:{label :'ComparativeRevenue'},
    ComparativeRevenueExpenditure:{label :'ComparativeRevenueExpenditure'},
    ComparativeGrossMargin:{label :'ComparativeGrossMargin'},
    ComparativeOperationalExpenditure:{label :'ComparativeOperationalExpenditure'},
    ComparativeOperatingProfit:{label :'ComparativeOperatingProfit'},
    ComparativeOtherRevenue:{label :'ComparativeOtherRevenue'},
    ComparativeOtherExpenditure:{label :'ComparativeOtherExpenditure'},
    ComparativeNetProfit:{label :'ComparativeNetProfit'},
    DateCreated:{label :'DateCreated'},
    CreatedBy:{label :'CreatedBy'},
    }

router.get('/', sessionChecker, function(req, res, next) {
    var jsonObj = req.query;
    parameter = {
        session: req.session,
        cookies: req.cookies,
        resource: appresource,
        dateFormat: dateFormat,
    }
    dao.deleteAppRptProfitAndLoss(jsonObj,function(err,rows) {
        if(err==null){
            parameter.statusCode = 200;
            parameter.statusMessage = 'Successfully created';
        }else{
            parameter.statusCode = err.code;
            parameter.statusMessage = err.message;
        }
        res.redirect(req.session.previouspath);
        console.log(parameter);        
    });
});

module.exports = router;
