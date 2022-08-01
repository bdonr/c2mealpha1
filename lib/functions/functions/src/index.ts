import * as functions from "firebase-functions";
import * as admin from "firebase-admin";
admin.initializeApp();

const db = admin.firestore();

export const newFollower = functions.firestore
    .document("/users/{id}/follower/{fid}")
    .onCreate(async (snapshot, context) => {
      const follower = snapshot.data();
      const useref = follower.user.id;
      console.log(useref);
      const time = admin.firestore.FieldValue.serverTimestamp();
      db.collection("/users/"+context.params.id.toString()+"/messages/").
          add({
            from: follower.user,
            info: "follow",
            read: false,
            active: true,
            time: time,
          });
      db.collection("users").doc(context.params.id).
          update({followerCount: admin.firestore.FieldValue.increment(1),
            messageCount: admin.firestore.FieldValue.increment(1)});
    });
export const addSocials = functions.firestore
    .document("/users/{id}/socials/{docid}")
    .onCreate(async (snapshot, context) => {
      const time = admin.firestore.FieldValue.serverTimestamp();
      db.collection("users").doc(context.params.id.toString())
          .collection("follower").
          get().then((e) => {
            e.docs.forEach(async (f) => {
              if (f.data().active==true) {
                f.data().user.collection("messages").add({
                  from: f.data().user,
                  info: ["x", "y"],
                  read: false,
                  time: time,
                  active: true,
                });
              }
            });
          });
    });

