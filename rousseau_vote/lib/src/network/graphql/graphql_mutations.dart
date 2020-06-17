String pollAnswerSubmit = '''
  mutation pollAnswerSubmit(\$pollId: ID!, \$optionIds: [ID!]!) {
    user {
      pollAnswerSubmit(pollId: \$pollId, optionIds: \$optionIds) {
			  errors
		  }
    }
  }
''';

String userAccessDataUpdate =
    '''mutation userAccessDataUpdate(\$user:UpdateAccessDataUserInput!){
user{
userAccessDataUpdate(user:\$user){
errors
user{
email
phoneNumber
}
}
}
}''';
