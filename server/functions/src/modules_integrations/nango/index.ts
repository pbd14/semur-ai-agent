const registerLazyExport = (name: string, loader: () => unknown) => {
    Object.defineProperty(exports, name, {
        configurable: true,
        enumerable: true,
        get: loader,
    });
};

registerLazyExport(
    "userConnections",
    // eslint-disable-next-line @typescript-eslint/no-require-imports
    () => require("./user_connections").userConnections,
);
registerLazyExport(
    "sessionToken",
    // eslint-disable-next-line @typescript-eslint/no-require-imports
    () => require("./nango").sessionToken,
);
registerLazyExport(
    "webhook",
    // eslint-disable-next-line @typescript-eslint/no-require-imports
    () => require("./nango").webhook,
);
