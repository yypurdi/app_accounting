# Accounting
Accounting Application <br />
<br />
<img src="https://user-images.githubusercontent.com/15040338/80907470-afcc1680-8d41-11ea-8750-1af9fe9144e2.jpg" width="15%"></img> 
<br />
Base Functions : <br />
1. Chart of Account <br />
2. Customer <br />
3. Product <br />
4. Bank <br />
<br />
Additional Funcations : <br />
<br />
1. Messaging <br />
2. Video Conference for Agent Meeting (WFH or Remote Work) <br />
3. Customer Line for Customer Interactive by Video Call (for next implementation : customer face recognation) <br />
<br />
Requirement : <br />
<br />
1. Install MySQL Server and load file import.sql (for DB Simulation) <br />
2. Install MQTT Broker (the default using mqtt://test.mosquitto.org) <br />
3. Change configuration in file cx_replication/routes/dao.js for MySQL DB access <br />
4. Change configuration in file cx_replication/routes/dao.js for MQTT Broker address <br />
5. Change Security Certificate in directory cx_replication/encryption (Optional) <br />
<br />
Run: <br />
<br />
  $npm install <br />
  $npm start <br />
<br />
Try WebApps : https://[ip_address]:3000 <br />
<br />
Username : admin <br />
Password : password <br />
<br />
Try Restfull : https://[ip_address]:3001/api-docs/ <br />
<br />

