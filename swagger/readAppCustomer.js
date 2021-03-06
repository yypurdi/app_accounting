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
 * /readAppCustomer:
 *   get:
 *     tags:
 *       - Administration
 *     description: readAppCustomer
 *     summary: AppCustomerRead
 *     consumes:
 *       - application/json
 *     produces:
 *       - application/json
 *     parameters: 
 *       - name: customerId
 *         description: Long 
 *         in: query
 *         type: Long
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
    jsonObj.rowid = 0;
    
    var readAppCustomer = new Promise((resolve, reject) => {
        dao.readAppCustomer(jsonObj,function(err,rows) {
            if(err) res.status(err.code).end();
            else{
                if(rows[0]===undefined) res.status(404).end();
                else{ 
                    jsonObj = rows[0];
                    resolve(jsonObj);
                }
            }
        });
    });
    
    var appArAging = new Promise((resolve, reject) => {
        dao.searchAppArAging(jsonObj,function(err,rows) {
            jsonObj.appArAging = rows;
            resolve(jsonObj);
        });        
    });
    
    var appArCustomerDetail = new Promise((resolve, reject) => {
        dao.searchAppArCustomerDetail(jsonObj,function(err,rows) {
            jsonObj.appArCustomerDetail = rows;
            resolve(jsonObj);
        });        
    });
    
    var appArOpeningBalance = new Promise((resolve, reject) => {
        dao.searchAppArOpeningBalance(jsonObj,function(err,rows) {
            jsonObj.appArOpeningBalance = rows;
            resolve(jsonObj);
        });        
    });
    
    var appProject = new Promise((resolve, reject) => {
        dao.searchAppProject(jsonObj,function(err,rows) {
            jsonObj.appProject = rows;
            resolve(jsonObj);
        });        
    });
    
    var appSummaryArAging = new Promise((resolve, reject) => {
        dao.searchAppSummaryArAging(jsonObj,function(err,rows) {
            jsonObj.appSummaryArAging = rows;
            resolve(jsonObj);
        });        
    });
    
    var appSummaryArCustomer = new Promise((resolve, reject) => {
        dao.searchAppSummaryArCustomer(jsonObj,function(err,rows) {
            jsonObj.appSummaryArCustomer = rows;
            resolve(jsonObj);
        });        
    });
    
    var sendResult = (results) => {
        console.log(jsonObj)
        res.status(200).send(jsonObj);
    }
    
    Promise.all([readAppCustomer,appArAging,appArCustomerDetail,appArOpeningBalance,appProject,appSummaryArAging,appSummaryArCustomer]).then(sendResult);
});

module.exports = router;
