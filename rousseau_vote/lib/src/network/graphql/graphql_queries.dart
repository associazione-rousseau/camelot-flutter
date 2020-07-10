String listPolls = '''
  query listPolls {
    polls(orderAttribute: show_starting_date, orderDirection: DESC) {
      id
      slug
      title
      status
      alreadyVoted
      showStartingDate
      voteStartingDate
      voteEndingDate
      announcementLink
      resultsLink
      alerts {
        message
      }
    }
  }
''';

String pollDetail = '''
  query pollDetail(\$pollId: ID!) {
    poll(id: \$pollId) {
      id
      slug
      title
      status
      description
      alreadyVoted
      showStartingDate
      voteStartingDate
      voteEndingDate
      announcementLink
      resultsLink
      optionType
      maxSelectableOptionsNumber
      options {
        id
        ...on TextOption {
          text
        }
        ...on EntityOption {
          entity {
            ...on User {
              id
              slug
              fullName
              profile {
                picture {
                  originalUrl
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
    profile {
        picture {
            originalUrl
        }
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
    profile {
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
        otherLanguages
        qualification
        politicalExperiences
        facebookProfile
        twitterProfile
        linkedinProfile
        italiaCinqueStelleVolunteer
        italiaCinqueStelleVolunteerFlag
        villaggioRousseauVolunteer
        villaggioRousseauVolunteerFlag
        listRepresentativeFlag
        listRepresentativeYear
        listRepresentativeComune
        spokesmanM5sFlag
        spokesmanM5sYear
        spokesmanM5sInstitution
        opendayParticipantFlag
        opendayParticipant
        villaggioRousseauParticipant
        villaggioRousseauParticipantFlag
        picture {
            originalUrl
        }
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
          id
          code
          name
          type
      }
    }
  }
}
''';
