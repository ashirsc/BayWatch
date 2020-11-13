import * as functions from 'firebase-functions';
import admin from 'firebase-admin'
import moment from 'moment';
import { GetFileMetadataResponse } from '@google-cloud/storage';
admin.initializeApp();



// // Start writing Firebase Functions
// // https://firebase.google.com/docs/functions/typescript
//

export const uploadPicture = functions.https.onRequest(async (request: functions.https.Request, response: functions.Response) => {



    if (request.body.data === null || request.body.data === undefined) {
        response.statusCode = 400
        response.send('Please include the image in the body.data of the request')
        return
    }

    const storageBucket = admin.storage().bucket()
    const imageData: Buffer = Buffer.from(request.body.data)


    // renamve old picture
    const latestPic = await storageBucket.file('SpotPics/latest.jpeg')
    const latestPicMetadata: GetFileMetadataResponse = await latestPic.getMetadata()
    const createdAt = latestPicMetadata[0]["timeCreated"]
    const oldPicData = (await latestPic.download())[0]
    console.log(oldPicData);
    await storageBucket.file(`SpotPics/${createdAt}.jpeg`).save(oldPicData, { contentType: 'image/jpeg', public: true })



    await storageBucket.file(`SpotPics/latest.jpeg`).save(imageData, { contentType: 'image/jpeg', public: true })


    response.sendStatus(200)

})


export const statusUpdate = functions.https.onRequest(async (request, response) => {
    const spotStatus = request.path.split('/')[1]
    if (spotStatus == "") {
        response.statusCode = 400
        response.send("Please provide a status as the first path parameter")
    }

    const data = {
        ts: new admin.firestore.Timestamp(Math.floor(Date.now() / 1000), 0),
        status: spotStatus
    };

    await admin.firestore().collection('status').doc().set(data);

    response.sendStatus(200);
});

export const status = functions.https.onRequest(async (request, response) => {

    let historyRef = admin.firestore().collection("status").orderBy('ts', 'desc')
    const lastStatus = await (await historyRef.limit(1).get()).docs[0].data()


    lastStatus.happened = moment(lastStatus.ts._seconds * 1000).fromNow()


    response.send(lastStatus);
});
