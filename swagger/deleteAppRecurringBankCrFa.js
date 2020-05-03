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
 * /deleteAppRecurringBankCrFa:
 *   delete:
 *     tags:
 *       - Administration
 *     description: deleteAppRecurringBankCrFa
 *     summary: AppRecurringBankCrFaDelete
 *     consumes:
 *       - application/json
 *     produces:
 *       - application/json
 *     parameters: 
 *       - name: recurringBankCrFaId
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
    dao.deleteAppRecurringBankCrFa(jsonObj,function(err,rows) {
        if(err) res.status(err.code).end();
        else {
            jsonObj.result = rows;
            res.status(200).send(jsonObj);
        }
        console.log(jsonObj);        
    });
});

module.exports = router;