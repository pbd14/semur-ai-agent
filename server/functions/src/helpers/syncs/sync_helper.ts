import {CombinedFilterAction, FilterAction} from "@nangohq/node/dist/types";
import {SyncStatus} from "../../models.pb/syncs/sync";
import {SyncFilter} from "../../models.pb/semur-engine/syncs-engine/sync_engine";

export class SyncHelper {
    static convertSyncFiltersToFilterAction(syncFilter: SyncFilter[]): FilterAction | CombinedFilterAction | undefined {
        const filterStrings: FilterAction[] = [];
        syncFilter.forEach((filter) => {
            switch (filter) {
                case SyncFilter.ADDED:
                    filterStrings.push("added");
                    break;
                case SyncFilter.UPDATED:
                    filterStrings.push("updated");
                    break;
                case SyncFilter.DELETED:
                    filterStrings.push("deleted");
                    break;
            }
        });

        if (filterStrings.length == 0) {
            return undefined;
        } else if (filterStrings.length == 1) {
            return filterStrings[0];
        } else {
            return filterStrings.join(",") as CombinedFilterAction;
        }
    }

    static convertSyncStatusToString(status: SyncStatus): string {
        switch (status) {
            case SyncStatus.PENDING:
                return "PENDING";
            case SyncStatus.IN_PROGRESS:
                return "IN_PROGRESS";
            case SyncStatus.COMPLETED:
                return "COMPLETED";
            case SyncStatus.FAILED:
                return "FAILED";
            case SyncStatus.PARTIALLY_COMPLETED:
                return "PARTIALLY_COMPLETED";
            default:
                return "UNKNOWN";
        }
    }
}
