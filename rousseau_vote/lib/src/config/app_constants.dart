library constants;

const String APP_NAME = 'Rousseau Vote';
const String TOOLBAR_TITLE = APP_NAME;
const bool USE_NATIVE_LOGIN = true;

// Login configuration
const String KEYCLOAK_CLIENT_ID = 'camelot-flutter';
const String KEYCLOAK_REDIRECT_URI = 'http://localhost';

const String KEYCLOAK_URL_LOCAL = 'http://10.0.2.2:8081';
const String KEYCLOAK_URL_PRODUCTION = 'https://sso.rousseau.movimento5stelle.it';
const String KEYCLOAK_URL = KEYCLOAK_URL_PRODUCTION;

const String GRAPHQL_URL_LOCAL = 'http://10.0.2.2:3000/graphql';
const String GRAPHQL_URL_PRODUCTION = 'https://api.rousseau.movimento5stelle.it/graphql';
const String GRAPHQL_URL = GRAPHQL_URL_PRODUCTION;

const String IN_APP_BROWSER_USER_AGENT = 'camelot-flutter';