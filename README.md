# camelot-flutter
[![Contributor Covenant](https://img.shields.io/badge/Contributor%20Covenant-v2.0%20adopted-ff69b4.svg)](code-of-conduct.md)  
Cross platform Flutter application to subscribe and vote on [Rousseau](https://www.washingtonpost.com/world/europe/with-online-poll-italy-moves-closer-to-formation-of-a-new-government/2019/09/03/2e6f50de-ce6a-11e9-a620-0a91656d7db6_story.html). Rousseau is the e-voting platform of the 5 Stars MoVement, one of the main Italian Parties. Given its social impact, this app will be implemented in crowdsourcing allowing everyone to contribute. This is also a social experiment: trying to build something so relevant and impactful only with voluntary contributions.

## Scope
The goal of this first wave is to build a voting app. The functionality we are interested in implementing are:
1. Login
1. Registration
1. Edit Profile
1. ID documents upload
1. Polls listing
1. Voting (text options)
1. Notification (and deeplink handling)
1. [Stretch goal] Voting with candidate entities

## Backend
We are relying on the current backend used by the webapp (single page application) and on our [keycloak](https://www.keycloak.org/) server as a single sign on. This is the SSO root url: https://sso.rousseau.movimento5stelle.it. Keycloak uses the Open ID Connect protocol. For more info about the login and registration flow, refer to the [official guide](https://www.keycloak.org/docs/latest/securing_apps/index.html). For the login we are using a secret client. 

The backend is a graphql API written in rails, that exposes only one endpoint for all the queries: https://api.rousseau.movimento5stelle.it/graphql. Queries are provided in this codebase.

### Send Notifications
To send notifications the backend has to add the field `click_action = FLUTTER_NOTIFICATION_CLICK`. It's possible to add the optional parameter `route` as one of the ROUTE_NAME you can find on each screen. E.g.: `route = /polls`

## Finding something to work on
In the [project canvas](https://github.com/associazione-rousseau/camelot-flutter/projects/1) there is a list of open issues to work on and discussions to contribute. It also includes UX/Design tasks that won't require any programming skills. Everyone is free to grab an issue and solve it, to file new issues and to propose new features or improvements of the existing ones. This project and codebase are public and all the information and history are available to everyone.

## Coding patterns
- We are using the provider pattern, watching [this video](https://www.youtube.com/watch?v=d_m5csmrf7I) is a must!
- We are using Dependency Injection with [injectable](https://pub.dev/packages/injectable). Familiarize with the design pattern and add your class to RegisterModule when possible. We want to avoid direct invocation of the constructors at least for important objects.
- Run `flutter pub run build_runner watch --delete-conflicting-outputs` if you plan to change compile time generated classes. For example, you'll need it if you want to add a new injected class.

## Submitting your PR
For the PR flow we are referring to [this flow](https://gist.github.com/Chaser324/ce0505fbed06b947d962). In order to be considered, PR have to be written in english, pass all the tests and pass all the lint checks. For substantial UI changes you should add a screenshot to the PR. In order to be merged, they have to be approved by an owner.

## Encryption
Secrets (non critical) are encrypted in the codebase using [git-crypt](https://github.com/AGWA/git-crypt). Those are mainly configuration files (Sentry DSN, Apple/Google notifications keys). Although not critical, they are encrypted in the codebase. Developers will not be able to decrypt them, but this does not prevent any critical feature just error reporting and notifications. This will trigger warnings when starting the app that can easily be ignored (e.g.: firebase/apple services first connection). Lead developers and the github bot have the keys to decode those files. The github pipeline is able to decrypt the files and include them in the executable for iOS and Android.
