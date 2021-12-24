import hashlib
import os
import sys
import time
from rauth import OAuth2Service

client_id = 'NEjAViaya1siVUyCew1hnrsz'
secret = 'sec_JvGhfUDNkny27kAGeOLIV61eOCG4I4GjaaL9LIPtKDxTwLLLXQg1LMjYoXDWY5NvzZRZ2EFMtXmJFX0d'

service = OAuth2Service(
    client_id=client_id,  # your App ID from https://wakatime.com/apps
    client_secret=secret,  # your App Secret from https://wakatime.com/apps
    name='wakatime',
    authorize_url='https://wakatime.com/oauth/authorize',
    access_token_url='https://wakatime.com/oauth/token',
    base_url='https://wakatime.com/api/v1/')

redirect_uri = 'https://wakatime.com/oauth/test'
state = hashlib.sha1(os.urandom(40)).hexdigest()
params = {'scope': 'email,read_stats',
          'response_type': 'code',
          'state': state,
          'redirect_uri': redirect_uri}

url = service.get_authorize_url(**params)

print('**** Visit this url in your browser ****'.format(url=url))
print('*' * 80)
print(url)
print('*' * 80)
print('**** After clicking Authorize, paste code here and press Enter ****')
code = input('Enter code from url: ')

# Make sure returned state has not changed for security reasons, and exchange
# code for an Access Token.
headers = {'Accept': 'application/x-www-form-urlencoded'}
print('Getting an access token...')
session = service.get_auth_session(headers=headers,
                                   data={'code': code,
                                         'grant_type': 'authorization_code',
                                         'redirect_uri': redirect_uri})

print('Getting current user from API...')
user = session.get('users/current').json()
print('Authenticated via OAuth as {0}'.format(user['data']['email']))
print("Getting user's coding stats from API...")
stats = session.get('users/current/stats')
print(stats.text)

result = session.post("users/current/heartbeats",
                      data={
                          'entity': '/Users/linzizhuan/racket.tw/drracket-wakatime/wakatime.rkt',
                          'time': time.time()
                      })
print(result.text)
