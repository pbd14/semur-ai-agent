import {SyncMode} from "../../models.pb/syncs/sync";

export class NangoSyncsHelper {
    static convertSyncModeToString(syncMode: SyncMode): "incremental" | "full_refresh" | "full_refresh_and_clear_cache" | undefined {
        switch (syncMode) {
            case SyncMode.INCREMENTAL:
                return "incremental";
            case SyncMode.FULL_REFRESH:
                return "full_refresh";
            case SyncMode.FULL_REFRESH_AND_CLEAR_CACHE:
                return "full_refresh_and_clear_cache";
            case SyncMode.UNRECOGNIZED:
            default:
                return undefined;
        }
    }
}
