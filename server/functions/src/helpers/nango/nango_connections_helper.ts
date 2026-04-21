import {AgentCategory} from "../../models.pb/agents/agent";
import {IntegrationIds} from "../../runtime/integration_ids";

export class NangoConnectionsHelper {
    static agentCategoriesFromNangoIntegrationId(nangoIntegrationId: string): AgentCategory[] {
        const mapping: { [key: string]: AgentCategory[] } = {
            [IntegrationIds.googleMail]: [AgentCategory.EMAIL, AgentCategory.GENERAL],
            [IntegrationIds.googleCalendar]: [AgentCategory.CALENDAR, AgentCategory.GENERAL],
            [IntegrationIds.outlookMail]: [AgentCategory.EMAIL, AgentCategory.GENERAL],
        };
        return mapping[nangoIntegrationId] || [];
    }
}
