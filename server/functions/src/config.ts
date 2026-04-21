import {getFirestore} from "firebase-admin/firestore";

export class SemurEngineConfig {
    static isDev = false;
    static dbId = this.isDev ? "semur-dev" : "(default)";
    static db = this.isDev ? getFirestore(SemurEngineConfig.dbId): getFirestore();
}
