String pollAnswerSubmit = '''
  mutation pollAnswerSubmit(\$pollId: ID!, \$optionIds: [ID!]!) {
    user {
      pollAnswerSubmit(pollId: \$pollId, optionIds: \$optionIds) {
			  errors
		  }
    }
  }
''';

String tokenAdd = '''
mutation tokenAdd(\$tokenString: String!, \$client: String!) {
    user {
      tokenAdd(tokenString: \$tokenString, client: \$client) {
			  errors
		  }
    }
  }
''';

String tokenRemove = '''
mutation tokenRemove(\$tokenString: String!) {
    user {
      tokenRemove(tokenString: \$tokenString) {
			  errors
		  }
    }
  }
''';

String userFeedbackSubmit = '''
mutation userFeedbackSubmit(\$category: String!,\$feedback: String!){
    user{
        userFeedbackSubmit(category:\$category,feedback:\$feedback){
          errors
          success
        }
    }
}
''';