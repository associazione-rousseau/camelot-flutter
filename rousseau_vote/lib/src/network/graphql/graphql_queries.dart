String listPolls = '''
  query listPolls {
    polls(orderAttribute: show_starting_date, orderDirection: DESC) {
      slug
      id
        status
        alreadyVoted
        description
        voteEndingDate
        voteStartingDate
        showStartingDate
        optionType
        title
          resultsLink
          announcementLink
        alerts {
          message
        }
    }
  }
''';