import {createMcpClient, GenkitMcpClient} from "@genkit-ai/mcp";
import {StreamableHTTPClientTransport} from "@modelcontextprotocol/sdk/client/streamableHttp.js";
import {Genkit, ToolAction} from "genkit";

export class NangoMcp {
    private transport: StreamableHTTPClientTransport;
    private client: GenkitMcpClient;

    constructor(
        nangoSecret: string,
        connectionId: string,
        providerConfigKey: string,
    ) {
        this.transport = new StreamableHTTPClientTransport(new URL("https://api.nango.dev/mcp"), {
            requestInit: {
                headers: {
                    "Authorization": `Bearer ${nangoSecret}`,
                    "connection-id": connectionId,
                    "provider-config-key": providerConfigKey,
                },
            },
        });

        this.client = createMcpClient({
            name: `nango-${providerConfigKey}`,
            mcpServer: {transport: this.transport},
        });
    }

    async ready(): Promise<void> {
        await this.client.ready();
    }

    async tools(ai: Genkit): Promise<ToolAction[]> {
        return await this.client.getActiveTools(ai);
    }

    async close() {
        await this.client.disable();
        await this.transport.close();
    }
}
