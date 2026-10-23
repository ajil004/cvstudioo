export default {
  async fetch(request, env, ctx) {
    // Route all incoming HTTP requests to Cloudflare Workers Static Assets
    // with Single-Page-Application (SPA) fallback to index.html
    return env.ASSETS.fetch(request);
  },
};
