/*
 * script route generated by KOMA
 * @author : Yan Yan Purdiansah
 */    
var express = require('express');
var router = express.Router();
var database = require('./dao');
var dao = new database.Dao();
        
/**
 * @swagger
 * /searchAppRptProfitAndLoss:
 *   get:
 *     tags:
 *       - Administration
 *     description: searchAppRptProfitAndLoss
 *     summary: AppRptProfitAndLossSearch
 *     consumes:
 *       - application/json
 *     produces:
 *       - application/json
 *     parameters: 
 *       - name: rptProfitAndLossId
 *         description: Long
 *         in: query
 *         type: Long
 *       - name: rptProfitAndLossName
 *         description: String
 *         in: query
 *         type: String
 *       - name: departmentFrom
 *         description: Long
 *         in: query
 *         type: Long
 *       - name: departmentTo
 *         description: Long
 *         in: query
 *         type: Long
 *       - name: currencyId
 *         description: Long
 *         in: query
 *         type: Long
 *       - name: revenue
 *         description: Double
 *         in: query
 *         type: Double
 *       - name: revenueExpenditure
 *         description: Double
 *         in: query
 *         type: Double
 *       - name: grossMargin
 *         description: Double
 *         in: query
 *         type: Double
 *       - name: operationalExpenditure
 *         description: Double
 *         in: query
 *         type: Double
 *       - name: operatingProfit
 *         description: Double
 *         in: query
 *         type: Double
 *       - name: otherRevenue
 *         description: Double
 *         in: query
 *         type: Double
 *       - name: otherExpenditure
 *         description: Double
 *         in: query
 *         type: Double
 *       - name: netProfit
 *         description: Double
 *         in: query
 *         type: Double
 *       - name: comparativeRevenue
 *         description: Double
 *         in: query
 *         type: Double
 *       - name: comparativeRevenueExpenditure
 *         description: Double
 *         in: query
 *         type: Double
 *       - name: comparativeGrossMargin
 *         description: Double
 *         in: query
 *         type: Double
 *       - name: comparativeOperationalExpenditure
 *         description: Double
 *         in: query
 *         type: Double
 *       - name: comparativeOperatingProfit
 *         description: Double
 *         in: query
 *         type: Double
 *       - name: comparativeOtherRevenue
 *         description: Double
 *         in: query
 *         type: Double
 *       - name: comparativeOtherExpenditure
 *         description: Double
 *         in: query
 *         type: Double
 *       - name: comparativeNetProfit
 *         description: Double
 *         in: query
 *         type: Double
 *       - name: dateCreated
 *         description: java.util.Date
 *         in: query
 *         type: java.util.Date
 *       - name: createdBy
 *         description: String
 *         in: query
 *         type: String
 *     responses:
 *       '200':
 *         description: OK
 *       '401':
 *         description: Unauthorized
 *       '403':
 *         description: Forbidden
 *       '404':
 *         description: Not Found 
 *       '500':
 *         description: Internal Server Problem
 */    

router.get('/', function(req, res, next) {
    var jsonObj = req.query;
    if(jsonObj.rowid===undefined) jsonObj.rowid = 0;
    dao.searchAppRptProfitAndLoss(jsonObj,function(err,rows) {    
        if(err) res.status(err.code).end();
        else {
            jsonObj.appRptProfitAndLoss = rows;
            res.status(200).send(jsonObj);
        }
        console.log(jsonObj);        
    });
});

module.exports = router;