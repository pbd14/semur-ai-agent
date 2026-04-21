import {ToolConfig} from "@genkit-ai/ai";
import {Genkit} from "genkit";
import {SemurEngineLogger} from "./semur_engine";
import {nanoid} from "nanoid";
import {SemurEngineEventType} from "./semur_engine_types";
import {ChatMessage, ChatRole, ChatSession} from "../models.pb/chats/chat";
import {AgentChatService} from "../services/agent_chat_service";
import {AgentTool} from "../models.pb/agents/agent";
import {AgentChatHelper} from "../helpers/agent_chat_helper";

// WARN: Disable no-explicit-any for ToolConfig usage
/* eslint-disable @typescript-eslint/no-explicit-any */
export class SemurEngineAiToolSDK {
    public ai: Genkit;
    public config: ToolConfig<any, any>;
    public fn: (...args: any[]) => Promise<any>;
    public session: ChatSession;
    public tool: AgentTool;
    public requestId: string;
    public logger: SemurEngineLogger;
    public onError?: () => any;
    public storeAsMessage: boolean;

    constructor(
        ai: Genkit,
        config: ToolConfig<any, any>,
        fn: (...args: any[]) => Promise<any>,
        session: ChatSession,
        tool: AgentTool,
        onError?: () => any,
        storeAsMessage = true,
    ) {
        this.ai = ai;
        this.config = config;
        this.fn = fn;
        this.session = session;
        this.tool = tool;
        this.requestId = nanoid(10); // Generate a short unique ID for the request
        this.logger = new SemurEngineLogger(config.name, this.requestId);
        this.onError = onError;
        this.storeAsMessage = storeAsMessage;
    }

    public getTool() {
        return this.ai.dynamicTool(
            this.config,
            async (input) => {
                try {
                    this.logger.customLogEvent(this.config.name + ":triggered",
                        SemurEngineEventType.INFO,
                        {
                            input: input,
                        });
                    const output = await this.fn(input);

                    // Store the tool usage message
                    if (this.storeAsMessage) {
                        try {
                            // Store output only if it's not too large by size
                            let storedOutput;
                            let inputJson;
                            let outputJson;

                            try {
                                inputJson = JSON.stringify(input);
                            } catch (e) {
                                this.logger.warn("Failed to stringify tool input for storage", {e});
                                inputJson = undefined;
                            }

                            try {
                                outputJson = JSON.stringify(output).length > 1000 ? undefined : JSON.stringify(output);
                                storedOutput = JSON.stringify(output).length > 1000 ? undefined : output;
                            } catch (e) {
                                this.logger.warn("Failed to stringify tool output for storage", {e});
                                outputJson = undefined;
                            }

                            this.session.currentMessageIndex = await AgentChatService.addNewMessageToSession(
                                this.session.id,
                                this.session.userId,
                                ChatMessage.create({
                                    id: this.session.currentMessageIndex + 1,
                                    role: ChatRole.TOOL,
                                    author: AgentChatHelper.nameFromAgentTool(this.tool),
                                    content: AgentChatHelper.descriptionFromAgentTool(this.tool),
                                    output: storedOutput,
                                    toolName: this.config.name,
                                    toolRequestJson: inputJson,
                                    // Limit the size of the response to avoid Firestore limits
                                    toolResponseJson: outputJson,
                                    createdAt: new Date(),
                                }),
                            );
                        } catch (e) {
                            this.logger.warn("Failed to store tool usage as message in chat", {e});
                            this.logger.customLogEvent(this.config.name + ":firestore_error",
                                SemurEngineEventType.ERROR,
                                {
                                    error: e,
                                },
                            );
                        }
                    }

                    this.logger.customLogEvent(this.config.name + ":finished",
                        SemurEngineEventType.INFO,
                        {
                            output: output,
                        },
                    );

                    return output;
                } catch (e) {
                    this.logger.customLogEvent(this.config.name + ":error",
                        SemurEngineEventType.ERROR,
                        {
                            error: e,
                        },
                    );
                    if (this.onError) {
                        return this.onError();
                    } else {
                        throw e;
                    }
                }
            },
        );
    }
}

