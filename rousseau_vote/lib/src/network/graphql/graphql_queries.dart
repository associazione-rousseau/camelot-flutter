String listPolls = '''
query listPolls(\$after: String) {
	pollsConnection(orderAttribute: show_starting_date, orderDirection: DESC, first: 20, after: \$after) {
		nodes {
		  id
		  slug
		  title
		  status
		  pollEntityType
		  alreadyVoted
		  showStartingDate
		  voteStartingDate
		  voteEndingDate
		  announcementLink
      resultsLink
      alerts {
        message
        path
      }
		}
		pageInfo {
            hasNextPage
            endCursor
        }
	}
}
''';

String profileDetail = '''
query profileDetail(\$id: ID!) {
    user(id: \$id) {
        id
        slug
        accountType
        fullName
        gender
        isSubscripted
        subscriptionCount
        userPublicSubscriptions(first: 3) {
            nodes {
                id
                slug
                fullName
                profile {
                    picture {
                        originalUrl
                    }
                }
            }
            totalCount
            
        }
        profile {
          $_profileFields
        }
        participations {
            nodes {
                event {
                    title
                    typology
                    startsAt
                    endsAt
                }
                geographicalScope {
                    name
                }
                staff
            }
        }
        resumeDocument {
            files {
                originalUrl
            }
        }
        badges {
            code
            active
        }
        userPositions {
            description
            position {
                code
                name
                type
            }
            geographicalScope {
                name
            }
            startsAt
            endsAt
        }
        tirendiconto {
            value
            isOk
            lastMonth
        }
        category {
            id
            name
            code
        }
        tags {
            id
            code
            name
            parent {
                code
            }
        }
    }
}
''';

String positions = '''
query positions {
  positions {
    code
    name
    type
    __typename
  }
}
''';

String profileSearch = '''
query profileSearch(
    \$fullName: String,
    \$badges: [[String!]!],
    \$tagCodes: [String!],
    \$categoryCodes: [String!],
    \$positionCodes: [String!],
    \$countryCode: String,
    \$italianGeographicalDivisionCode: String,
    \$italianGeographicalDivisionType: ItalianGeographicalDivisionTypes,
    \$after: String
) {
    profiles(
        first: 24,
        fullName: \$fullName,
        badges: \$badges,
        tagCodes: \$tagCodes,
        categoryCodes: \$categoryCodes,
        positionCodes: \$positionCodes,
        italianGeographicalDivisionCode: \$italianGeographicalDivisionCode,
        italianGeographicalDivisionType: \$italianGeographicalDivisionType,
        countryCode: \$countryCode
        after: \$after
    ) {
        nodes {
            id
            slug
            fullName
            gender
            profile {
                age
                placeOfBirth
                placeOfResidence {
                    comuneName
                    countryName
                    countryCode
                }
                picture {
                    originalUrl
                }
            }
            badges {
                active
                code
            }
        }
        pageInfo {
            hasNextPage
            endCursor
        }
    }
}
''';

String profileSearchShort = '''
query profileSearch(
    \$fullName: String,
    \$first: Int,
    \$badges: [[String!]!],
    \$tagCodes: [String!],
    \$categoryCodes: [String!],
    \$positionCodes: [String!],
    \$countryCode: String,
    \$italianGeographicalDivisionCode: String,
    \$italianGeographicalDivisionType: ItalianGeographicalDivisionTypes,
    \$after: String
) {
    profiles(
        first: \$first,
        fullName: \$fullName,
        badges: \$badges,
        tagCodes: \$tagCodes,
        categoryCodes: \$categoryCodes,
        positionCodes: \$positionCodes,
        italianGeographicalDivisionCode: \$italianGeographicalDivisionCode,
        italianGeographicalDivisionType: \$italianGeographicalDivisionType,
        countryCode: \$countryCode
        after: \$after
    ) {
        nodes {
            id
            slug
            fullName
            profile {
                placeOfResidence {
                    comuneName
                    countryName
                    countryCode
                    overseaseCity
                }
                picture {
                    originalUrl
                }
            }
        }
    }
}
''';

String countrySearch = '''
query countries(\$search: String) {
  countriesConnection(search: \$search) {
    nodes {
      id
      name
      code
    }
  }
}
''';

String _profileFields = '''
  age
  placeOfBirth
  placeOfResidence {
      comuneName
      countryName
      countryCode
      overseaseCity
  }
  picture {
      originalUrl
  }
  presentation
  curriculumVitae
  curriculumActivist
  politicalExperiences
  studyCourse
  qualification
  yearOfGraduation
  educationalInstitute
  languageLevels {
      language {
          code
          name
      }
      level
  }
  socialLinks {
      social {
          code
      }
      url
  }
''';

