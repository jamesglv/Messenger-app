const functions = require("firebase-functions");
const admin = require("firebase-admin");

admin.initializeApp();

exports.inboundSMS = functions.https.onRequest(async(req, res) => {

    let senderNum = req.body["From"];
    let recipientNum = req.body["To"];

    admin.database().ref("/users").orderByChild("phoneNum").equalTo(recipientNum).on("value", function(snapshot) {
        if (snapshot.exists()) {
            let recipientEmail = admin.database().ref("/users").orderByChild("phoneNum").equalTo(recipientNum).parent().child("email")
            return admin.database().ref().push(recipientEmail);
        }else{
            console.log("doesn't exist");
            let recipientEmail = "Hello Again"
            return admin.database().ref().push(recipientEmail);
          }
        });



    let params;

    if (Object.keys(req.query).length === 0) {
        params = req.body;
        
    } else {
        params = req.query;
    }

    return admin.database().ref(`/to${recipientNum}from${senderNum}/messages`).push(params);
    res.sendStatus(200);
});

