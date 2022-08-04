import * as functions from "firebase-functions";
import * as admin from "firebase-admin";
import {DocumentReference,
  QuerySnapshot,
  DocumentSnapshot,
} from "@google-cloud/firestore";
admin.initializeApp();

const db = admin.firestore();

export const newFollower = functions.firestore
    .document("/users/{id}/follower/{fid}")
    .onCreate(async (snapshot, context) => {
      const follower = snapshot.data();
      const useref = _getRef(context.params.id, "users");
      db.collection("/users/"+context.params.id.toString()+"/messages/").
          add(_addMessage(follower.user, "follow", "added"));
      _incrementMessageCount(useref);
      _incrementFollowerCount(useref);
      db.collection("users").doc(context.params.id).
          update({followerCount: admin.firestore.FieldValue.increment(1),
            messageCount: admin.firestore.FieldValue.increment(1)});
    });
export const addSocials = functions.firestore
    .document("/users/{id}/socials/{docid}")
    .onCreate(async (snapshot, context) => {
      const id = context.params.id;
      const userref:DocumentReference = _getRefByString("/users/"+id);
      _informFollower(userref, _addMessage(
          userref, "socials",
          snapshot.data().type
      ));
    });

export const addStory = functions.firestore
    .document("/users/{id}/stories/{docid}")
    .onCreate(async (snapshot, context) => {
      const id = context.params.id;
      const docid = context.params.docid;
      const userref:DocumentReference = _getRefByString("/users/"+id);
      const storyref:DocumentReference =
        _getRefByString("/users/"+id+"/stories/"+docid);
      const x = [storyref];
      _informFollower(userref, _addMessage(
          userref, "story",
          snapshot.data().title,
          x,
      ));
    });

export const addLikeToStory = functions.firestore
    .document("/users/{id}/stories/{docid}/likes/{lid}")
    .onCreate(async (snapshot, context) => {
      const id = context.params.id;
      const docid = context.params.docid;
      const storyref:DocumentReference =
        _getRefByString("/users/"+id+"/stories/"+docid);
      storyref.update({likeCount: admin.firestore.FieldValue.increment(1)});
    });


export const removeLikeToStory = functions.firestore
    .document("/users/{id}/stories/{docid}/likes/{lid}")
    .onDelete(async (snapshot, context) => {
      const id = context.params.id;
      const docid = context.params.docid;
      const storyref:DocumentReference =
        _getRefByString("/users/"+id+"/stories/"+docid);
      storyref.update({likeCount: admin.firestore.FieldValue.increment(-1)});
    });


export const addLikeToMessage = functions.firestore
    .document("*/message/{docid}/likes/{lid}")
    .onDelete(async (snapshot, context) => {
      const id = context.params.id;
      const docid = context.params.docid;
      const storyref:DocumentReference =
        _getRefByString("/users/"+id+"/stories/"+docid);
      storyref.update({likeCount: admin.firestore.FieldValue.increment(-1)});
    });

export const addMessage = functions.firestore
    .document("/users/{id}/chats/{cid}/messages/{mid}")
    .onCreate(async (snapshot, context) => {
      const currentUserid = context.params.id;
      const mid = context.params.mid;
      const cid = context.params.cid;
      const uid = context.params.id;
      const userref:DocumentReference = _getRef(currentUserid, "users");
      const chatref:DocumentReference =
        _getRefByString("/users/"+uid+"/chats/"+cid);
      const messageref:DocumentReference =
        _getRefByString("/users/"+uid+"/chats/"+cid+"/messages/"+mid);
      const fromref:DocumentSnapshot = await messageref.get();
      const x = [chatref, messageref];
      userref.collection("messages")
          .add(_addMessage(
              fromref.data()?.from, "message", "chat", x));
    });
/**
* finds documentreference
* @param {String} id id of document.
* @param {String} collection id of document.
* @return {DocumentReference} the documentreference.
*/
function _getRef(id:string, collection:string) {
  return db.collection(collection).doc(id);
}

/**
* finds documentreference
* @param {String} id id of document.
* @return {DocumentReference} the documentreference.
*/
function _getRefByString(id:string) {
  return db.doc(id);
}


/**
* finds documentreference
* @param {DocumentReference} ref ref.
* @param {String} collection ref.
* @return {CollectionReference} the documentreference.
*/
function _getRefCollection(ref:DocumentReference, collection:string) {
  return ref.collection(collection);
}

/**
* @return {Time} the documentreference.
*/
function _getTime() {
  return admin.firestore.FieldValue.serverTimestamp();
}

/**
* finds documentreference
* @param {DocumentReference} ref ref.
* @param {String} info  info.
* @param {String} type type.
* @param {Array} optional type.
* @return {String} type type.
*/
function _addMessage(ref:DocumentReference,
    info:string,
    type:string,
    optional:any[]=[]) {
  return {from: ref,
    info: info,
    type: type,
    read: false,
    time: _getTime(),
    active: true,
    optional: optional,
  };
}
/**
* @constructor
* @param {DocumentReference} userref ref.
*/
function _incrementMessageCount(userref:DocumentReference) {
  userref.update({
    messageCount: admin.firestore.FieldValue.increment(1),
  });
}
/**
* @constructor
* @param {DocumentReference} userref ref.
*/
function _incrementFollowerCount(userref:DocumentReference) {
  userref.update({
    followerCount: admin.firestore.FieldValue.increment(1),
  });
}
/**
/**
*
* @param {DocumentReference } ref ref.
* @param {DocumentReference } userref userref.
* @param {String } type type.
* @return {QuerySnapshot } hfghf ref.

function _queryIfSocialIsPresent(ref:DocumentReference,
    userref:DocumentReference,
    type:string) {
  return ref.collection("messages").
      where("from", "==", userref).
      where("info", "==", "socials").
      where("type", "==", type).
      get();
}
**/
/**
* @param {DocumentReference } userref ref.
* @param {any} message
* @void
*/
function _informFollower(userref:DocumentReference, message:any) {
  _getRefCollection(userref, "follower").
      get().then((e: QuerySnapshot) => {
        e.docs.forEach(async (followerqu:DocumentSnapshot) => {
          if (followerqu.data()!==undefined) {
            const follower = followerqu?.data();
            if ( follower?.active!=="undefined") {
              if ( follower?.active==true) {
                console.log(follower.user.id);
                follower.user.collection("messages").
                    add(message);
                _incrementMessageCount(follower.user);
              }
            }
          }
        });
      });
}
