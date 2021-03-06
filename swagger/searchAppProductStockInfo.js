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
 * /searchAppProductStockInfo:
 *   get:
 *     tags:
 *       - Administration
 *     description: searchAppProductStockInfo
 *     summary: AppProductStockInfoSearch
 *     consumes:
 *       - application/json
 *     produces:
 *       - application/json
 *     parameters: 
 *       - name: productStockInfoId
 *         description: Long
 *         in: query
 *         type: Long
 *       - name: qtyInStock
 *         description: Integer
 *         in: query
 *         type: Integer
 *       - name: orderedToVendor
 *         description: Integer
 *         in: query
 *         type: Integer
 *       - name: orderedByCustomer
 *         description: Integer
 *         in: query
 *         type: Integer
 *       - name: minimumInventory
 *         description: Integer
 *         in: query
 *         type: Integer
 *       - name: minimumOrder
 *         description: Integer
 *         in: query
 *         type: Integer
 *       - name: salesForecast
 *         description: Integer
 *         in: query
 *         type: Integer
 *       - name: buyingPrice
 *         description: Double
 *         in: query
 *         type: Double
 *       - name: productId
 *         description: Long
 *         in: query
 *         type: Long
 *       - name: buyingPriceTax
 *         description: String
 *         in: query
 *         type: String
 *       - name: sellingUnitPriceTax
 *         description: String
 *         in: query
 *         type: String
 *       - name: unitCostOrCogs
 *         description: Double
 *         in: query
 *         type: Double
 *       - name: cogsDepartment
 *         description: String
 *         in: query
 *         type: String
 *       - name: locationMaster
 *         description: String
 *         in: query
 *         type: String
 *       - name: deliveryTimeIndays
 *         description: Integer
 *         in: query
 *         type: Integer
 *       - name: currentSellingPrice
 *         description: Double
 *         in: query
 *         type: Double
 *       - name: mainVendor
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
    if(jsonObj.rowid===undefined) jsonObj.rowid = 0;
    dao.searchAppProductStockInfo(jsonObj,function(err,rows) {    
        if(err) res.status(err.code).end();
        else {
            jsonObj.appProductStockInfo = rows;
            res.status(200).send(jsonObj);
        }
        console.log(jsonObj);        
    });
});

module.exports = router;
