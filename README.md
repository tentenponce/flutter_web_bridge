# flutter_web_bridge

Example library of Flutter web bridge to communicate with mobile app through WebView.

- Flutter mobile implementation and demo: https://github.com/tentenponce/flutter_mobile_bridge
- Actual website: https://flutter-jsbridge.web.app/#/

### Note:
**Website will not function properly** because it assumes that it is inside a mobile app that handles its events.

### Quick technical summary

- Receive events from mobile (webview) by adding custom event listener(s) on `window`.
- Trigger events on mobile (webview) through javascript channels. Mobile webview **must** register this channels.
