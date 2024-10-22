import { defineConfig } from "vite";
import laravel from "laravel-vite-plugin";
import vue from "@vitejs/plugin-vue";

export default defineConfig({
    plugins: [
        laravel({
            input: "resources/js/app.js",
            // ssr: 'resources/js/ssr.js',
            refresh: true,
        }),
        vue({
            template: {
                transformAssetUrls: {
                    base: null,
                    includeAbsolute: false,
                },
            },
        }),
    ],
    // Ensure base is relative to load assets correctly in production
    base: process.env.APP_URL ? new URL(process.env.APP_URL).origin + "/" : "/",
    server: {
        // Force HTTPS in development (optional, based on your setup)
        HTTPS: true,
        host: "0.0.0.0", // Ensure server is accessible over network
    },
});
