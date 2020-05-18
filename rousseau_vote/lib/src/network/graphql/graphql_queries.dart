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
    email
    codiceFiscale
    phoneNumber
    voteRightStartingCountDate
    verified
    createdAt
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