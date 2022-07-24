import * as functions from "firebase-functions";
import * as admin from "firebase-admin";

admin.initializeApp();

const db = admin.firestore();


export const newFollower = functions.firestore
    .document("follower/{id}")
    .onCreate(async (snapshot) => {
      const follower = snapshot.data();
      const id1 = follower.from;
      console.log(id1);
      const id2 = follower.to;
      const userRef = db.collection("users").doc(id2);
      userRef.collection("follower").add(follower);
      userRef.update({follower_count: admin.firestore.FieldValue.increment(1)});
      userRef.update({messages_count: admin.firestore.FieldValue.increment(1)});
      const time = admin.firestore.FieldValue.serverTimestamp();
      await userRef.get().then(async () =>
        db.collection("users")
            .doc(id2).collection("messages").add({
              from: id1,
              to: id2,
              info: "follow",
              read: false,
              time: time,
            })
      );
    });

export const changedSocial = functions.firestore
    .document("users/{id}/socials/{docid}")
    .onCreate(async (snapshot, context) => {
      const ref = snapshot.data();
      const time = admin.firestore.FieldValue.serverTimestamp();
      db.collection("follower").
          where("to", "==", context.params.id.toString()).
          get().then((e) => {
            e.docs.forEach(async (f) => {
              if (f.data().active==true) {
                db.collection("users")
                    .doc(f.data().from).collection("messages").add({
                      from: context.params.id,
                      to: f.data().from,
                      info: "added" + ref.value,
                      read: false,
                      time: time,
                    });
              }
            });
          });
    });

export const changedOutfit = functions.firestore
    .document("users/{id}/outfit/{docid}")
    .onCreate(async (snapshot, context) => {
      const ref = snapshot.data();
      const time = admin.firestore.FieldValue.serverTimestamp();
      db.collection("follower").
          where("to", "==", context.params.id.toString()).
          get().then((e) => {
            e.docs.forEach(async (f) => {
              if (f.data().active==true) {
                db.collection("users")
                    .doc(f.data().from).collection("messages").add({
                      from: context.params.id,
                      to: f.data().from,
                      info: "Outfit" + ref.value,
                      read: false,
                      time: time,
                    });
              }
            });
          });
    });
export const addedStory = functions.firestore
    .document("users/{id}/story/{docid}")
    .onCreate(async (snapshot, context) => {
      const time = admin.firestore.FieldValue.serverTimestamp();
      db.collection("follower").
          where("to", "==", context.params.id.toString()).
          get().then((e) => {
            e.docs.forEach(async (f) => {
              if (f.data().active==true) {
                db.collection("users")
                    .doc(f.data().from).collection("messages").add({
                      from: context.params.id,
                      to: f.data().from,
                      info: "new story",
                      read: false,
                      time: time,
                    });
              }
            });
          });
    });
