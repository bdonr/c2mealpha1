import * as functions from "firebase-functions";
import * as admin from "firebase-admin";

admin.initializeApp();

const db = admin.firestore();


export const newFollower = functions.firestore
    .document("users/{id}/follower/{fid}")
    .onCreate(async (snapshot, context) => {
      const follower = snapshot.data();
      const useref = follower.user.id;
      console.log(useref);
      const time = admin.firestore.FieldValue.serverTimestamp();
      db.collection("users/"+context.params.id+"/messages/").
          add({
            from: follower.user,
            info: "follow",
            read: false,
            time: time,
          });
    });
export const deleteFollow = functions.firestore
    .document("users/{id}/follower/{fid}")
    .onDelete(async (snapshot, context) => {
      const follower = snapshot.data();
      const useref = follower.user;
      console.log(useref);
      const x = await db.collection("users/"+context.params.id.toString+
      "/messages/").
          where("info", "==", "follow").
          where("from", "==", follower.user).get();
      if (x!=null) {
        x.docs.forEach(async (f) => {
          console.log(f.data().id);
          f.data().delete();
        });
      } else {
        console.log("empty");
      }
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
