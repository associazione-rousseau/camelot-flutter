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
      alerts {
        message
      }
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