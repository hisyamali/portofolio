import { defineConfig } from "vite";
import laravel from "laravel-vite-plugin";
import vue from "@vitejs/plugin-vue";

const isLocal = process.env.APP_ENV === "local";
const base = isLocal ? "/" : process.env.APP_URL ? new URL(process.env.APP_URL).origin + "/" : "/";

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
    base,
    ...(isLocal
        ? {} // If local, do not configure the server
        : {
              server: {
                  // Force HTTPS in non-local environments (optional)
                  https: true,
                  host: "0.0.0.0", // Ensure server is accessible over the network
              },
          }),
});
