library constants;

import 'package:flutter/material.dart';

const String APP_NAME = 'Rousseau X';
const String TOOLBAR_TITLE = APP_NAME;
const bool USE_NATIVE_LOGIN = true;

const bool LOCAL_ENV = bool.fromEnvironment('LOCAL_ENV', defaultValue: false);

// Login configuration
const String KEYCLOAK_CLIENT_ID = 'camelot-flutter';
const String KEYCLOAK_REDIRECT_URI = 'http://localhost';

const String ROUSSEAU_URL_LOCAL = 'http://10.0.2.2:8080';
const String ROUSSEAU_URL_PRODUCTION = 'https://vote.rousseau.movimento5stelle.it';
const String ROUSSEAU_URL = ROUSSEAU_URL_PRODUCTION;
const String ROUSSEAU_VOTE_URL = ROUSSEAU_URL_PRODUCTION + '/polls';
const String ROUSSEAU_EDIT_PROFILE_URL = ROUSSEAU_URL + '/profile';
const String ROUSSEAU_PUBLIC_PROFILE_URL = 'https://rousseau.movimento5stelle.it/profiles/detail';

const String EVENT_PORTAL_URL = 'https://partecipa.ilblogdellestelle.it';

const String BLOG_COVER_IMAGE_PLACEHOLDER = 'https://s3-eu-west-3.amazonaws.com/ilblogdellestelle-img/wp-content/uploads/2018/05/27115011/placeholder-650x350.jpg';

const String KEYCLOAK_URL_LOCAL = 'http://localhost:8081';
const String KEYCLOAK_URL_PRODUCTION = 'https://sso.rousseau.movimento5stelle.it';
const String KEYCLOAK_URL = LOCAL_ENV ? KEYCLOAK_URL_LOCAL : KEYCLOAK_URL_PRODUCTION;

const String KEYCLOAK_LOGIN_URL = '$KEYCLOAK_URL/auth/realms/rousseau';
const String KEYCLOAK_REGISTRATION_URL =
    '$KEYCLOAK_URL/auth/realms/rousseau/protocol/openid-connect/registrations?'
    'client_id=camelot-frontend&'
    'redirect_uri=https%3A%2F%2Frousseau.movimento5stelle.it%2F&'
    'response_mode=fragment&'
    'response_type=code&'
    'scope=openid';

const String RESET_PASSWORD = '$KEYCLOAK_URL/auth/realms/rousseau/login-actions/reset-credentials?client_id=$KEYCLOAK_CLIENT_ID';

const String API_URL_LOCAL = 'http://localhost:3000';
const String API_URL_PRODUCTION = 'https://api.rousseau.movimento5stelle.it';
const String API_URL = LOCAL_ENV ? API_URL_LOCAL : API_URL_PRODUCTION;
const String GRAPHQL_URL = '$API_URL/graphql';

const String FILE_UPLOAD_URL_PRODUCTION = 'https://api.rousseau.movimento5stelle.it/files/direct_uploads';

const String IN_APP_BROWSER_USER_AGENT = 'camelot-flutter';

// Blog instant article config
const String BLOG_URL = 'https://www.ilblogdellestelle.it';
const int DEFAULT_ARTICLES_PER_PAGE = 10;

//colors
const Color PRIMARY_RED = Color(0xFFE30613);
const Color ACCENT_RED = Color(0xFFFF7A82);
const Color SECONDARY_YELLOW = Color(0xFFFFD600);
const Color BACKGROUND_GREY = Color(0xFFECEFF1);
const Color DISABLED_GREY = Color(0xFFD3D3D3);

const Color OPEN_GREEN = Color(0xFF46B29C);
const Color CLOSED_RED = Color(0xFFDF5D4B);
const Color VOTED_BLUE = Color(0xFF2AA2DA);
const Color PUBLISHED_ORANGE = Color(0xFFE78853);

//images
const AssetImage WHITE_LOGO = AssetImage('assets/images/rousseau_white.png');
const AssetImage RED_LOGO = AssetImage('assets/images/rousseau_red_beta.png');