String pollDetail = '''
  query pollDetail(\$pollId: ID!, \$first: Int, \$after: String, \$fullName: String, \$badges: [[String!]!]) {
    poll(id: \$pollId) {
      id
      slug
      title
      status
      description
      pollEntityType
      alreadyVoted
      showStartingDate
      voteStartingDate
      voteEndingDate
      announcementLink
      resultsLink
      optionType
      maxSelectableOptionsNumber
      optionsConnection(first: \$first, after: \$after, fullName: \$fullName, badges: \$badges) {
        pageInfo {
          startCursor
          endCursor
          hasNextPage
          hasPreviousPage
        }
        totalCount
        nodes {
          id
          __typename
          ...on TextOption {
            text
          }
          ...on EntityOption {
            entity {
              __typename
              ...on User {
                id
                slug
                fullName
                profile {
                  age
                  placeOfResidence {
                    comuneName
                    provinciaName
                    overseaseCity
                  }
                  picture {
                    originalUrl
                  }
                }
                badges {
                  code
                  active
                  name
                }
              }
            }
          }
        }
       }
    }
  }
''';

String currentUserShort = '''
  query currentUser {
   currentUser {
    id 
    slug
    fullName
    subscriptionCount
    voteRightStartingCountDate
    verified
    createdAt
    statusColor
    overseaseCity
    profile {
        picture {
            originalUrl
        }
        placeOfResidence {
            comuneName
            overseaseCity
        }
    }
    badges {
        code
        active
    }
    municipio{
      code
      name
    }
    comune{
      code
      name
    }
    provincia{
      code
      name
    }
    regione{
      code
      name
    }
    country{
      code 
      name
    }
  }
}
''';

String currentUserFull = '''
  query currentUser {
   currentUser {
    id 
    slug
    firstName
    fullName
    lastName
    subscriptionCount
    overseaseCity
    gender
    placeOfBirth
    dateOfBirth
    email
    codiceFiscale
    phoneNumber
    voteRightStartingCountDate
    verified
    createdAt
    noLocalEventsEmail
    noNationalEventsEmail
    noNewsletterEmail
    noRousseauEventsEmail
    noSms
    noVoteEmail
    badges {
        id
        name
        code
        active
    }
    activeUserPositions{
        position{
            id
            name
            description
            code
        }
        geographicalScope{
          id
          code
        }
    }
    comune{
      code
      name
    }
    provincia{
      code
      name
    }
    regione{
      code
      name
    }
    municipio{
      code
      name
    }
    country{
      code 
      name
    }
    profile {
        $_profileFields
    }
    identityVerificationRequests(last: 15){
			nodes {
        id
        updatedAt
        documents {
          fileType
          originalUrl
        }
        status
        rejectionReason
      }
    }
  }
}
''';

String currentUserResidence = '''
query currentUser {
  currentUser {
    slug
    overseaseCity
    comune{
      code
      name
    }
    provincia{
      code
      name
    }
    regione{
      code
      name
    }
    municipio{
      code
      name
    }
    country{
      code 
      name
    }
    lastResidenceChangeRequest{
      comune{
          code
          name
      }
      country{
          code
          name
      }
      municipio{
          code
          name
      }
      provincia{
          code
          name
      }
      regione{
          code
          name
      }
      rejectionReason
      status
    }
  }
}
''';

String subscriptionAdd = '''
mutation subscriptionAdd(\$subscriptionableId: ID!) {
    user {
        subscriptionAdd(subscriptionableId: \$subscriptionableId) {
            errors
        }
    }
}
''';

String subscriptionDelete = '''
mutation subscriptionDelete(\$subscriptionableId: ID!) {
    user {
        subscriptionDelete(subscriptionableId: \$subscriptionableId) {
            errors
        }
    }
}
''';

String italianGeographicalDivisions = '''
query italianGeographicalDivisions(
    \$after:String,
    \$before:String,
    \$first:Int,
    \$last:Int,
    \$orderAttribute:ItalianGeographicalDivisionOrderAttributes,
    \$orderDirection:OrderDirection,
    \$search:String,
    \$name:String,
    \$code:String,
    \$type:ItalianGeographicalDivisionTypes,
    \$parentType: ItalianGeographicalDivisionTypes,
    \$parentCode: String
){
 italianGeographicalDivisions(
     after: \$after,
     before: \$before
     first:\$first,
     last:\$last,
     orderAttribute:\$orderAttribute,
     orderDirection: \$orderDirection,
     search:\$search,
     name:\$name,
     code:\$code,
     type:\$type,
     parentType: \$parentType,
     parentCode: \$parentCode
 ){
    nodes{
      id
      name
      code
      type
      descendants {
        name
        code
      }
    }
  }
}
''';

String italianGeographicalDivisionsSearch = '''
query italianGeographicalDivisions(
    \$after:String,
    \$before:String,
    \$first:Int,
    \$last:Int,
    \$orderAttribute:ItalianGeographicalDivisionOrderAttributes,
    \$orderDirection:OrderDirection,
    \$search:String,
    \$name:String,
    \$code:String,
    \$type:ItalianGeographicalDivisionTypes,
    \$parentType: ItalianGeographicalDivisionTypes,
    \$parentCode: String
){
 italianGeographicalDivisions(
     after: \$after,
     before: \$before
     first:\$first,
     last:\$last,
     orderAttribute:\$orderAttribute,
     orderDirection: \$orderDirection,
     search:\$search,
     name:\$name,
     code:\$code,
     type:\$type,
     parentType: \$parentType,
     parentCode: \$parentCode
 ){
    nodes{
      id
      name
      code
      type
    }
  }
}
''';

String countries = '''
query countries{
  countries {
    name
    code
  }
}
''';