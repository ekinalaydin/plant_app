const amplifyconfig = ''' {
  "UserAgent": "aws-amplify-cli/2.0",
  "Version": "1.0",
  "auth": {
    "plugins": {
      "awsCognitoAuthPlugin": {
        "IdentityManager": {
          "Default": {}
        },
        "CredentialsProvider": {
          "CognitoIdentity": {
            "Default": {
              "PoolId": "[COGNITO IDENTITY POOL ID]",
              "Region": "[REGION]"
            }
          }
        },
        "CognitoUserPool": {
          "Default": {
            "PoolId": "eu-central-1_41ntRZ00T",
            "AppClientId": "58a15vau1i6jpap7h2qi9m5kc6",
            "AppClientSecret": "17cftjmit77hovam627nkge8us7h2jqief64aieaid4155hntgls",
            "Region": "eu-central-1"
          }
        },
        "Auth": {
          "Default": {
            "authenticationFlowType": "USER_SRP_AUTH",
            "OAuth": {
              "WebDomain": "https://plantapp.auth.eu-central-1.amazoncognito.com",
              "AppClientId": "58a15vau1i6jpap7h2qi9m5kc6",
              "AppClientSecret": "17cftjmit77hovam627nkge8us7h2jqief64aieaid4155hntgls",
              "SignInRedirectURI": "[CUSTOM REDIRECT SCHEME AFTER SIGN IN, e.g. myapp://]",
              "SignOutRedirectURI": "[CUSTOM REDIRECT SCHEME AFTER SIGN OUT, e.g. myapp://]",
              "Scopes": [
                "phone",
                "email",
                "openid",
                "profile",
                "aws.cognito.signin.user.admin"
              ]
            }
          }
        }
      }
    }
  }
}''';
