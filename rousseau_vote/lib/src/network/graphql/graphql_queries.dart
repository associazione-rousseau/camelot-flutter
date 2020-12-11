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
        badges {
            code
            active
        }
        category {
            code
        }
        tags {
            code
        }
        gender
        firstName
        fullName
        lastName
        userPositions {
            description
            geographicalScope {
                name
                type
            }
            position {
                code
                type
                name
            }
            startsAt
            endsAt
        }
        profile {
            $_profileFields
        }
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

String _profileFields = '''
  presentation
  curriculumActivist
  curriculumVitae
  yearOfGraduation
  educationalInstitute
  studyCourse
  englishLevel
  frenchLevel
  germanLevel
  spanishLevel
  qualification
  politicalExperiences
  facebookProfile
  twitterProfile
  linkedinProfile
  age
  placeOfBirth
  placeOfResidence {
      comuneName
      overseaseCity
  }
  picture {
      originalUrl
  }
  curriculumVitaeDocument {
      originalUrl
  }
  italiaCinqueStelleVolunteerFlag
  italiaCinqueStelleVolunteer
  listRepresentativeFlag
  listRepresentativeYear
  listRepresentativeComune
  opendayParticipantFlag
  opendayParticipant
  spokesmanM5sFlag
  spokesmanM5sYear
  spokesmanM5sInstitution
  villaggioRousseauParticipantFlag
  villaggioRousseauParticipant
  villaggioRousseauVolunteerFlag
  villaggioRousseauVolunteer
  approvedCandidatures {
      availableForFrontRunning
      poll {
          title
          features {
              frontRunners
              frontRunnersLabel
          }
      }
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

String countries = '''
query countries{
  countries {
    name
    code
  }
}
''';