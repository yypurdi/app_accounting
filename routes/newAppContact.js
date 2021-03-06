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
    Title:'AppContactNew',
    Heading:'AppContact',
    Username:{label :'Username'},
    Subscription:{label :'Subscription'},
    Jid:{label :'Jid'},
    Nickname:{label :'Nickname'},
    Joindate:{label :'Joindate'},
    Show:{label :'Show'},
    Status:{label :'Status'},
    Lastseen:{label :'Lastseen'},
    Unread:{label :'Unread'},
    Key:{label :'Key'},
    }

router.get('/', sessionChecker, function(req, res, next) {
    parameter = {
        session: req.session,
        cookies: req.cookies,
        resource: appresource,
        dateFormat: dateFormat,
        statusCode:100,
        statusMessage:'',        
        record:{username:'',
        subscription:'',
        jid:'',
        nickname:'',
        joindate:'',
        show:'',
        status:'',
        lastseen:'',
        unread:'',
        key:'',
        }
    }
    res.render('AppContactNewPage',parameter);
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
    dao.newAppContact(jsonObj,function(err,rows) {
        if(err==null){
            parameter.statusCode = 200;
            parameter.statusMessage = 'Successfully created';
        }else{
            parameter.statusCode = err.code;
            parameter.statusMessage = err.message;
        }
        parameter.record = jsonObj;
        res.render('AppContactNewPage',parameter);
        console.log(parameter);        
    });
});

module.exports = router;
