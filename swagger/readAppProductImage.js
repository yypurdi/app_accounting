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
 * /readAppProductImage:
 *   get:
 *     tags:
 *       - Administration
 *     description: readAppProductImage
 *     summary: AppProductImageRead
 *     consumes:
 *       - application/json
 *     produces:
 *       - application/json
 *     parameters: 
 *       - name: productImageId
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
    
    var readAppProductImage = new Promise((resolve, reject) => {
        dao.readAppProductImage(jsonObj,function(err,rows) {
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
    
    var sendResult = (results) => {
        console.log(jsonObj)
        res.status(200).send(jsonObj);
    }
    
    Promise.all([readAppProductImage]).then(sendResult);
});

module.exports = router;