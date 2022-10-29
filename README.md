# flutter_web_bridge

Example library of Flutter Web Bridge to communicate with mobile app through WebView.

This is an implementation on Flutter Web.

### Quick technical summary

- Receive events from mobile (webview) by adding a custom event listener(s) on `window`.
- Trigger events on mobile (webview) through javascript channels. Mobile webview **must** register this channels.
